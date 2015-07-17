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

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import com.google.gson.Gson;
import com.ibm.mil.ready.app.hatch.model.Account;
import com.ibm.mil.ready.app.hatch.model.Business;
import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.Offer;
import com.ibm.mil.ready.app.hatch.model.Transaction;
import com.ibm.mil.ready.app.hatch.model.User;
import com.ibm.mil.ready.app.hatch.service.HatchDBService;
import com.ibm.mil.ready.app.hatch.service.UserService;

public class CloudantServiceTests {
	public static final String LOCALE = "en_US";
	public static final String USER1 = "u1";
	public static final String PASSWORD1 = "p1";
	public static final String USER1_ID= "1001";
	public static final String ACCOUNT1_ID = "2001";
	public static final String BUSINESS1_ID = "5001";
	public static final String BUSINESS2_ID = "5002";
	private static final Gson parser = new Gson();
	
	@Test
	public void testGetUser() {
		UserService cs = UserService.getInstance();
		List<User> user = cs.getUsers(USER1, LOCALE);
		User u1 = user.get(0);
		assertEquals("Should only have one user, found " + user.size(), user.size(), 1);		
		assertEquals("User should be u1, but its " + u1.getUsername(), u1.getUsername(), USER1);
	}
	
	@Test
	public void testBadUser() {
		UserService cs = UserService.getInstance();
		List<User> user = cs.getUsers("u10", "en_US");
		assertNull("Bad username, user should be null.", user);
	}
	
	@Test
	public void testTransactions() {
		HatchDBService cs = HatchDBService.getInstance();
		String transactionJson = cs.getTransactions(ACCOUNT1_ID, LOCALE);
		Transaction[] transactions = parser.fromJson(transactionJson, Transaction[].class);
		Assert.assertNotNull("Transactions array should not be null", transactions);
		Assert.assertNotEquals("Should have found at least one transaction: " + transactions.length, transactions.length, 0);
	}
	
	@Test
	public void testBadTransactions() {
		HatchDBService cs = HatchDBService.getInstance();
		String transactionsJson = cs.getTransactions("foo", LOCALE);
		System.out.println("user: " + transactionsJson);
		assertNull("Bad username, user should be null.", transactionsJson);
	}
	
	@Test
	public void testGoals() {
		HatchDBService cs = HatchDBService.getInstance();
		String goalJson = cs.getGoals(USER1_ID, LOCALE);
		Goal[] goals = parser.fromJson(goalJson, Goal[].class);
		Assert.assertNotNull("Goals array should not be null", goals);
		Assert.assertNotEquals("Should have found at least one goal: " + goals.length, goals.length, 0);
	}
	
	@Test
	public void testBadGoals() {
		HatchDBService cs = HatchDBService.getInstance();
		String goalJson = cs.getGoals("foo", LOCALE);
		System.out.println("user: " + goalJson);
		Assert.assertNotNull("Bad username, user should be null.", goalJson);
	}
	
	@Test
	public void testBusiness() {
		HatchDBService cs = HatchDBService.getInstance();
		String business1Json = parser.toJson(cs.getBusiness(BUSINESS1_ID, LOCALE));
		Business[] business1 = parser.fromJson(business1Json, Business[].class);
		Assert.assertNotNull("Business data should not be null", business1);
		
		String business2Json = parser.toJson(cs.getBusiness(BUSINESS2_ID, LOCALE));
		Business[] business2 = parser.fromJson(business2Json, Business[].class);
		Assert.assertNotNull("Business data should not be null", business2);
	}
	
	@Test
	public void testBadBusiness() {
		HatchDBService cs = HatchDBService.getInstance();
		String badBusiness1Json = parser.toJson(cs.getBusiness("", LOCALE));
		Business[] badBusiness1 = parser.fromJson(badBusiness1Json, Business[].class);
		Assert.assertNull("Business data should be null", badBusiness1);
		
		String badBusiness2Json = parser.toJson(cs.getBusiness(null, LOCALE));
		Business[] badBusiness2 = parser.fromJson(badBusiness2Json, Business[].class);
		Assert.assertNotNull("Business data should be null", badBusiness2);
	}
	
	@Test
	public void testOffers(){
		HatchDBService cs = HatchDBService.getInstance();
		String offersJson = cs.getOffers();
		Offer[] offers = parser.fromJson(offersJson, Offer[].class);
		Assert.assertNotNull("Offers data should not be null", offers);
	}
	
	@Test
	public void testAccounts() {
		HatchDBService cs = HatchDBService.getInstance();
		String accountsJson = cs.getAccounts(USER1_ID, LOCALE);
		Account[] accounts = parser.fromJson(accountsJson, Account[].class);
		Assert.assertNotNull("Accounts array should not be null", accounts);
		Assert.assertNotEquals("Should have found at least one account: " + accounts.length, accounts.length, 0);
	}
	
	@Test
	public void testBadAccounts() {
		HatchDBService cs = HatchDBService.getInstance();
		String accountJson = cs.getAccounts("foo", LOCALE);
		System.out.println("user: " + accountJson);
		assertNull("Bad username, user should be null.", accountJson);
	}
	
