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

import java.util.List;

import com.google.gson.Gson;

/**
 * Pojo to represent a business
 *
 */
public class Business extends CloudantObject {
	private String businessName;
	private String businessDescription;
	private String ownerID;
	private String tag;
	private String imageFile;
	// The string key might be the account name or "goals"
	List<Account> accounts;
	// Spending section
	// The key is the category and the value is the total for that category.
	List<Account> spending;

	/**
	 * Business class constructor to intialize a business instance
	 * @param ownerID
	 * @param businessID
	 * @param businessName
	 * @param businessDescription
	 * @param tag
	 * @param imageFile
	 */
	public Business (String ownerID, String businessID, String businessName, String businessDescription, String tag, String imageFile) {
		super.setId(businessID);
		this.ownerID = ownerID;
		this.businessName = businessName;
		this.businessDescription = businessDescription;
		this.tag = tag;
		this.imageFile = imageFile;
	}
	/**
	 * gets the owner ID
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
	 * gets the business name
	 * @return businessName
	 */
	public String getBusinessName() {
		return businessName;
	}
	/**
	 * sets the business name
	 * @param businessName
	 */
	public void setBusiness(String businessName) {
		this.businessName = businessName;
	}
	/**
	 * gets the business description
	 * @return businessDescription
	 */
	public String getBusinessDescription() {
		return businessDescription;
	}
	/**
	 * sets the business description
	 * @param businessDescription
	 */
	public void setBusinessDescription(String businessDescription) {
		this.businessDescription = businessDescription;
	}
	/**
	 * gets the tag
	 * @return the tag
	 */
	public String getTag() {
		return tag;
	}
	/**
	 * sets the tag
	 * @param tag
	 */
	public void setTag(String tag) {
		this.tag = tag;
	}

	/**
	 * gets the image file
	 * @return imageFile
	 */
	public String getImageFile() {
		return imageFile;
	}

	/**
	 * sets the image file
	 * @param image file
	 */
	public void setImageFile(String imageFile) {
		this.imageFile = imageFile;
	}
	/**
	 * sets the account list for the business
	 * @param accounts
	 */
	public void setAccountList(List<Account> accounts) {
		this.accounts = accounts;
	}
	/**
	 * gets the account list for the business
	 * @return
	 */
	public List<Account> getAccountList() {
		return this.accounts;
	}
	/**
	 * sets the spending list for the business
	 * @param spending
	 */
	public void setSpendingList(List<Account> spending) {
		this.spending = spending;
	}
	/**
	 * gets the spending list
	 * @return
	 */
	public List<Account> getSpendingList() {
		return this.spending;
	}
	/**
	 * converts the data object into a JSON object 
	 */
	public String toString() {
		return new Gson().toJson(this);
	}
}
