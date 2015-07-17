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

import com.cloudant.client.api.CloudantClient;
import com.cloudant.client.api.Database;
import com.ibm.mil.ready.app.hatch.utils.Constants;
import com.ibm.mil.ready.app.hatch.utils.PropertiesReader;

/**
 *
 * This class communicates with Cloudant and returns relevant information for
 * the user who has been properly authenticated. The functions in this class
 * will be invoked via the MobileFirst Platform Adapters.
 */
public class CloudantService {
	public static final Object CREATE_LOCK = new Object();
	protected Database db;
	private final PropertiesReader constants = PropertiesReader.getInstance();

	/*
	 * Private constructor. Instantiates instances of cloudant and the message
	 * services.
	 */
	public CloudantService() {
		super();
		connect();
	}

	/*
	 * Create the connection to the Cloudant database that we'll use for this
	 * service.
	 */
	private void connect() {
		CloudantClient cloudantClient = new CloudantClient(
				constants.getStringProperty(Constants.ACCOUNT_KEY),
				constants.getStringProperty(Constants.USERNAME_KEY),
				constants.getStringProperty(Constants.PASSWORD_KEY));
		db = cloudantClient.database(
				constants.getStringProperty(Constants.DB_KEY), true);
	}

	/**
	 * Returns a List of objects of the provided type.  The  method will query the given view with the given filter, and 
	 * attempt to cast any returned documents to the provided type. 
	 * 
	 * @param viewName The name of the view to query.
	 * @param filter The filter to be applied to the query.
	 * @param castClass The class of the documents you are retrieving from Cloudant. 
	 * @param includDocs True if you want Cloudant to turn any _id fields in your View values into the full document.
	 * @return A list of documents retrieved from the view, cast into the specified type. Or a zero sized list if no
	 * documents were found matching the constraints.
	 */
	public <T> List<T> getData(String viewName, Object filter,
			Class<T> castClass, boolean includDocs) {
		return db.view(viewName).key(filter).reduce(false)
				.includeDocs(includDocs).query(castClass);
	}

	/**
	 * Returns a List of objects of the provided type from the given View.
	 * 
	 * @param viewName The name of the view to query.
	 * @param castClass The class of the documents you are retrieving from Cloudant. 
	 * @param includDocs True if you want Cloudant to turn any _id fields in your View values into the full document.
	 * @return A list of documents retrieved from the view, cast into the specified type. Or a zero sized list if no
	 * documents were found matching the constraints.
	 */
	public <T> List<T> getData(String viewName, Class<T> castClass,
			boolean includDocs) {
		return db.view(viewName).reduce(false).includeDocs(includDocs)
				.query(castClass);
	}

	/**
	 * Returns a List of objects of the provided type from the given View. The view will return all documents it finds
	 * that fall between the start key (inclusive) and the end key (exclusive).
	 * 
	 * @param viewName The name of the view to query.
	 * @param startKeys The starting complex key value.
	 * @param endKeys The ending complex key value.
	 * @param castClass The class of the documents you are retrieving from Cloudant. 
	 * @param includDocs True if you want Cloudant to turn any _id fields in your View values into the full document.
	 * @return A list of documents retrieved from the view, cast into the specified type. Or a zero sized list if no
	 * documents were found matching the constraints.
	 */
	public <T> List<T> getDataWithComplexKey(String viewName,
			Object[] startKeys, Object[] endKeys, Class<T> castClass,
			boolean includeDocs) {
		return db.view(viewName).startKey(startKeys).endKey(endKeys)
				.reduce(false).includeDocs(includeDocs).query(castClass);
	}

	/**
	 * Returns a single string value from the reduce function from the provided View. This method reduces after
	 * filtering on a single key.
	 * 
	 * @param viewName The name of the view whose reduce function you wish to call.
	 * @param filter The filter to apply to the View before calling the reduce function.
	 * @return A String value representing the value returned from the View's reduce function.
	 */
	public String getReducedData(String viewName, Object filter) {
		return db.view(viewName).key(filter).reduce(true).queryForString();
	}

	/**
	 * Returns a single string value from the reduce function from the provided View. This method reduces after
	 * filtering with complex keys.
	 * 
	 * @param viewName The name of the view whose reduce function you wish to call.
	 * @param startKeys The starting complex key value.
	 * @param endKeys The ending complex key value.
	 * @return A String value representing the value returned from the View's reduce function.
	 */
	@SuppressWarnings("PMD.UseVarargs")
	public String getReducedDataWithComplexKey(String viewName,
			Object[] startKeys, Object[] endKeys) {
		return db.view(viewName).startKey(startKeys).endKey(endKeys)
				.reduce(true).includeDocs(false).queryForString();
	}

	/**
	 * Returns a single string value from the reduce function from the provided View. There is no filtering
	 * done before doing a reduce.
	 * 
	 * @param viewName The name of the view whose reduce function you wish to call.
	 * @return A String value representing the value returned from the View's reduce function.
	 */
	public String getReducedData(String viewName) {
		return db.view(viewName).reduce(true).queryForString();
	}

	/**
	 * Return group data from Cloudant using a complex key.
	 * 
	 * @param viewNameThe name of the view whose reduce function you wish to call.
	 * @param startKeys The starting complex key value.
	 * @param endKeys The ending complex key value.
	 * @param castClass The class of the documents you are retrieving from Cloudant. 
	 * @return A list of "group reduced records" retrieved from the view, cast into the specified type. 
	 * Or a zero sized list if no documents were found matching the constraints.
	 */
	public <T> List<T> getGroupedDataWithComplexKey(String viewName,
			Object[] startKeys, Object[] endKeys, Class<T> castClass) {
		return db.view(viewName).startKey(startKeys).endKey(endKeys)
				.group(true).includeDocs(false).query(castClass);
	}
	
	/**
	 * Return an array of keys required for group by function
	 * @param keys
	 * @return array of keys
	 */
	@SuppressWarnings("PMD.UseVarargs")
	public Object[] getKeys(Object... keys) {
		return keys;
	}
}