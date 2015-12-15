/* 
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
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
 * Pojo to represent a Transaction
 */
public class Transaction extends CloudantObject {
	private String account;
	private long date;
	private String transactionType;
	private Double amount;
	private String to;
	private String from;
	private String description;
	private String businessID;
	/**
	 * gets the account
	 * @return account
	 */
	public String getAccount() {
		return account;
	}
	/**
	 * sets the account
	 * @param account
	 */
	public void setAccount(String account) {
		this.account = account;
	}
	/**
	 * gets the date
	 * @return date
	 */
	public long getDate() {
		return date;
	}
	/**
	 * sets the date
	 * @param date
	 */
	public void setDate(long date) {
		this.date = date;
	}
	/**
	 * gets the transaction type
	 * @return transactionType
	 */
	public String getTransactionType() {
		return transactionType;
	}
	/**
	 * sets the transaction type
	 * @param transactionType
	 */
	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}
	/**
	 * gets the amount
	 * @return amount
	 */
	public Double getAmount() {
		return amount;
	}
	/**
	 * sets the amount
	 * @param amount
	 */
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	/**
	 * gets the 'to' field
	 * @return to
	 */
	public String getTo() {
		return to;
	}
	/**
	 * sets the 'to' field
	 * @param to
	 */
	public void setTo(String to) {
		this.to = to;
	}
	/**
	 * gets the 'from' field
	 * @return from
	 */
	public String getFrom() {
		return from;
	}
	/**
	 * sets the 'from' field
	 * @param from
	 */
	public void setFrom(String from) {
		this.from = from;
	}
	/**
	 * gets the description
	 * @return description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * sets the description
	 * @param description
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * gets the businessID
	 * @return businessID
	 */
	public String getBusinessID() {
		return businessID;
	}
	/**
	 * sets the businessID
	 * @param businessID
	 */
	public void setBusinessID(String businessID) {
		this.businessID = businessID;
	}
	/**
	 * converts the data object into a JSON object 
	 */
	public String toString() {
		return new Gson().toJson(this);
	}
}
