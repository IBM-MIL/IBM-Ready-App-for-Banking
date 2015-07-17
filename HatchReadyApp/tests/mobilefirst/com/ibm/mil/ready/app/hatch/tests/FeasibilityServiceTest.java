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

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;

import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.Recommendation;
import com.ibm.mil.ready.app.hatch.service.FeasibilityService;
import com.ibm.mil.ready.app.hatch.utils.CashFlow;
import com.ibm.mil.ready.app.hatch.utils.Constants;
import com.ibm.mil.ready.app.hatch.utils.FeasibilityUtilities;

public class FeasibilityServiceTest {
	private CashFlow cf = TestUtilities.getCashFlow();
	private Goal[] existingGoals = TestUtilities.getExistingGoals();
	private final FeasibilityUtilities utils = new FeasibilityUtilities();
	
	@Test
	public void testSimpleSuccess() {
		Goal g = TestUtilities.getNewGoal(1, "week", 0, 4, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2015, 4, 1));
		FeasibilityService fsbService = new FeasibilityService(cf, g, existingGoals);
		
		List<Recommendation> recommendations = fsbService.getFeasibility();
		
		Assert.assertNotEquals("Should have some recommendations. ",  0, recommendations.size());
		Assert.assertEquals("Shoudl be 4 goals right now.", 4, recommendations.size());
		Assert.assertTrue("Recommendation array is not sorted correctly.", 
				TestUtilities.isRecommendationArraySorted(recommendations));
	}

	@Test
	public void testExtendingGoal() {
		Goal g = TestUtilities.getNewGoal(625, "week", 0, 10000, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2015, 4, 1));
		double frequency = utils.getMonthlyFrequency(g);
		double expected = 625 * 4;
		Assert.assertEquals(expected, frequency, 0d);
		
		//Goal existing = existingGoals[existingGoals.length-1];
		Goal updated = utils.getChangedGoalBasedOnExtraDuration(g, 1);
		int duration = utils.getDuration(g);
		int expectedMore = 1;
		if ("week".equals(g.getDepositFrequency())) {
			expectedMore = 4;
		}
		int updateDuration = utils.getDuration(updated);

		Assert.assertEquals("We're adding a month, so we should have 4 extra weeks", duration + expectedMore, updateDuration);
	}
	
	@Test
	public void testNullParameters() {
		FeasibilityService fsbService = new FeasibilityService(null, null, 
				null);
		List<Recommendation> options = fsbService.getFeasibility();
		Assert.assertNull(options);
		TestUtilities.printRecommendationsForValidation(options);
		Assert.assertTrue("Recommendation array is not sorted correctly.", 
				TestUtilities.isRecommendationArraySorted(options));
	}

	@Test
	public void testNotFeasible() {
		Goal g = TestUtilities.getNewGoal(6250, "week", 0, 100000, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2015, 4, 1));
		
		FeasibilityService fsbService = new FeasibilityService(cf, g, existingGoals);
		
		List<Recommendation> recommendations = fsbService.getFeasibility();
		Assert.assertEquals("This goal should be infeasible.  The algorithm is wrong", 0, recommendations.size());

		TestUtilities.printRecommendationsForValidation(recommendations);
		Assert.assertTrue("Recommendation array is not sorted correctly.", 
				TestUtilities.isRecommendationArraySorted(recommendations));
	}
	
	@Test
	public void testGoalCashFlow() {
		Map<String, Goal> map = utils.getGoalsSortedByMonthlyContribution(0, Arrays.asList(existingGoals));
		double total = 0;
		for (String key : map.keySet()) {
			String[] parts = key.split(Constants.KEY_SEPARATOR);
			double monthly = Double.parseDouble(parts[0]);
			total += monthly;
		}
		Assert.assertEquals("The existing goals should take up 275 monthly.", 275d, total, 1d);
	}
	
	@Test
	public void testMonthlyFrequency() {
		Goal g = TestUtilities.getNewGoal(5, "week", 0, 80, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2015, 4, 1));
		int duration = utils.getDuration(g);
		Assert.assertEquals(17, duration);
		double monthly = utils.getMonthlyFrequency(g);
		Assert.assertEquals("Should be 20 a month", 20d, monthly, 0);
		
		g = TestUtilities.getNewGoal(5, "day", 0, 600, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2015, 4, 1));
		monthly = utils.getMonthlyFrequency(g);
		Assert.assertEquals("Should be 150 a month", 150d, monthly, 0);
		
		g = TestUtilities.getNewGoal(5, "month",0, 20, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2015, 4, 1));
		monthly = utils.getMonthlyFrequency(g);
		Assert.assertEquals("Should be 5 a month", 5d, monthly, 0);
	}
	@Test
	public void testAnotherGoal() {
		Goal newGoal = new Goal();
		newGoal.setDepositFrequency("month");
		newGoal.setTitle("goal");
		newGoal.setFeasibility(2);
		newGoal.setGoalAmount(50d);
		newGoal.setStart(1429733210258l);
		newGoal.setEnd(  newGoal.getStart() + 1432325210258l);//one month
		FeasibilityService fsbService = new FeasibilityService(cf, newGoal, existingGoals);
		List<Recommendation> options = fsbService.getFeasibility();
		System.out.println("Test Stephanie " + options.size());
		TestUtilities.printRecommendationsForValidation(options);
		Assert.assertNotEquals("Should have found at least one goal", 0, options.size());
		Assert.assertTrue("Recommendation array is not sorted correctly.", 
				TestUtilities.isRecommendationArraySorted(options));
	}
	
	@Test
	public void testRoundEndDateDownCorrectly() {
		Goal g = TestUtilities.getNewGoal(0, "month", 0, 50, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2015, 1, 1));
		FeasibilityService fsbService = new FeasibilityService(cf, g, existingGoals);
		List<Recommendation> options = fsbService.getFeasibility();
		Assert.assertNotEquals("Should have found at least one goal", 0, options.size());
		//This should be a feasible goal, not infeasible.
		for (Recommendation option : options) {
			Assert.assertTrue("Recommendation should be true, but its not: " + option, option.isFeasible());
			Assert.assertEquals("All Goals should now be marked as feasible.", 0, option.getGoal().getFeasibility());
			List<Goal> changed = option.getNewGoals();
			if (changed != null) {
				for (Goal chg : changed) {
					Assert.assertEquals("All Goals should now be marked as feasible.", 0, chg.getFeasibility());
				}
			}
		}
	}
	
	@Test
	public void testSmallAmountOverYear() {
		Goal g = TestUtilities.getNewGoal(0, "week", 0, 2, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016, 0, 2));
		FeasibilityService fsbService = new FeasibilityService(cf, g, existingGoals);
		List<Recommendation> options = fsbService.getFeasibility();
		Assert.assertNotEquals("Should have found at least one goal", 0, options.size());
		//This should be a feasible goal, not infeasible.
		TestUtilities.checkOptions(options);
	}
	
	@Test
	public void testSmallAmountOver18Months() {
		Goal g = TestUtilities.getNewGoal(0, "month", 0, 1230, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016, 5, 1));
		
		FeasibilityService fsbService = new FeasibilityService(cf, g, existingGoals);
		List<Recommendation> options = fsbService.getFeasibility();
