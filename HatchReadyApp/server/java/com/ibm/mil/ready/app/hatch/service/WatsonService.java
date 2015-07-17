package com.ibm.mil.ready.app.hatch.service;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.ibm.mil.ready.app.hatch.utils.PropertiesReader;

/**
 * A class which makes a call to the Watson Tradeoff API sending a dilemma and
 * receiving a solution
 * 
 * @author evancompton
 *
 */
public final class WatsonService {

	public static final Object CREATE_LOCK = new Object();
	private static WatsonService watson;
	private static final Logger LOGGER = Logger.getLogger(HatchDBService.class
			.getSimpleName());

	/*
	 * Private constructor. Instantiates instances of Watson service and grabs
	 * credentials services.
	 */
	private WatsonService() {
		super();
	}

	/**
	 * returns one and only one instance of the WatsonService class
	 * 
	 * @return CloudantConnector instance
	 */
	public static WatsonService getInstance() {
		synchronized (CREATE_LOCK) {
			if (watson == null) {
				watson = new WatsonService();
			}
		}

		return watson;
	}

	/**
	 * Makes the REST call to the Watson API and returns the result
	 * 
	 * @param dilemma
	 *            The dilemma to send
	 * @return The solution to the Dilemma
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	@SuppressWarnings("PMD.EmptyCatchBlock")
	public String getTradeoffSolution(String dilemma)
			throws ClientProtocolException, IOException {
		
		LOGGER.log(Level.INFO, "Attempting connection to Watson Service...");

		PropertiesReader propsReader = PropertiesReader.getInstance();
		String watsonURL = propsReader.getStringProperty("WATSON_BASEURL");
		String username = propsReader.getStringProperty("WATSON_USERNAME");
		String password = propsReader.getStringProperty("WATSON_PASSWORD");

		CloseableHttpResponse httpResponse = null;
		CloseableHttpClient httpClient = HttpClients.custom().build();
		try {
			LOGGER.log(Level.INFO, "Connecting...");
			
			HttpPost httpPost = new HttpPost(watsonURL);
			httpPost.setEntity(new StringEntity(dilemma));
			httpPost.setHeader("Accept", "application/json");
			httpPost.setHeader("Content-type",
					"application/json; charset=UTF-8");
			String creds = username + ":" + password;
			String encoding = Base64.encodeBase64String(creds.getBytes("UTF-8"));
			httpPost.setHeader("Authorization", "Basic " + encoding);
			httpResponse = httpClient.execute(httpPost);
			
			LOGGER.log(Level.INFO, "Connection Successful to Watson!");
			
			String result = EntityUtils.toString(httpResponse.getEntity());
			LOGGER.log(Level.INFO, "Watson result: " + result);
			return result;
		} finally {
			try {
				if (httpResponse == null) {
					LOGGER.log(Level.INFO, "Connecting Failed!");
				} else {
					httpResponse.close();
				}
			} catch (Exception ioe) {
				LOGGER.warning(ioe.getMessage());
			}
		}
	}
}
