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
 * Pojo to represent a bank account
 *
 */
public class Account extends CloudantObject {
	private String ownerID;
	private String accountName;
	private String accountType;
	private Double balance;
	private String businessID;
	private String name;
	/**
	 * returns the owner ID
	 * @return ownerID
	 */
	public String getOwnerID() {
		return ownerID;
	}
	/**
	 * sets the owner ID
	 * @param ownerID
	 */
	public void setOwnerID(String ownerID) {
		this.ownerID = ownerID;
	}
	/**
	 * gets the account name
	 * @return accountName
	 */
	public String getAccountName() {
		return accountName;
	}
	/**
	 * ses the account name
	 * @param accountName
	 */
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	/**
	 * gets the name of the account
	 * @return name
	 */
	public String getName() {
		return name;
	}
	/**
	 * sets the name of the account
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * gets the account type
	 * @return accountType
	 */
	public String getAccountType() {
		return accountType;
	}
	/**
	 * sets the account type
	 * @param accountType
	 */
	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}
	/**
	 * gets the account balance
	 * @return balance
	 */
	public Double getBalance() {
		return balance;
	}
	/**
	 * sets the account balance
	 * @param balance
	 */
	public void setBalance(Double balance) {
		this.balance =  Math.ceil(balance * 100) / 100;
	}
	/**
	 * gets the business ID
	 * @return businessID
	 */
	public String getBusinessID() {
		return businessID;
	}
	/**
	 * sets the business ID
	 * @param businessID
	 */
	public void setBusinessID(String businessID) {
		this.businessID = businessID;
	}
	/**
	 * converts this to a string JSON
	 */
	public String toString() {
		return new Gson().toJson(this);
	}
}
