/* 
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

package com.ibm.mil.ready.app.hatch.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import com.google.gson.Gson;
import com.ibm.mil.ready.app.hatch.model.Account;
import com.ibm.mil.ready.app.hatch.model.Business;
import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.GroupObject;
import com.ibm.mil.ready.app.hatch.model.MonthBalance;
import com.ibm.mil.ready.app.hatch.model.Offer;
import com.ibm.mil.ready.app.hatch.model.Transaction;
import com.ibm.mil.ready.app.hatch.utils.CashFlow;
import com.ibm.mil.ready.app.hatch.utils.Constants;
import com.ibm.mil.ready.app.hatch.utils.HatchDBUtilities;
import com.ibm.mil.ready.app.hatch.utils.Utilities;

/**
 *
 * This class communicates with Cloudant and returns relevant information for
 * the user who has been properly authenticated. The functions in this class
 * will be invoked via the MobileFirst Platform Adapters.
 */
public class HatchDBService {
	public static final Object CREATE_LOCK = new Object();
	private static HatchDBService dbservice;
	private final Gson jsonParser = new Gson();
	private final CloudantService cs = new CloudantService();

	// Logger class for logging output
	private static final Logger LOGGER = Logger.getLogger(HatchDBService.class
			.getSimpleName());
	private final static MessageService messages = MessageService.getInstance();
	private final Utilities utils = new Utilities();
	private final HatchDBUtilities hatchUtils = new HatchDBUtilities();

	/**
	 * Private constructor. Instantiates instances of cloudant and the message
	 * services.
	 */
	private HatchDBService() {
		super();
	}

	/**
	 * returns one and only one instance of the CloudantConnector class
	 * 
	 * @return CloudantConnector instance
	 */
	public static HatchDBService getInstance() {
		synchronized (CREATE_LOCK) {
			if (dbservice == null) {
				dbservice = new HatchDBService();
			}
		}

		return dbservice;
	}
	
	/**
	 * Returns the list of businesses for a specific user
	 * 
	 * @param businessId
	 * @param locale
	 * @return
	 */
	public List<Business> getBusiness(String businessId,
			String locale) {
		List<Business> businesses = null;

		if (businessId == null) {
			businesses = cs.getData("hatch_main_design/business",
					Business.class, true);
		} else if (utils.isSanitary(businessId)) {
			businesses = cs.getData("hatch_main_design/business", businessId,
					Business.class, true);
		}

		return businesses == null || businesses.isEmpty() ? null : businesses;
	}

	/**
	 * Returns the goals associated with this user. If the user does not exist
	 * or does not have goals then this method will return an empty list
	 * 
	 * @param userIdFilter
	 *            The user whose goals we want to retrieve
	 * @param locale
	 *            The locale of the client user.
	 * @return Either the goals associated with this user, or an empty list if
	 *         none are found or the user doesnt exist.
	 */
	public String getGoals(String userIdFilter, String locale) {
		List<Goal> goals = null;
		if (utils.isSanitary(userIdFilter, locale)) {

			goals = cs.getDataWithComplexKey("hatch_main_design/goals",
					cs.getKeys(userIdFilter, 0),
					cs.getKeys(userIdFilter, Integer.MAX_VALUE), Goal.class,
					true);

			if (goals != null) {
				for (Goal g : goals) {
					g.setEnd(Utilities.convertTime(g.getEnd()));
					g.setStart(Utilities.convertTime(g.getStart()));
					g.setProgress((g.getSaved() / g.getGoalAmount()) * 100);
				}
			}
		}
		return (goals == null) ? null : jsonParser.toJson(goals);
	}

	/**
	 * returns the account offers provided by the bank
	 * 
	 * @return list of bank offers
	 */
	public String getOffers() {	
		List<Offer> offers = cs.getData("hatch_main_design/offers", Offer.class, true);

		if (offers == null || offers.isEmpty()) {
			return null;
		} else {
			return jsonParser.toJson(offers);
		}
	}

	/**
	 * Gets the accounts associated with the given userid. This method makes the
	 * assumption that a valid user will have at least one account. So will
	 * return either null (no accounts) or the list of accounts found. Returning
	 * null means that the MFP code will return a failure.
	 * 
	 * @param userIdFilter
	 *            The userid whose accounts we want to retrieve
	 * @param locale
	 *            The locale of the client user
	 * @return Either null if no accounts were found or the list of accounts
	 *         associated with the given user id.
	 */
	public String getAccounts(String userIdFilter, String locale) {
		List<Account> accounts = null;
		if (utils.isSanitary(userIdFilter, locale)) {

			accounts = cs.getData("hatch_main_design/accounts", userIdFilter,
					Account.class, true);
			/*
			 * For now we'll just set accounts to null if size == 0 as that
			 * means the user was bad. At this point I'm making the assumption
			 * that every user has at least one account. This way the front end
			 * folks know something went wrong (returning null sets the MFP call
			 * to failure.
			 */
			if (accounts.isEmpty()) {
				accounts = null;
			} else {
				for (Account acct : accounts) {
					/*
					 * Once we have our accounts, we do a reduce on each
					 * accounts transactions so we can get a current total
					 * balance. This means that each transaction needs to have
					 * negative numbers for withdrawals and positive for
					 * deposits.
					 */

					String balance = cs.getReducedData(
							"hatch_main_design/transactions", acct.getId());

					
					acct.setBalance(Double.parseDouble(balance));
				}
			}
		}

		if (accounts == null) {
			return null;
		} else {
			return jsonParser.toJson(accounts);
		}
	}

