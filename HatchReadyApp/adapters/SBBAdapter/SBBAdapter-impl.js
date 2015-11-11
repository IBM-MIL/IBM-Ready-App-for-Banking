/**
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

'use strict';
var javaAdapter = com.ibm.mil.ready.app.hatch.SBBAdapter.getInstance()
var msgService = com.ibm.mil.ready.app.hatch.service.MessageService
		.getInstance();
var jsonParser = new com.google.gson.Gson();
var defaultLocale = 'en_US';

/**
 * Test method so the client side folks can ensure MFP client is configured
 * properly.
 */
function test() {
	return {
		isSuccessful : true,
		result : 'Success!'
	};
}


/**
 * Ensures the user is properly authenticated. Callback for protected adapter
 * procedures
 * 
 * @param headers
 * @param errorMessage
 * @return true if user is not authenticated
 */
function onAuthRequired(headers, errorMessage) {
	errorMessage = errorMessage ? errorMessage
			: 'Authentication required to invoke this procedure!';

	return {
		authRequired : true,
		errorMessage : errorMessage
	};
}

/**
 * Exposed procedures to authenticate the user on initial login and subsequent
 * logins
 * 
 * @param username
 * @param password
 * @return true/false depending on the credentials provided
 */
function submitAuthentication(username, password) {
	WL.Logger.info("submitAuthentication " + username)
	
	var response = javaAdapter.verifyUser(username, password);
	var responseArray = JSON.parse(response);

	var validUser = responseArray[0];
	var userLocale = responseArray[1];
	var user = responseArray[2];

	WL.Logger.info("validUser is " + validUser)
	
	if (validUser) {
		var userIdentity = {
			userId : user._id,
			username : username,
			locale : userLocale
		};

		WL.Server.setActiveUser('ReadyAppHatchAuthRealm', userIdentity);
		return {
			isSuccessful : true,
			result : user,
			authRequired : false

		};
	} else {
		return {
			onAuthRequired : onAuthRequired(null, 'Invalid Credentials'),
			isSuccessful : false
		};
	}
}

/**
 * Logs out the user due to inactivity or app termination
 */
function onLogout() {
	WL.Logger.info('Logged out');
	WL.Server.setActiveUser('ReadyAppHatchAuthRealm', null);
}
