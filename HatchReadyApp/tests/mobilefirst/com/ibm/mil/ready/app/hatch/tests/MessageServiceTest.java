/* 
 * Licensed Materials - Property of IBM © Copyright IBM Corporation 2015. All
 * Rights Reserved. This sample program is provided AS IS and may be used,
 * executed, copied and modified without royalty payment by customer (a) for its
 * own instruction and study, (b) in order to develop applications designed to
 * run with an IBM product, either for customer's own internal use or for
 * redistribution by customer, as part of such an application, in customer's own
 * products.
 */

package com.ibm.mil.ready.app.hatch.tests;

import org.junit.Assert;
import org.junit.Test;

import com.ibm.mil.ready.app.hatch.service.MessageService;

public class MessageServiceTest {

	@Test
	public void testKeyNotFound() {
		MessageService ms = MessageService.getInstance();
		String falseKey = "foo";
		Assert.assertEquals("Should return false key (" + falseKey + ") as key doesnt exist in message file", 
				ms.getMessage(falseKey), falseKey);
	}
	
	@Test
	public void testKey() {
		MessageService ms = MessageService.getInstance();
		String key = "MSG0001";
		Assert.assertEquals("Not correctly returning message from file.", 
				ms.getMessage(key), "MSG0001 Argument cannot be null.");
	}
}