//		System.out.println("#####");
//		TestUtilities.printRecommendationsForValidation(options);
//		System.out.println("#####");
		Assert.assertNotEquals("Should have found at least one goal", 0, options.size());
		//This should be a feasible goal, not infeasible.
		TestUtilities.checkOptions(options);
	}
	
	@Test
	public void testSmallAmountOver18Months2() {
		Goal g = TestUtilities.getNewGoal(0, "month", 0, 1000, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016, 5, 1));
		
		FeasibilityService fsbService = new FeasibilityService(cf, g, existingGoals);
		List<Recommendation> options = fsbService.getFeasibility();
		Assert.assertNotEquals("Should have found at least one goal", 0, options.size());
		//This should be a feasible goal, not infeasible.
		TestUtilities.checkOptions(options);
	}
	public void testDurationMonth() {
		FeasibilityUtilities util = new FeasibilityUtilities();
		Goal g = TestUtilities.getNewGoal(0, "month", 0, 2, "10000", "Test Goal");
		
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016, 0, 1));
		Assert.assertEquals(12, util.getDuration(g));
		
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016, 5, 1));
		Assert.assertEquals(18, util.getDuration(g));
		
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016, 9, 1));
		Assert.assertEquals(22, util.getDuration(g));
		
		g = TestUtilities.getNewGoal(0, "week", 0, 2, "10000", "Test Goal");
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016, 0, 1));
		Assert.assertEquals(52, util.getDuration(g));
		
		g = TestUtilities.getGoalCustomDates(g, TestUtilities.getDate(2015, 0, 1), TestUtilities.getDate(2016,5, 1));
		Assert.assertEquals(79, util.getDuration(g));
	}
}