	/**
	 * Returns the transactions that belong to the given account id. If no
	 * transactions are found, we assume that an invalid account id was sent as
	 * each account should have at least a single transaction...the cash used to
	 * open the account.
	 * 
	 * @param accountIdFilter
	 *            The id of the account whose transactions we want to retrieve
	 * @param locale
	 *            The client locale
	 * @return Either null if no transactions were found, or the list of
	 *         transactions associated with this account.
	 */
	public String getTransactions(String accountIdFilter, String locale) {
		List<Transaction> transactions = null;
		if (utils.isSanitary(accountIdFilter, locale)) {

			transactions = cs.getData("hatch_main_design/transactions",
					accountIdFilter, Transaction.class, true);

			/*
			 * For now we'll just set accounts to null if size == 0 as that
			 * means there was none. At this point I'm making the assumption
			 * that every user has at least one transaction. This way the front
			 * end folks know something went wrong (returning null sets the MFP
			 * call to failure.
			 */
			if (transactions != null) {
				if (transactions.isEmpty()) {
					transactions = null;
				} else {
					for (Transaction trnx : transactions) {
						trnx.setDate(Utilities.convertTime(trnx.getDate()));
					}
				}
			}
		}
		if (transactions == null) {
			return null;
		} else {
			return jsonParser.toJson(transactions);
		}
	}

	/**
	 * This method returns the monthly cash flow
	 * 
	 * @param acctId
	 *            The account whose "monthly cash flow" we want to get
	 * @return List of @MonthBalance objects for the given account.
	 */
	@SuppressWarnings("unchecked")
	public CashFlow getMonthlyCashFlow(String ownerId, String businessId,
			int monthsOfCashFlow) {
		CashFlow flow = new CashFlow();
		flow.setMonthsOfData(monthsOfCashFlow);
		if (utils.isSanitary(ownerId)) {
			List<GroupObject> acctBalancePerMonth = cs
					.getGroupedDataWithComplexKey(
							"hatch_main_design/trnx-month", cs
									.getKeys(ownerId, businessId,
											Constants.LOWER_STRING_BOUND, 0),
							cs.getKeys(ownerId, businessId,
									Constants.UPPER_STRING_BOUND,
									monthsOfCashFlow), GroupObject.class);

			for (GroupObject go : acctBalancePerMonth) {
				try {
					String acctId = (String) ((List<Object>) go.getKey())
							.get(2);

					MonthBalance mb = new MonthBalance();
					mb.setMonth(((Double) ((List<Object>) go.getKey()).get(3))
							.intValue());
					mb.setBalance((Double) go.getValue());
					flow.addMonthBalanceToAccount(acctId, mb);
				} catch (Exception ex) {
					LOGGER.warning(messages.getMessage("MSG0006",
							new Object[] { go }));
					LOGGER.warning(messages.getMessage("MSG0005",
							new Object[] { ex.getMessage() }));
				}
			}
		}
		return flow;
	}

	/**
	 * Get the dashboard for each user and their businesses Returns the user's
	 * business and account information
	 * 
	 * @param userId
	 * @param locale
	 * @return dashboard json payload
	 */
	public String getDashboardData(String userId, String locale) {

		if (utils.isSanitary(userId)) {
			List<GroupObject> acctBalancePerMonth = hatchUtils
					.getAccountBalance(cs, userId, locale);

			// map with compound key for acctId+businessID and the amount
			Map<String, Double> businessAcctIdToAmount = new HashMap<String, Double>();

			// map to make acctId to the account name
			Map<String, String> acctNames = new HashMap<String, String>();

			// list of business with the account balance and projected spending
			// object
			List<Business> businessArray = new ArrayList<Business>();

			for (GroupObject go : acctBalancePerMonth) {
				@SuppressWarnings("unchecked")
				List<String> keys = (List<String>) go.getKey();
				if (keys.size() == 3) {
					if (keys.get(2).equals(Constants.GOALS)) {
						// goals keys, set the Goal along with the value
						businessAcctIdToAmount.put(
								Constants.GOALS + keys.get(1),
								(Double) go.getValue());
					} else {
						// transaction- compound key of acctID+businessId mapped
						// to the value
						businessAcctIdToAmount.put(keys.get(2) + keys.get(1),
								(Double) go.getValue());
					}

				} else if (keys.size() == 6) {
					// creates a business instance and sets all the business
					// attributes: ownerID, businessID, businessName,
					// businessDescription, tag, imageFile
					Business business = new Business(keys.get(0), keys.get(1),
							keys.get(2), keys.get(3), keys.get(5), keys.get(4));
					businessArray.add(business);
				} else {
					// this is an account, set the acctId as key and account
					// name as value (eg, 2001-Checking)
					acctNames.put(keys.get(2), keys.get(3));
				}
			}

			businessArray = hatchUtils.constructBusinessList(cs,
					businessAcctIdToAmount, businessArray, acctNames, locale);
			// if the businessArray is empty, we couldn't find any
			// account/goal/spending info, so return null
			if (businessArray.isEmpty()) {
				return null;
			}
			return jsonParser.toJson(businessArray);
		} else {
			return null;
		}

	}
};