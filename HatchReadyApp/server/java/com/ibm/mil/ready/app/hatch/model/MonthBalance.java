/* Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

 package com.ibm.mil.ready.app.hatch.model;

import com.google.gson.Gson;
/**
 * This class represents an object that will be used when figuring out the feasibility of a new Goal.  This is
 * in essence a tuple that consists of a month and a sum of all transactions that occurred within that month time frame.
 * The month is an integer, from 0 to infinity that represents the when the transaction took place. 0 means the
 *  total contained within the value field is the sum of all transaction that happened in the past month, or 
 *  to be more exact, that it happened within the last 30 days (here month always means 30 days, not actual 
 *  calendar days).  A 1 in the month field means the transactions occurred between 30 and 60 days, etc.
 *  
 *  As stated earlier, the "balance" field is the sum of all transactions that occurred within that 30 day period.
 */
public class MonthBalance {
	private int month;
	private double balance;
	/**
	 * gets the month
	 * @return month
	 */
	public int getMonth() {
		return month;
	}
	/**
	 * sets the month
	 * @param month
	 */
	public void setMonth(int month) {
		this.month = month;
	}
	/**
	 * gets the balance
	 * @return balance
	 */
	public double getBalance() {
		return balance;
	}
	/**
	 * sets the balance
	 * @param balance
	 */
	public void setBalance(double balance) {
		this.balance = balance;
	}
	/**
	 * converts the data object into a JSON object
	 */
	public String toString() {
		return new Gson().toJson(this);
	}
}
