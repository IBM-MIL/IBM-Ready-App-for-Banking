/* 
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

package com.ibm.mil.ready.app.hatch;

import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.Recommendation;
import com.ibm.mil.ready.app.hatch.model.User;
import com.ibm.mil.ready.app.hatch.service.FeasibilityService;
import com.ibm.mil.ready.app.hatch.service.HatchDBService;
import com.ibm.mil.ready.app.hatch.service.UserService;
import com.ibm.mil.ready.app.hatch.service.WatsonService;
import com.ibm.mil.ready.app.hatch.utils.CashFlow;
import com.ibm.mil.ready.app.hatch.utils.Constants;
import com.ibm.mil.ready.app.hatch.utils.Utilities;

/**
 * This class acts as an interface with the MFP JS adapter.
 * It contains all the functions that the adapter procedures invokes
 * and returns data to the client. 
 * Also creates compatibility for MFP 7.0 where 
 * adapter procedures have Java support.
 */
public final class SBBAdapter {
	public static final Object CREATE_LOCK = new Object();
	private static SBBAdapter adapter;
	private final HatchDBService dbService;
	private final UserService userService;
	private final WatsonService watsonService;
	private final Gson parser = new Gson();
	private final Utilities utils = new Utilities();
	
	private String currentUserId;
	private String currentUsername;
	private String currentUserLocale;
	
	public static final Logger LOGGER = Logger.getLogger(SBBAdapter.class.getName());
	
	/**
	 * Singleton instance
	 * @return SBBAdapter instance
	 */
	public static SBBAdapter getInstance() {
		synchronized(CREATE_LOCK) {
			if (adapter == null) {
				adapter = new SBBAdapter();
			}	
		}
		
		return adapter;
	}
	/* private constructor to ensure it remains a singleton.
	 */
	private SBBAdapter() {
		dbService = HatchDBService.getInstance();
		watsonService = WatsonService.getInstance();
		userService = UserService.getInstance();
	}
	
	/**
	 * returns the user object
	 * @param username
	 * @param locale
	 * @return user object
	 */
	public List<User> getUser(String username, String locale) {
		return userService.getUsers(username, locale);
	}
	/**
	 * returns the account info for a user
	 * @param usernid
	 * @param locale
	 * @return account information
	 */
	public String getAccounts(String usernid, String locale) {
		return dbService.getAccounts(usernid, locale);
	}
	
	/**
	 * returns the goals for a specific user
	 * @param userid
	 * @param locale
	 * @return goal object
	 */
	public String getGoals(String userid, String locale) {
		return dbService.getGoals(userid, locale);
	}
	/**
	 * Gets the list of offers from Cloudant
	 * @return The list of offers
	 */
	public String getOffers() {
		return dbService.getOffers();
	}
	
	/**
	 * returns the transactions for a specific account
	 * @param accountId
	 * @param locale
	 * @return transaction object
	 */
	public String getTransactions(String accountId, String locale) {
		return dbService.getTransactions(accountId, locale);
	}
	
	/**
	 * validates the user based on the credentials provided
	 * @param username
	 * @param password
	 * @return user object
	 */
	public String verifyUser(String username, String password){
		LOGGER.log(Level.INFO, "In SBBAdapter verifyUser");
		String userResponse = userService.verifyUser(username, password);
		
		JsonArray json = parser.fromJson(userResponse, JsonArray.class);
//		Object[] json = utils.parseObject(userResponse, Object[].class);
		try {
			if (json.get(0).getAsBoolean()) {
				this.currentUsername = username;
				this.currentUserLocale = json.get(1).getAsString();
				this.currentUserId = json.get(2).getAsJsonObject().get("_id").getAsString();
			}	
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return userResponse;
	}
		
	public String getCurrentUserId() {
		return this.currentUserId;
	}
	public String getCurrentUsername() {
		return this.currentUsername;
	}
	public String getCurrentUserLocale() {
		return this.currentUserLocale;
	}
	
	/**
	 * returns the dashboard data which contains the account and goal
	 * balances, as well as projected spending for the month
	 * @param userId
	 * @param locale
	 * @return list of business with account information
	 */
	public String getDashboardData(String userId, String locale){
		return dbService.getDashboardData(userId, locale);
	}
	/**
	 * Gets a Tradeoff Solution from the Watson Tradeoff Api
	 * @param dilemma The dilemma to send
	 * @return The Solution
	 */
	public String getTradeoffSolution(String dilemma) {
		try {
			return watsonService.getTradeoffSolution(dilemma);
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * Calculates and returns feasibility of a goal that the user
	 * wants to add
	 * @param userId
	 * @param businessId
	 * @param goal
	 * @param goals
	 * @param locale
	 * @return feasibility
	 */
	public String getFeasibility(String userId, String businessId, String goal,
			String goals, String locale) {

		List<Recommendation> options = null;
		try {
			Goal[] existingGoals = utils.parseObject(goals, Goal[].class);
			Goal newGoal = utils.parseObject(goal, Goal.class);
			newGoal.updateTimeLeft();
			if (newGoal.getBusinessID() == null || "".equals(newGoal.getBusinessID())) {
				newGoal.setBusinessID(businessId);
			}
			if (newGoal.getId() == null || "".equals(newGoal.getId())) {
				newGoal.setId(UUID.randomUUID().toString());
			}
			if (newGoal != null && existingGoals != null) {
				CashFlow cashFlow = dbService.getMonthlyCashFlow(userId,
						businessId, Constants.CASHFLOW_MONTHS);
				LOGGER.info("Cashflow: " + cashFlow);
				FeasibilityService fsbService = new FeasibilityService(
						cashFlow, newGoal, existingGoals);
				options = fsbService.getFeasibility();
				for(Recommendation r: options) {
					r.getGoal().updateTimeLeft();
					for(Goal g: r.getNewGoals()) {
						g.updateTimeLeft();
					}
				}
			}
		} catch (Exception e) {
			LOGGER.info(e.getMessage());
		}

		if (options == null) {
			return null;
		} else {
			return parser.toJson(options);
		}
	}
}
