/* 
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

package com.ibm.mil.ready.app.hatch.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import com.ibm.mil.ready.app.hatch.model.Account;
import com.ibm.mil.ready.app.hatch.model.Business;
import com.ibm.mil.ready.app.hatch.model.GroupObject;
import com.ibm.mil.ready.app.hatch.service.CloudantService;
import com.ibm.mil.ready.app.hatch.service.MessageService;

/**
 * Utils class for HatchDBService. It contains all the helper functions
 * that make Cloudant queries, parse, and construct JSON objects to return to the
 * client.
 */
public class HatchDBUtilities {
	private static final Logger LOGGER = Logger
			.getLogger(HatchDBUtilities.class.getSimpleName());
	private final static MessageService messages = MessageService.getInstance();

	/**
	 * returns the Cloudant view data for account balance
	 * 
	 * @param userId
	 * @param locale
	 * @return List of account balances
	 */
	public List<GroupObject> getAccountBalance(CloudantService cs,
			String userId, String locale) {
		List<GroupObject> acctBalancePerMonth = null;
		acctBalancePerMonth = cs.getGroupedDataWithComplexKey(
				"hatch_main_design/dashboard", cs.getKeys(userId,
						Constants.LOWER_STRING_BOUND,
						Constants.LOWER_STRING_BOUND), cs.getKeys(userId,
						Constants.UPPER_STRING_BOUND,
						Constants.UPPER_STRING_BOUND), GroupObject.class);

		return acctBalancePerMonth == null ? null : acctBalancePerMonth;
	}

	/**
	 * Gets average Cloudant view for monthly spending on goals per business
	 * 
	 * @param businessId
	 * @param locale
	 * @return list of projected monthly goal spending
	 */
	@SuppressWarnings("PMD.ConfusingTernary")
	public Double getMonthlyProjectedGoals(CloudantService cs,
			String businessId, String locale) {
		List<GroupObject> monthlyGoalSpending = null;

		monthlyGoalSpending = cs.getGroupedDataWithComplexKey(
				"hatch_main_design/goalxmonth2", 
				cs.getKeys(businessId, Constants.LOWER_STRING_BOUND, Constants.LOWER_STRING_BOUND), 
				cs.getKeys(businessId,Constants.UPPER_STRING_BOUND,Constants.UPPER_STRING_BOUND  ), GroupObject.class);

		double total = 0.0;
		double average = 0.0;
		if (monthlyGoalSpending != null) {
			for (GroupObject go : monthlyGoalSpending) {
				total = total + (Double) go.getValue();
			}
			average = total / monthlyGoalSpending.size();
		} else {
			LOGGER.warning(MessageService.getInstance().getMessage("MSG0001"));
			return 0.0;
		}
		return average;

	}

	/**
	 * Gets the Cloudant view data for average monthly spending
	 * 
	 * @param businessId
	 * @param locale
	 * @return list of projected monthly spending grouped by categories
	 */
	public List<GroupObject> getMonthlyProjectedTransactions(
			CloudantService cs, String businessId, String locale) {
		List<GroupObject> monthlyTransactions = null;

		monthlyTransactions = cs.getGroupedDataWithComplexKey(
				"hatch_main_design/monthly-spending",
				cs.getKeys(businessId, Constants.LOWER_STRING_BOUND, 0),
				cs.getKeys(businessId, Constants.UPPER_STRING_BOUND, 0),
				GroupObject.class);

		return monthlyTransactions == null ? null : monthlyTransactions;
	}

	/**
	 * constructs the list of businesses with account and spending information
	 * for the dashboard
	 * @param cs
	 * @param businessAcctIdToAmount
	 * @param businessArray
	 * @param acctNames
	 * @param locale
	 * @return List<Business>
	 */
	public List<Business> constructBusinessList(CloudantService cs,
			Map<String, Double> businessAcctIdToAmount,
			List<Business> businessArray, Map<String, String> acctNames,
			String locale) {
		// iterate through the list of businesses and create a JSON object
		// to
		// send back to the client
		for (Business currBusiness : businessArray) {
			// account list to keep track of checking/saving/goal balance
			List<Account> accountList = new ArrayList<Account>();

			// account list to keep track of monthly projected spending
			List<Account> spending = new ArrayList<Account>();

			// temp account instance to populate the list
			Account goalAcct = new Account();

			// flag to ensure the Goal value is only added once
			boolean goalAdded = false;

			// iterate through the list of account names
			for (Map.Entry<String,String> acctEntry : acctNames.entrySet()	) {
				String acctKey = acctEntry.getKey();

				// go through each account and add to account balance
				if (businessAcctIdToAmount.containsKey(acctKey
						+ currBusiness.getId())) {
					Account tempAcct = new Account();

					// sets the name, balance, and id for the account
					tempAcct.setName(acctNames.get(acctKey));
					tempAcct.setBalance(businessAcctIdToAmount.get(acctKey
							+ currBusiness.getId()));
					tempAcct.setId(acctKey);
					accountList.add(tempAcct);
				}
				if (businessAcctIdToAmount.containsKey(Constants.GOALS
						+ currBusiness.getId())
						&& !goalAdded) {

					// sets the goal, balance, and id for the business
					goalAcct.setName(Constants.GOALS);
					goalAcct.setBalance(businessAcctIdToAmount
							.get(Constants.GOALS + currBusiness.getId()));
					goalAcct.setId("");
					accountList.add(goalAcct);
					goalAdded = true;
				}

			}
			// set the account balance for the current business
			currBusiness.setAccountList(accountList);
			// get the monthly project spending for the business
			spending = getMonthlyProjectedSpending(cs, currBusiness.getId(),
					locale);
			// set the spending list for the current business
			currBusiness.setSpendingList(spending);
		}

		return businessArray;
	}

	/**
	 * calculates and constructors the monthly spending list for a business
	 * 
	 * @param businessId
	 * @param locale
	 * @return monthly spending list
	 */
	public List<Account> getMonthlyProjectedSpending(CloudantService cs,
			String businessId, String locale) {
		List<Account> spendingList = new ArrayList<Account>();
		Account goalsAcct = new Account();
		try {
			// set the goals spending average
			goalsAcct.setName(Constants.GOALS);
			Double goalsAmount = ((Double) getMonthlyProjectedGoals(cs,
					businessId, locale));
			goalsAcct.setBalance(goalsAmount);
			goalsAcct.setId("");
			spendingList.add(goalsAcct);

			// get the list of monthly transactions
			List<GroupObject> monthlyTransactions = getMonthlyProjectedTransactions(
					cs, businessId, locale);

			// iterate through the list of monthly transactions and add them
			// to the list
			for (GroupObject go : monthlyTransactions) {
				Account transactionAcct = new Account();

				@SuppressWarnings("unchecked")
				List<String> keys = (List<String>) go.getKey();

				// set the category and the average monthly spending
				transactionAcct.setId("");
				transactionAcct.setName(keys.get(1));
				transactionAcct.setBalance((Double) go.getValue());
				spendingList.add(transactionAcct);
			}

		} catch (Exception ex) {
			LOGGER.warning(messages.getMessage("MSG0006",
					new Object[] { spendingList }));
			LOGGER.warning(messages.getMessage("MSG0005",
					new Object[] { ex.getMessage() }));
		}

		return spendingList;
	}

}
