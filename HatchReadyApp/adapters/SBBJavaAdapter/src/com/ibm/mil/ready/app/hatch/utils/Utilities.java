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

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.gson.Gson;
import com.ibm.mil.ready.app.hatch.SBBAdapter;
import com.ibm.mil.ready.app.hatch.service.MessageService;

public class Utilities {
	private final static MessageService messages = MessageService.getInstance();
	private static final Logger LOGGER = Logger.getLogger(Utilities.class
			.getSimpleName());
	private final PropertiesReader constants = PropertiesReader.getInstance();
	private final Gson parser = new Gson();
	
	public static long convertTime(long difference) {
		return (System.currentTimeMillis() + difference);
	}
	
	/**
	 * Get time difference from start to end. For performance testing.
	 * 
	 */
	public static String getTimeDifference(long start, long end) {
		long diff = end - start;
		int millis = (int) diff % 1000;
		int sec = (int) diff / 1000;
		int min = (int) diff / 1000 / 60;
		return min + " minutes " + sec + " seconds " + millis + " milliseconds";
	}
	
	public boolean isSanitary(String argument) {
		return isSanitary(argument, constants.getStringProperty(Constants.DEFAULT_LOCALE));
	}

	/**
	 * Ensures that some sanity checking is done against the arguments passed in from the client to the back end. This
	 * method returns false if one of the "bad" strings is found, basically checking for sql injections, etc.
	 * 
	 * @param argument The parameter passed in from the client
	 * @param locale The locale of the client user
	 * @return True if the client argument is sanitary, or false if it contains basd strings.
	 */
	public boolean isSanitary(String argument, String locale) {
		boolean sanitary = true;
		// check for null, empty, sql query, etc
		try {
			String lowered = argument == null? null : argument.toLowerCase(new Locale(locale));
			if (argument == null) {
				throw new IllegalArgumentException(messages.getMessage(
						Constants.MSG1_KEY, locale));
			} else if ("".equals(argument)) {
				throw new IllegalArgumentException(messages.getMessage(
						Constants.MSG2_KEY, locale));
			} else if (argument.length() == 0) {
				throw new IllegalArgumentException(messages.getMessage(
						Constants.MSG2_KEY, locale));
			} else if (argument.contains(" ")) {
				throw new IllegalArgumentException(messages.getMessage(
						Constants.MSG3_KEY, locale));
			} else if (isSqlInjection(lowered)) {
				throw new IllegalArgumentException(messages.getMessage(
						Constants.MSG4_KEY, locale));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			LOGGER.log(Level.SEVERE,
					messages.getMessage("MSG0005", locale,
							new Object[] { ex.getMessage() }));
			sanitary = false;
		}

		return sanitary;
	}

	private boolean isSqlInjection(String userInput) {
		boolean isInjection = false;
		for (String str : getSQLInjectionKeywords()) {
			isInjection |= userInput.contains(str); 
			if (isInjection) {
				break;
			}
		}
		return isInjection;
	}
	
	private List<String> getSQLInjectionKeywords() {
		List<String> keywords = new ArrayList<String>();
		keywords.add("collection");
		keywords.add("db");
		keywords.add("drop");
		keywords.add("insert");
		keywords.add("remove");
		keywords.add("save");
		keywords.add("show");
		keywords.add("update");
		return keywords;
	}
	
	/**
	 * Attempts to parse the given object type from the Json string. If no object was parsable (or some other
	 * exception occurred, the method will return null.
	 * 
	 * @param json The json string to parse
	 * @param newClass The class to convert the json into.
	 * @return The object of the given class type found in the string, or null if the method was unable to parse the
	 * string correctly.
	 */
	public <T> T parseObject(String json, Class<T> newClass) {
		T newObj  = null; 
		try {
			newObj = parser.fromJson(json, newClass);
		} catch(Exception ex) {
			SBBAdapter.LOGGER.info(ex.getLocalizedMessage());
			ex.printStackTrace();
		}
		return newObj;
	}
}
