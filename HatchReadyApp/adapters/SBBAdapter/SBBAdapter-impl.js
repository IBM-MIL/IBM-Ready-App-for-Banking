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

/**
 * Test method so the client side folks can ensure MFP client is configured
 * properly.
 */
function test() {
	WL.Logger.info("SBBAdapter test invoked");
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
	
	var input = {
			method : 'post',
			returnedContentType : 'json',
			path : "HatchReadyApp/adapters/SBBJavaAdapter/authenticate",
			body : {
            	contentType : 'application/x-www-form-urlencoded',
            	content     : 'username=' + username + '&password=' + password
				}
	};

	var response = WL.Server.invokeHttp(input);
	
	WL.Logger.debug("SBBJavaAdapter/authenticate returned " + JSON.stringify(response));

	var validUser = response.array[0];
	var userLocale = response.array[1];
	var user = response.array[2];

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