	@Test
	public void testDashboard() {
		HatchDBService cs = HatchDBService.getInstance();
		String dashboardJson = cs.getDashboardData("1001", LOCALE);
		List<Business> businessArray = new ArrayList<Business>();
		//String ownerID, String businessID, String businessName, String businessDescription, String tag, String imageFile
		Business fanniesBakery = new Business("1001","5001","Fannie's Bakery", "Jamming with Jams (and pies)",
				"baked goods shop","fannies_bakery");
		Business fanniesCatering = new Business("1001","5002","Fannie's Catering", "Food on tables for events!",
				"catering company","fannies_catering");
		
		List<Account> accountListFB = new ArrayList<Account>();
		Account fbChecking = new Account();
		fbChecking.setName("Checking");
		fbChecking.setBalance(18500.0);
		fbChecking.setId("2001");
		Account fbSaving = new Account();
		fbSaving.setName("Savings");
		fbSaving.setBalance(102975.45999999999);
		fbSaving.setId("2002");
		Account fbGoals = new Account();
		fbGoals.setName("goals");
		fbGoals.setBalance(24820.0);
		fbGoals.setId("");
		accountListFB.add(fbGoals);		
		accountListFB.add(fbSaving);
		accountListFB.add(fbChecking);
		
		List<Account> spendingListFB = new ArrayList<Account>();
		Account fbSpendingGoals = new Account();
		fbSpendingGoals.setName("goals");
		fbSpendingGoals.setBalance(2014.2857142857142);
		fbSpendingGoals.setId("");
		Account fbSpendingBills = new Account();
		fbSpendingBills.setName("bills");
		fbSpendingBills.setBalance(558.3333333333334);
		fbSpendingBills.setId("");
		Account fbSpendingTransfer = new Account();
		fbSpendingTransfer.setName("Transfer to Savings");
		fbSpendingTransfer.setBalance(1416.6666666666667);
		fbSpendingTransfer.setId("");
		spendingListFB.add(fbSpendingGoals);		
		spendingListFB.add(fbSpendingBills);
		spendingListFB.add(fbSpendingTransfer);

		
		fanniesBakery.setAccountList(accountListFB);
		fanniesBakery.setSpendingList(spendingListFB);
		
		List<Account> accountListFC = new ArrayList<Account>();
		Account fcChecking = new Account();
		fcChecking.setName("Checking");
		fcChecking.setBalance(36500.0);
		fcChecking.setId("2003");
		Account fcSaving = new Account();
		fcSaving.setName("Savings");
		fcSaving.setBalance(102975.45999999999);
		fcSaving.setId("2004");
		Account fcGoals = new Account();
		fcGoals.setName("goals");
		fcGoals.setBalance(132834.0);
		fcGoals.setId("");
		accountListFC.add(fcSaving);
		accountListFC.add(fcGoals);				
		accountListFC.add(fcChecking);
		
		List<Account> spendingListFC = new ArrayList<Account>();
		Account fcSpendingGoals = new Account();
		fcSpendingGoals.setName("goals");
		fcSpendingGoals.setBalance(7730.0);
		fcSpendingGoals.setId("");
		Account fcSpendingBills = new Account();
		fcSpendingBills.setName("bills");
		fcSpendingBills.setBalance(475.0);
		fcSpendingBills.setId("");
		Account fcSpendingTransfer = new Account();
		fcSpendingTransfer.setName("Transfer to Savings");
		fcSpendingTransfer.setBalance(1250.0);
		fcSpendingTransfer.setId("");
		spendingListFC.add(fcSpendingGoals);		
		spendingListFC.add(fcSpendingBills);
		spendingListFC.add(fcSpendingTransfer);
		
		fanniesCatering.setAccountList(accountListFC);
		fanniesCatering.setSpendingList(spendingListFC);
		
		businessArray.add(fanniesBakery);
		businessArray.add(fanniesCatering);

		assertEquals("Valid Dashboard Data",dashboardJson, parser.toJson(businessArray));
		
	}
	
	@Test
	public void testBadDashboard() {
		HatchDBService cs = HatchDBService.getInstance();
		String invalidDashboardJson1 = cs.getDashboardData("1005", LOCALE);
		assertEquals("Invalid Dashboard Data",invalidDashboardJson1, null);
		String emptyDashboardJson = cs.getDashboardData("", LOCALE);
		assertEquals("Invalid Dashboard Data",emptyDashboardJson, null);
		String nullInput = cs.getDashboardData(null, LOCALE);
		assertEquals("Invalid Dashboard Data",nullInput, null);
		
	}
	
	@Test
	public void testVerifyUser(){
		UserService cs = UserService.getInstance();
		List<User> user = cs.getUsers(USER1, LOCALE);
		Object [] testValidUser = {true, "en_US", user.get(0)}; 
		user.get(0).setPassword(null);
		assertEquals("Valid password", cs.verifyUser(USER1, PASSWORD1), parser.toJson(testValidUser));
		Object [] testInvalid = {false, "en_US", null};
		assertEquals("Invalid password", cs.verifyUser(USER1, "p2"), parser.toJson(testInvalid));
		Object [] testNullPassword = {false, "en_US",null};
		assertEquals("Null password", cs.verifyUser(USER1, null), parser.toJson(testNullPassword));
		Object [] testNullUser = {false, "en_US",null};
		assertEquals("Null user", cs.verifyUser("u2", "p1"), parser.toJson(testNullUser));
		
	}
}
