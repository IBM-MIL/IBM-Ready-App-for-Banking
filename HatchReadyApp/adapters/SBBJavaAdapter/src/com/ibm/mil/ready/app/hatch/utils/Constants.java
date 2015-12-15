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

public class Constants {
	/*******  Constants for the CloudantService class  ******/
	public final static String USERNAME_KEY = "CLOUDANT_USERNAME";
	public final static String PASSWORD_KEY = "CLOUDANT_PASSWORD";
	public final static String DB_KEY = "CLOUDANT_DB_NAME";
	public final static String GOALS = "goals";
	//an empty string will sort before any string with any actual characters in it.
	public final static String LOWER_STRING_BOUND = "";
	/*
	 * An array of strings will sort after any literal string, hence the upper bound.  This wouldn't work if we were
	 * using this bounds against actual text string (descriptions, etc, since those could contain UTF-8 characters)
	 * but this works for account IDs, which fall under alpha-numeric ASCII strings.
	 */
	public final static String[] UPPER_STRING_BOUND = new String[]{"a"};

	public final static String DEFAULT_LOCALE = "DEFAULT_LOCALE";
	
	/*******  Constants for the FeasibilityService class  ******/
	//This actually returns 6 months as its a 0 based index.
	public final static int CASHFLOW_MONTHS = 5;
	public final static String TOTAL_KEY = "total";
	public final static String RECOMMENDATION_1 = "RECOMMENDATION_1";
	public final static String RECOMMENDATION_2 = "RECOMMENDATION_2";
	public final static String WEEKS_KEY = "WEEKS";
	public final static String MONTHS_KEY = "MONTHS";
	public final static String DAYS_KEY = "DAYS";
	public final static String NOT_FEASIBLE_GOAL_CONSTRAINTS = "RECOMMENDATION_NOT_POSSIBLE_WITHIN_CONSTRAINTS";
	public final static String NOT_FEASIBLE_KEY = "RECOMMENDATION_NOT_POSSIBLE";
	public final static String FEASIBLE_NO_CHANGES = "RECOMMENDATION_POSSIBLE_NO_ADJUST";
	public final static String FEASIBLE_CHANGES_KEY = "RECOMMENDATION_POSSIBLE_CHANGES";
	public final static String SINGLE_KEY = "single";
	public final static String MULTI_KEY = "multi";
	public final static String MAX_YEARS_KEY= "MAX_YEARS_TO_EXTEND_GOAL";
	public final static String MAX_GOALS_CHANGE_KEY = "MAX_GOALS_TO_REPLACE";
	public final static int MIN_RECOMMENDATIONS = 3;
	public final static String KEY_SEPARATOR = "-";
	public final static int LESS_THAN = -1;
	public final static int GREATER_THAN = 1;
	public final static int EQUAL = 0;
	public final static int REVERSE_LESS_THAN = 1;
	public final static int REVERSE_GREATER_THAN = -1;
	
	/*******  Constants for Goals  ******/
	public final static int FEASIBLE = 0;
	public final static int WARNING = 1;
	public final static int INFEASIBLE = 2;
	

	/*******  Constants for Utilities  ******/
	public final static String MSG1_KEY = "MSG0001";
	public final static String MSG2_KEY = "MSG0002";
	public final static String MSG3_KEY = "MSG0003";
	public final static String MSG4_KEY = "MSG0004";
}
