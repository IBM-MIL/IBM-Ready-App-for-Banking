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

import java.util.List;

import com.google.gson.Gson;
import com.ibm.mil.ready.app.hatch.model.User;
import com.ibm.mil.ready.app.hatch.utils.Constants;
import com.ibm.mil.ready.app.hatch.utils.PropertiesReader;
import com.ibm.mil.ready.app.hatch.utils.Utilities;

/**
 *
 * This class communicates with Cloudant and returns relevant information for
 * the user who has been properly authenticated. The functions in this class
 * will be invoked via the MobileFirst Platform Adapters.
 */
public final class UserService {
	public static final Object CREATE_LOCK = new Object();
	private static UserService cloudantConnector;
	private final PropertiesReader constants = PropertiesReader.getInstance();
	private final Gson jsonParser = new Gson();

	private final Utilities utils = new Utilities();
	private final CloudantService cs = new CloudantService();

	/**
	 * Private constructor. Instantiates instances of cloudant and the message
	 * services.
	 */
	private UserService() {
		super();
	}

	/**
	 * returns one and only one instance of the CloudantConnector class
	 * 
	 * @return CloudantConnector instance
	 */
	public static UserService getInstance() {
		synchronized (CREATE_LOCK) {
			if (cloudantConnector == null) {
				cloudantConnector = new UserService();
			}
		}

		return cloudantConnector;
	}

	/**
	 * return a user object, instead of a list of users in json string Function
	 * to query for users. If a username filter is supplied, then the record for
	 * that user only is returned, assuming that a user exists by that name.
	 * 
	 * @param usernameFilter
	 *            null to return all users or a valid user to get the record for
	 *            that user.
	 * @return The user or users found in the database.
	 */
	public List<User> getUsers(String usernameFilter, String locale) {
		List<User> users = null;
		if (usernameFilter == null) {
			users = cs.getData("hatch_main_design/users", User.class, true);
		} else if (utils.isSanitary(usernameFilter)) {
			users = cs.getData("hatch_main_design/users", usernameFilter, User.class, true);
		}
		
		return users == null || users.isEmpty() ? null : users;
	}

	/**
	 * authenticates the user logging in and returns a patient object
	 * 
	 * @param username
	 * @param password
	 * @return Array containing a boolean and the user object (without password)
	 */
	public String verifyUser(String username, String password) {
		Object[] toReturn = new Object[3];
		// Sanity check for: null, empty, sql query, etc
		boolean sanityVerificationforUsername = utils.isSanitary(username,
				constants.getStringProperty(Constants.DEFAULT_LOCALE));

		boolean sanityVerificationforPassword = utils.isSanitary(password,
				constants.getStringProperty(Constants.DEFAULT_LOCALE));

		boolean validUser = false;
		toReturn[0] = validUser;
		toReturn[1] = constants.getStringProperty(Constants.DEFAULT_LOCALE);
		toReturn[2] = null;

		if (sanityVerificationforUsername 
				&& sanityVerificationforPassword) {
			List<User> user = this.getUsers(username,
					constants.getStringProperty(Constants.DEFAULT_LOCALE));

			if (user != null && user.size() == 1) {

				User u1 = user.get(0);
				toReturn = validateUser(u1, password);
			}
		}

		return jsonParser.toJson(toReturn);
	}
	
	/**
	 * Helper function which validates the user and returns the user object
	 * @param u1
	 * @param password
	 * @return user object
	 */
	private Object[] validateUser(User u1, String password){
		Object[] toReturn = new Object[3];
		toReturn[0] = false;
		toReturn[1] = constants.getStringProperty(Constants.DEFAULT_LOCALE);
		toReturn[2] = null;
		if (u1.getPassword() != null
				&& u1.getPassword().equals(password)) {
			toReturn[0] = true;
			toReturn[1] = u1.getLocale();
			u1.setPassword(null);
			toReturn[2] = u1;
		}
		
		return toReturn;
	}
}