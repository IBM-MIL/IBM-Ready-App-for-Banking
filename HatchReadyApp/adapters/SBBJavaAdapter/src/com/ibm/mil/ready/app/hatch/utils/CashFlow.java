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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.ibm.mil.ready.app.hatch.model.MonthBalance;

/**
 * The CashFlow object is intended to provide methods to quickly get a persons MONTLY cash flow.  By monthly cash
 * flow we mean what is the ending balance, in 30 day intervals, for each of the last N months, for each account.
 * 
 * In other words, this object keeps track of the monthly account balance for each of the users accounts, for some
 * specified amount of time. Usually this is determined by the amount of data it is given.
 *
 */
public class CashFlow {
	private final Map<String, List<MonthBalance>> flow = new HashMap<String, List<MonthBalance>>();
	private final Map<String, Double> averageCF = new HashMap<String, Double>();
	private int monthsOfCashFlow = 0;
	
	public int getMonthsOfData() {
		return this.monthsOfCashFlow;
	}
	public void setMonthsOfData(int months) {
		this.monthsOfCashFlow = months;
	}
	
	public boolean containsAccount(String accountId) {
		return flow.containsKey(accountId);
	}
	
	public void addMonthBalanceToAccount(String accountId, MonthBalance balance) {
		if (flow.containsKey(accountId)) {
			List<MonthBalance> list = flow.remove(accountId);
			list.add(balance);
			flow.put(accountId, list);
		} else {
			List<MonthBalance> list = new ArrayList<MonthBalance>();
			list.add(balance);
			this.addAccount(accountId, list);
		}
	}
	
	/**
	 * Adds an account with cash flow data to this cash flow object.
	 * 
	 * @param accountId The id of the account to add
	 * @param monthlyFlow The cash flow data to add for the given account.
	 */
	public void addAccount(String accountId, List<MonthBalance> monthlyFlow) {
		flow.put(accountId, monthlyFlow);
	}
	
	/**
	 * The list of accounts numbers for this user.
	 * 
	 * @return The list of account numbers for this user.
	 */
	public List<String> getAccounts() {
		return new ArrayList<String>(flow.keySet());
	}
	
	/**
	 * Returns a list of MonthBalance objects that represents the monthly cash flow for this account
	 * 
	 * @param acctId The id of the account we want the cash flow for.
	 * @return The list of monthly cash flow balances.
	 */
	public List<MonthBalance> getFlowForAccount(String acctId) {
		return flow.get(acctId);
	}
	
	/*
	 * (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new Gson().toJson(this);
	}
	
	/**
	 * Returns the average account balance for the account requested.  Basically takes all the monthly account balances
	 * that are stored and returns the average over the months listed.
	 * 
	 * @param account The account whose average balance we want.
	 * @return the average cash flow for that account.
	 */
	public double getAverageCashFlowForAccount(String account) {
		double average = 0;
		if (!averageCF.containsKey(account)) {
			double total = 0;
			List<MonthBalance> flowForAccount = flow.get(account);
			for (MonthBalance monthly : flowForAccount) {
				total += monthly.getBalance();
			}
			average = total / flowForAccount.size();
			averageCF.put(account, average);
		}

		average = averageCF.get(account);
		
		return average;
	}
}
