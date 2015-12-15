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

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Logger;

public final class PropertiesReader {

	public static final Object CREATE_LOCK = new Object();
	// Logger
	private final static Logger LOGGER = Logger
			.getLogger(PropertiesReader.class.getName());

	// Singleton instance
	private static PropertiesReader singleton;

	// Instance variables
	private Properties properties;
	private static final String fileName = "resources/app.properties";

	private PropertiesReader() {
		try {
			properties = new Properties();
			InputStream inStream = getClass().getClassLoader()
					.getResourceAsStream(fileName);
			properties.load(inStream);
		} catch (IOException e) {
			LOGGER.severe("Could not load properties file: " + fileName);
			LOGGER.severe(e.getMessage());
		}
	}

	public static PropertiesReader getInstance() {
		synchronized(CREATE_LOCK) {
			if (singleton == null) {
				singleton = new PropertiesReader();
			}
		}
		
		return singleton;
	}

	public String getStringProperty(String property) {
		return properties.getProperty(property);
	}

	public int getIntProperty(String property) {
		return Integer.parseInt(properties.getProperty(property));
	}
}
