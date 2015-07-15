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

var javaAdapter = com.ibm.mil.ready.app.hatch.SBBAdapter.getInstance();
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
 * Finds a user by username in the back end. Requires a username and a locale
 * 
 * @param username
 *            The username of the user to find.
 * @param locale
 *            The locale of the client
 * @returns boolean isSuccessful determining if the call was successful and a
 *          result, if there was any
 */
function getUser(username) {
	username = !username ? null : username;

	var locale = getUserLocale();
	locale = !locale ? defaultLocale : locale;

	var users = javaAdapter.getUser(username, locale);
	var success = (users == null) ? false : true;
	return {
		isSuccessful : success,
		result : users
	};
}
/**
 * Returns the dashboard data for different business that the user owns.
 * @returns dashboard json payload
 */
function getDashboardData() {
	var activeUserId = getUserId();
	var locale = getUserLocale();
	
	var dashboardData = javaAdapter.getDashboardData(activeUserId.result, locale.result);
	var success = dashboardData == null ? false : true;

	return {
		isSuccessful : success,
		result : dashboardData
	};
}

/**
 * Returns the solution from the Watson Tradeoff Service
 * @param dilemma
 * @returns solution
 */		
function getTradeoffSolution(dilemma) {
	var jsonString = JSON.stringify(dilemma) + '';
	var solution = javaAdapter.getTradeoffSolution(jsonString);
	var success = solution == null ? false : true;
	WL.Logger.info('Watson solution: ' + solution);
	WL.Logger.info('Watson success: ' + success);
	return {
		isSuccessful : success,
		result : solution
	};
	
}

/**
 * Finds the accounts associated with the given userid. If the userid does not
 * exist, no accounts are returned.
 * 
 * @param userid
 *            The userid of the logged in user.
 * @param locale
 *            The locale of the client
 * @returns boolean isSuccessful determining if the call was successful and a
 *          result, if there was any
 */
function getAccounts(userid) {
	
	var activeUserId = getUserId();
	userid = !userid ? null : activeUserId;

	var locale = getUserLocale();
	locale = !locale ? defaultLocale : locale;

	var accounts = javaAdapter.getAccounts(activeUserId.result, locale.result);
	var success = accounts == null ? false : true;

	return {
		isSuccessful : success,
		result : accounts
	};
}

/**
 * Finds the Goals associated with the given userid. If the userid does not
 * exist, or if it contains none, then return empty list.
 * 
 * @param userid
 *            The userid of the logged in user.
 * @param locale
 *            The locale of the client
 * @returns boolean isSuccessful determining if the call was successful and a
 *          result, if there was any
 */
function getGoals(userid) {
	var activeUserId = getUserId();
	
	var locale = getUserLocale();
	
	var goals = javaAdapter.getGoals(activeUserId.result, locale.result);
	var success = (goals == null) ? false : true;

	return {
		isSuccessful : success,
		result : goals
	};
}

/**
 * Gets all the transactions for a given account id
 * 
 * @param accountid
 *            The id of the account whose transactions we need to get.
 * @param locale
 *            The locale of the client
 * @returns boolean isSuccessful determining if the call was successful and a
 *          result, if there was any
 */
function getTransactions(accountid) {
	accountid = !accountid ? null : accountid;

	var locale = getUserLocale();
	locale = !locale ? defaultLocale : locale;

	var transactions = javaAdapter.getTransactions(accountid, locale);
	var success = (transactions == null) ? false : true;

	return {
		isSuccessful : success,
		result : transactions
	};
}

/**
 * Bank account offers
 * @returns offers
 */
function getOffers() {
	
	var offers = javaAdapter.getOffers();
	var success = (offers == null) ? false : true;

	return {
		isSuccessful : success,
		result : offers
	};
}


/**
 * Gets the feasibility of the new goal based off the existing cash flow and existing goals.
 * 
 * @param userId
 *            The id of the user who is adding the new goal.
 * @param businessId
 *            The id of the business where we want to add the new goal
 * @param newGoal
 *            The new goal whose feasibility we want to check
 * @param existingGoals
 *            The set of existing goals for the user and business.
 * @param locale
 *            The locale of the client
 * @returns boolean isSuccessful determining if the call was successful and a
 *          result, if there was any
 */
function getFeasibility(userId, businessId, newGoal, existingGoals) {
	userId = !userId ? null : userId;
	businessId = !businessId ? null : businessId;
	newGoal = !newGoal ? null : JSON.stringify(newGoal);
	
	existingGoals = !existingGoals ? null : JSON.stringify(existingGoals);

	var locale = getUserLocale().toString();
	locale = !locale ? defaultLocale : locale;
	
	WL.Logger.error('newGoal: ' + newGoal);
	WL.Logger.error('existingGoals: ' + existingGoals);

	var recommendations = javaAdapter.getFeasibility(userId, businessId, newGoal, 
			existingGoals, locale);
	WL.Logger.info(recommendations);
	var success = (recommendations == null) ? false : true;

	WL.Logger.info('success: ' + success);
	return {
		isSuccessful : success,
		result : recommendations
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
	var response = javaAdapter.verifyUser(username, password);
	var responseArray = JSON.parse(response);

	var validUser = responseArray[0];
	var userLocale = responseArray[1];
	var user = responseArray[2];

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
 * helper method to return the current user locale
 * @returns locale
 */
function getUserLocale() {
	var user = WL.Server.getActiveUser('ReadyAppHatchAuthRealm');
	WL.Logger.debug(user);
	return {
		result : user.locale
	};

}
/**
 * helper method to return the current user ID
 * @returns userId
 */
function getUserId() {
	var user = WL.Server.getActiveUser('ReadyAppHatchAuthRealm');
	WL.Logger.debug(user);
	return {
		result : user.userId
	};
}
/**
 * helper method to return the current username
 * @returns username
 */
function getUsername() {
	var user = WL.Server.getActiveUser('ReadyAppHatchAuthRealm');
	WL.Logger.debug(user);
	return {
		result : user.username
	};
}

/**
 * This method processes the JSON response and sets the isSuccessful flag to
 * false if the server responded with a 500, 401, or 403 HTTP status code. By
 * default, the isSuccessful flag is set to false only if the HTTP host is not
 * reachable or invalid HTTP request timed out. Hence, the need for this method.
 * For further details, see:
 * https://www.ibm.com/developerworks/community/blogs/worklight/entry/handling_backend_responses_in_adapters?lang=en
 * 
 * @param response
 */
function handleResponse(response) {
	var httpErrorCodes = [ 500, 401, 403 ];
	var index = httpErrorCodes.indexOf(response.statusCode);
	if (response.isSuccessful && index >= 0) {
		response.isSuccessful = false;
	}
	return response;
}

function invokeHttpServer(input) {
	var response = WL.Server.invokeHttp(input);
	return handleResponse(response);
}
/**
 * Logs out the user due to inactivity or app termination
 */
function onLogout() {
	WL.Logger.info('Logged out');
	WL.Server.setActiveUser('ReadyAppHatchAuthRealm', null);
}
