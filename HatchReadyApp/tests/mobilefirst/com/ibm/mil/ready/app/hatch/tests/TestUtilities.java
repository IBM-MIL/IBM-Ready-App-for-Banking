package com.ibm.mil.ready.app.hatch.tests;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.junit.Assert;

import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.MonthBalance;
import com.ibm.mil.ready.app.hatch.model.Recommendation;
import com.ibm.mil.ready.app.hatch.utils.CashFlow;

public class TestUtilities {
	public static CashFlow getCashFlow() {
		CashFlow flow = new CashFlow();
		flow.setMonthsOfData(3);
		MonthBalance mb = new MonthBalance();
		mb.setMonth(0);
		mb.setBalance(300.15);
		flow.addMonthBalanceToAccount(TestConstants.ACCT1, mb);
		//System.out.println("cashFlow: " + flow);
		return flow;
	}
	
	public static Goal[] getExistingGoals() {
		List<Goal> existingGoals = new ArrayList<Goal>();
		//we have 300 free, lets get close to it.
		//50 a month for 4 months to make 200
		existingGoals.add(newGoal(50, "month", 4, 200, "1001", 0, "Payoff Visa"));
		//20 a month for 5 months to make 100
		existingGoals.add(newGoal(5, "week", 5, 100, "1002", 1, "new plant"));
		//100 a month for 10 months to make 1000
		existingGoals.add(newGoal(100, "month", 10, 1000, "1003", 2, "new tv"));
		//15 a month for 40 months to make 600
		existingGoals.add(newGoal(15, "month",  40, 600, "1004", 3, "New mirror"));
		
		//to here its 185 per month so far
		
		//40 a month for 15 months
		existingGoals.add(newGoal(10, "week", 15, 600, "1005", 4, "New oven"));
		//50 a month for 24 months
		existingGoals.add(newGoal(12.50, "week", 24, 1200, "1006", 5, "New location"));

		//using up 275 per month with all these goals
		return existingGoals.toArray(new Goal[]{});
	}
	
	public static Goal newGoal(double depositAmount, String depositFrequency, int duration, 
			double goalAmount, String id, int priority, String title) {
		Goal g = getNewGoal(depositAmount, depositFrequency, 0, goalAmount, id, priority, title);
		Date start = getDate(2015, 0, 1);
		Calendar c = new GregorianCalendar();
		c.setTime(start);
		c.add(Calendar.MONTH, duration);
		g = TestUtilities.getGoalCustomDates(g, start, c.getTime());
		return g;
	}
	
	public static Goal getNewGoal(double depositAmount, String depositFrequency, long end, 
			double goalAmount, String id, String title) {

		return getNewGoal(depositAmount, depositFrequency, end, goalAmount, id, 0, title);
	}
	
	public static Goal getNewGoal(double depositAmount, String depositFrequency, long end, 
			double goalAmount, String id, int priority, String title) {
		Goal g = new Goal();
		g.setDepositAmount(depositAmount );
		g.setDepositFrequency(depositFrequency);
		g.setEnd(System.currentTimeMillis() + end);
		g.setFeasibility(0);
		g.setGoalAmount(goalAmount);
		g.setId(id);
		g.setNotes("I'm goal the new goal!");
		g.setOwnerID(TestConstants.OWNER_ID);
		g.setPriority(priority);
		g.setProgress(0d);
		g.setSaved(0d);
		g.setStart(System.currentTimeMillis());
		g.setTitle(title);
		g.setType("goal");

		return g;
	}
	
	public static void printRecommendationsForValidation(List<Recommendation> options) {
		if (options!= null) {
			for (Recommendation r : options) {
				List<Goal> changed = r.getNewGoals();
				if (changed != null) {
					System.out.println("changed goals: " + changed.size() + ", Recommendation: " + r);
					for (Goal g : changed) {
						System.out.println("goal: " + g.getTitle() + ", priority: " + g.getPriority());
					}
				} else {
					System.out.println(" Recommendation: " + r);
				}
			}
			System.out.println("*******************");
		}
	}
	
	public static boolean isRecommendationArraySorted(List<Recommendation> options) {
		boolean isSortedCorrectly = true;
		
		if (options != null) {
			for (int i = 1; i < options.size() ; ++i) {
				int myPriority = getRecommendationChangesTotal(options.get(i));
				int previousPriority = getRecommendationChangesTotal(options.get(i-1));
				isSortedCorrectly &= (previousPriority >= myPriority);
			}
		}
		
		return isSortedCorrectly;
	}
	
	private static int getRecommendationChangesTotal(Recommendation r) {
		//Set priorityCount = 1000 so that null changed goals have a higher priority than any recommendation
		//with an actual set of changed goals.  We want to minimize the amount of changed goals chosen.
		int priorityCount = 10000;
		if (r.getNewGoals() != null) {
			priorityCount = 0;
			for (Goal g : r.getNewGoals()) {
				priorityCount += g.getPriority();
			}
		}
		return priorityCount;
	}
	
	public static void checkOptions(List<Recommendation> options) {
		if (options != null) {
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
	}
	public static Date getDate(int year, int month, int date) {
		Calendar c = new GregorianCalendar();
		c.set(year, month, date);
		return c.getTime();
	}
	
	public static Goal getGoalCustomDates(Goal g, Date start, Date end) {
		Goal ng = new Goal(g);
		ng.setStart(start.getTime());
		ng.setEnd(end.getTime());
		return ng;
	}
}
