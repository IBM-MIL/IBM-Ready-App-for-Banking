/*
 *    Licensed Materials - Property of IBM
 *    5725-I43 (C) Copyright IBM Corp. 2015. All Rights Reserved.
 *    US Government Users Restricted Rights - Use, duplication or
 *    disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/

package com.ibm.mil.ready.app.hatch.adapter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import com.google.gson.Gson;
import com.ibm.json.java.JSON;
import com.ibm.json.java.JSONArray;
import com.ibm.json.java.JSONObject;
import com.ibm.mil.ready.app.hatch.SBBAdapter;
import com.ibm.mil.ready.app.hatch.model.User;
import com.ibm.mil.ready.app.hatch.service.UserService;
import com.worklight.adapters.rest.api.WLServerAPI;
import com.worklight.adapters.rest.api.WLServerAPIProvider;
import com.worklight.core.auth.OAuthSecurity;

@Path("/")
public class SBBJavaAdapterResource {
	/*
	 * For more info on JAX-RS see https://jsr311.java.net/nonav/releases/1.1/index.html
	 */
		
	//Define logger (Standard java.util.Logger)
	static Logger logger = Logger.getLogger(SBBJavaAdapterResource.class.getName());

    //Define the server api to be able to perform server operations
    WLServerAPI api = WLServerAPIProvider.getWLServerAPI();

	private final Gson parser = new Gson();
	private static String defaultLocale = "en_US";
	private static UserService userService;

    
    
    public static void init() {
//    	javaAdapter = SBBAdapter.getInstance();
//		userService = UserService.getInstance();
    }
    
    
    /**
     * Test method so the client side folks can ensure MFP client is configured
     * properly.
     */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/test" */
	@GET
	@OAuthSecurity(enabled=false)
	@Path("/test")
	@Produces("application/json")
	public String hello(){
		//log message to server log
		logger.log(Level.INFO, "Client test ping...");
        JSONObject retObj = new JSONObject();
        retObj.put("isSuccessful", true);
        retObj.put("result", "Success");
    	try {
			return retObj.serialize();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return "Fatal error";
	}
		
		
    /* Path for method: "<server address>/GreenwellBanking/adapters/caasJava/authenticate" */
    @POST
    @OAuthSecurity(enabled=false)
    @Path("/authenticate")
    @Produces("application/json")
    public JSONArray authenticate (
    		@FormParam("username") String username,
    		@FormParam("password") String password) throws UnsupportedEncodingException {
    	logger.info("Authenticate " + username );
   
    	String ret = UserService.getInstance().verifyUser(username, password);
    	
    	logger.info("verifyUser returned " + ret);
    	
    	JSONArray retJson = new JSONArray();
		try {
			retJson = (JSONArray) JSON.parse(ret);
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return retJson;
    }

	/**
	 * Finds a user by username in the back end. Requires a username and a locale
	 * 
	 * @param username
	 *            The username of the user to find.
	 * @param locale
	 *            The locale of the client
	 * @returns boolean isSuccessful determining if the call was successful and a
	 *          result, if there was any
	 */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getUser/{username}" */
	@GET
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getUser/{username}")
	@Produces("application/json")
	public String getUser(@PathParam("username") String username) {
		logger.log(Level.INFO, "getUser username: " + username);

		String locale = getUserLocale();

		List<User> users = SBBAdapter.getInstance().getUser(username, locale);
		
		boolean success = (users != null);

        JSONObject retObj = new JSONObject();
        retObj.put("isSuccessful", success);
        retObj.put("result", parser.toJson(users));
    	try {
			return retObj.serialize();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return "Fatal error";

	}

	/**
	 * Returns the dashboard data for different business that the user owns.
	 * @returns dashboard json payload
	 */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getDashboardData" */
	@GET
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getDashboardData")
	@Produces("application/json")
	public String getDashboardData() {
		
		logger.log(Level.INFO, "getDashboardData");
		
		String activeUserId = getUserId();
		String locale = getUserLocale();
		
		String dashboardData = SBBAdapter.getInstance().getDashboardData(activeUserId, locale);

		return buildReturnValue(dashboardData);
	}

	/**
	 * Returns the solution from the Watson Tradeoff Service
	 * @param dilemma
	 * @returns solution
	 */		
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getTradeoffSolution?dilemma=value" */
	@POST
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getTradeoffSolution")
	@Produces("application/json")
	public String getTradeoffSolution(@FormParam("dilemma") String dilemma) {
		logger.log(Level.INFO, "getTradeoffSolution dilemma: " + dilemma);

		String solution = SBBAdapter.getInstance().getTradeoffSolution(dilemma);
		boolean success = solution == null ? false : true;
		logger.info("Watson solution: " + solution);
		logger.info("Watson success: " + success);
		
        return buildReturnValue(solution);
		
	}

	/**
	 * Finds the accounts associated with the given userId. If the userId does not
	 * exist, no accounts are returned.
	 * 
	 * @param userid
	 *            The userid of the logged in user.
	 * @param locale
	 *            The locale of the client
	 * @returns boolean isSuccessful determining if the call was successful and a
	 *          result, if there was any
	 */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getAccounts/{userId}" */
	@GET
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getAccounts/{userId}")
	@Produces("application/json")
	public String getAccounts(@PathParam("userId") String userId) {
		logger.log(Level.INFO, "getAccounts userId: " + userId);
		
		String activeUserId = getUserId();
		userId = userId == null ? null : activeUserId;

		String locale = getUserLocale();
		locale = locale == null ? defaultLocale : locale;

		String accounts = SBBAdapter.getInstance().getAccounts(activeUserId, locale);
		
    	return buildReturnValue(accounts);
	}

	/**
	 * Finds the Goals associated with the active userid. If the userid does not
	 * exist, or if it contains none, then return empty list.
	 * 
	 * @param locale
	 *            The locale of the client
	 * @returns boolean isSuccessful determining if the call was successful and a
	 *          result, if there was any
	 */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getGoals" */
	@GET
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getGoals")
	@Produces("application/json")
	public String Goals() {
		logger.log(Level.INFO, "getGoals");
		String activeUserId = getUserId();

		String locale = getUserLocale();
		locale = locale == null ? defaultLocale : locale;
		
		String goals = SBBAdapter.getInstance().getGoals(activeUserId, locale);
		
		return buildReturnValue(goals);
	}

	
	/**
	 * Gets all the transactions for a given account id
	 * 
	 * @param accountid
	 *            The id of the account whose transactions we need to get.
	 * @param locale
	 *            The locale of the client
	 * @returns boolean isSuccessful determining if the call was successful and a
	 *          result, if there was any
	 */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getTransactions/{accountId}" */
	@GET
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getTransactions/{accountId}")
	@Produces("application/json")
	public String getTransactions(@PathParam("accountId") String accountId) {
		logger.log(Level.INFO, "getTransactions accountId: " + accountId);
		accountId = accountId == null ? null : accountId;

		String locale = getUserLocale();
		locale = locale == null ? defaultLocale : locale;

		String transactions = SBBAdapter.getInstance().getTransactions(accountId, locale);

		return buildReturnValue(transactions);
	}

	/**
	 * Bank account offers
	 * @returns offers
	 */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getOffers" */
	@GET
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getOffers")
	@Produces("application/json")
	public String getOffers() {
		logger.log(Level.INFO, "getOffers");
		
		String offers = SBBAdapter.getInstance().getOffers();
		
		return buildReturnValue(offers);
	}


	/**
	 * Gets the feasibility of the new goal based off the existing cash flow and existing goals.
	 * 
	 * @param userId
	 *            The id of the user who is adding the new goal.
	 * @param businessId
	 *            The id of the business where we want to add the new goal
	 * @param newGoal
	 *            The new goal whose feasibility we want to check
	 * @param existingGoals
	 *            The set of existing goals for the user and business.
	 * @returns boolean isSuccessful determining if the call was successful and a
	 *          result, if there was any
	 */
	/* Path for method: "<server address>/HatchReadyApp/adapters/SBBJavaAdapter/getFeasibility?userId=value&businessId=value" */
	@POST
	@OAuthSecurity(scope="ReadyAppHatchAuthRealm")
	@Path("/getFeasibility/")
	@Produces("application/json")
	public String getFeasibility(
			@QueryParam("userId") String userId,
			@QueryParam("businessId") String businessId,
			@FormParam("newGoal") String newGoal,
			@FormParam("existingGoals") String existingGoals
			) {

		logger.log(Level.INFO, "getFeasibility userId: " + userId + " businessId: " + businessId + " newGoal: " + newGoal + " existingGoals: " + existingGoals);

		String locale = getUserLocale();
		locale = locale == null ? defaultLocale : locale;

		String recommendations = SBBAdapter.getInstance().getFeasibility(userId, businessId, newGoal, 
				existingGoals, locale);
		logger.info(recommendations);
		boolean success = recommendations == null ? false : true;
		logger.info("success: " + success);
		
		return buildReturnValue(recommendations);

	}

	
	
	private String buildReturnValue(String list) {
		boolean success = (list == null) ? false : true;

        JSONObject retObj = new JSONObject();
        retObj.put("isSuccessful", success);
        retObj.put("result", list);
    	try {
			return retObj.serialize();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return "Fatal error";

	}

	private String getUserId() {
		String userId = SBBAdapter.getInstance().getCurrentUserId();
		logger.log(Level.INFO, "userId is " + userId);
		return userId;
	}
	
	private String getUserLocale() {
		String locale = SBBAdapter.getInstance().getCurrentUserLocale();
		logger.log(Level.INFO, "locale is " + locale);
		return locale;
	}
	
}
