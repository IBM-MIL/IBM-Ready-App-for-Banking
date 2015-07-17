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

/**
 * Pojo to represent a User
 */
public class User extends CloudantObject {
	private String username;
	private String password;
	private String firstName;
	private String lastName;
	private String company;
	private String locale;
	/**
	 * gets the username
	 * @return username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * sets the username
	 * @param username
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * gets the password
	 * @return password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * sets the password
	 * @param password
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * gets the first name
	 * @return firstName
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * sets the first name
	 * @param firstName
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * gets the last name
	 * @return lastName
	 */
	public String getLastName() {
		return lastName;
	}
	/**
	 * sets the last name
	 * @param lastName
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	/**
	 * gets the company
	 * @return company
	 */
	public String getCompany() {
		return company;
	}
	/**
	 * sets the company
	 * @param company
	 */
	public void setCompany(String company) {
		this.company = company;
	}
	/**
	 * gets the locale
	 * @return locale
	 */
	public String getLocale() {
		return locale;
	}
	/**
	 * sets the locale
	 * @param locale
	 */
	public void setLocale(String locale) {
		this.locale = locale;
	}
}
