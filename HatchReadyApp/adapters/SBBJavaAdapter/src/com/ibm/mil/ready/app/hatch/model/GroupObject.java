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

import com.google.gson.Gson;

/**
 * This class represents the key and value pair that are returned from Cloudant for any query.  Since the key and the
 * value can contain any data structure, the type must be Object.  Based on the queries you are running, you can be
 * confident of the type being returned by Cloudant and thus do an explicit cast even though Eclipse will nag
 * that the cast is unsafe.
 */
public class GroupObject {
	private Object key;
	private Object value;
	/**
	 * gets the key 
	 * @return key
	 */
	public Object getKey() {
		return key;
	}
	/**
	 * sets the key
	 * @param key
	 */
	public void setKey(Object key) {
		this.key = key;
	}
	/**
	 * gets the value
	 * @return value
	 */
	public Object getValue() {
		return value;
	}
	/**
	 * sets the value
	 * @param value
	 */
	public void setValue(Object value) {
		this.value = value;
	}
	/**
	 * converts the data object into a JSON object
	 */
	public String toString() {
		return new Gson().toJson(this);
	}
}
