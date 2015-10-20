package com.ibm.mil.ready.app.hatch.utils;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.Goal.Frequency;
import com.ibm.mil.ready.app.hatch.model.Recommendation;

public class FeasibilityUtilities {
	/**
	 * Calculates the actual number of deposits required to meet the Goal amount
	 * based on the deposit amount. This actually ends up being the number of
	 * weeks or months needed to meet the goal amount criteria.
	 * 
	 * @param g
	 *            The goal whose number of deposits we want to calculate.
	 * @return int representing the number of weeks or months required to meet
	 *         the goal amount.
	 */
	public int calculateNewDurationBasedOnDollarRequirements(Goal g) {
		int newDuration = Double.valueOf(g.getGoalAmount() / g.getDepositAmount())
				.intValue();
		if (g.getGoalAmount() % g.getDepositAmount() > 0) {
			newDuration += 1;
		}
		return newDuration;
	}

	/**
	 * Returns true if the @Goal specified has a weekly frequency specified,
	 * false otherwise
	 * 
	 * @param g
	 *            The Goal to check
	 * @return True if the Goal's frequency is weekly, false otherwise.
	 */
	public boolean isGoalWeekly(Goal g) {
		boolean weekly = false;
		if (g != null) {
			weekly = Frequency.week.toString().equals(g.getDepositFrequency());
		}
		return weekly;
	}

	/**
	 * Returns true if the @Goal specified has a monthly frequency specified,
	 * false otherwise
	 * 
	 * @param g
	 *            The Goal to check
	 * @return True if the Goal's frequency is monthly, false otherwise.
	 */
	public boolean isGoalMonthly(Goal g) {
		boolean monthly = false;
		if (g != null) {
			monthly = Frequency.month.toString()
					.equals(g.getDepositFrequency());
		}
		return monthly;
	}

	/**
	 * Gets the appropriate duration (days, weeks or months) for this Goal. The
	 * integer returned represents the total amount of days/weeks/months needed
	 * to complete this goal.
	 * 
	 * @param g
	 *            The goal to get the duration
	 * @return
	 */
	public int getDuration(Goal g) {
		int duration = DateUtils.differenceInWeeks(g.getStart(), g.getEnd()).intValue();
		if (isGoalMonthly(g)) {
			duration = DateUtils.differenceInMonths(g.getStart(), g.getEnd()).intValue();
		} 
		return duration;
	}

	/**
	 * Takes a goal and changes the Goal's deposit amount so that the goal is
	 * now achievable based on the contribution amount, contribution frequency
	 * and the end date of the goal.
	 * 
	 * @param g
	 *            The goal which is unachieveable
	 * @return A new goal which is achieveable based on its own constraints
	 *         after its deposit amount has been changed.
	 */
	public double getNewDepositAmountBasedOnDuration(Goal g) {
		int duration = getDuration(g);
		double depAmt = Double.parseDouble(new DecimalFormat("#.00").format(g.getGoalAmount() / duration));
		if (depAmt * duration < g.getGoalAmount()) {
			depAmt += .01d;
		}
		return depAmt;
	}

	/**
	 * Gets the total amount spent per month on this goal. Since a goal can have
	 * different frequencies, month, week, etc, this method will convert the
	 * contribution amount based on the frequency to report the monthly
	 * expenditure.
	 * 
	 * @param g
	 *            The goal we want to see how much we are spending per month.
	 * @return The amount we spend per month on this goal.
	 */
	public double getMonthlyFrequency(Goal g) {
		int months = DateUtils.differenceInMonths(g.getStart(), g.getEnd());
		return g.getGoalAmount() / (double)months;
	}

	/**
	 * This function checks the Goal as defined to see if you can actually
	 * achieve the desired goal amount in the duration defined within the goal
	 * and the specified contribution amount and frequency.
	 * 
	 * @return True if the goal is achievable based on the goals metrics, false
	 *         otherwise.
	 */
	public boolean isFeasibleBasedOnGoalAndDepositAcrossTime(Goal newGoal) {
		double goalLength = getDuration(newGoal);
		double frequency = newGoal.getDepositAmount();
		double totalCashBasedOnFrequency = goalLength * frequency;
		return totalCashBasedOnFrequency >= newGoal.getGoalAmount();
	}

	/**
	 * Returns true if the goals total monthly required cash savings is less
	 * than the amount of cash flow we have on average. Will return false if the
	 * new goal has
	 * 
	 * @param g
	 * @return
	 */
	public boolean isFeasibleWithCashFlow(double monthlycashflow, Goal g) {
		double monthlyGoalRequirements = getMonthlyFrequency(g);
		return monthlycashflow > monthlyGoalRequirements;
	}

	/**
	 * Calculates the new end date for a Goal based on the deposit amount and
	 * the goal amount. Usually this means that the goal as defined cant be
	 * reached based on the goal amount, deposit amount, and duration based on
	 * the frequency so we want to calculate a new end date that will make this
	 * goal realistic based on the other settings.
	 * 
	 * @param g
	 *            The goal whose settings aren't feasible to realize the goal
	 * @return long representing the new end date which would make the goal
	 *         feasible based on the Goal amount, the deposit amount and deposit
	 *         frequency.
	 */
	public long calculateNewDuration(Goal g) {
		int newDuration = calculateNewDurationBasedOnDollarRequirements(g);
		Goal tmp = isGoalMonthly(g) ? 
				extendGoalByNum(g, newDuration, true) : 
					extendGoalByNum(g, newDuration, false);
		return tmp.getEnd();
	}

	/**
	 * This returns the two most expensive Goal's, based on monthly
	 * contributions, so that we can use them to contrive some new
	 * Recommendations that we really don't need to implement.
	 * 
	 * @param map
	 *            The sorted map of existing goals. The goals are sorted in
	 *            ascending order based on monthly contribution
	 * @return The two goals with the highest monthly contributions
	 */
	public List<Goal> getLastTwoInSortedMap(SortedMap<String, Goal> map) {
		Goal last = map.remove(map.lastKey());
		Goal nextToLast = map.get(map.lastKey());
		// Lets put the last two back on
		String key = getMonthlyFrequency(last) + Constants.KEY_SEPARATOR
				+ last.getId();
		map.put(key, last);
		List<Goal> last2 = new ArrayList<Goal>();
		last2.add(nextToLast);
		last2.add(last);
		return last2;
	}

	/**
	 * This is a convenience method to return a recommendation based on a list
	 * of changed existing goals. The goals are pulled from a map which has
	 * modified existing goals.
	 * 
	 * @param map
	 *            The map of modified existing goals
	 * @param candidateKeys
	 *            The keys from which we want to build the recommendation from.
	 * @param adjustdGoal
	 *            The new, adjusted goal we want to build the recommendation
	 *            for.
	 * @return The Recommendation based on the new goal and changed existing
	 *         goals.
	 */
	public Recommendation getRecommendationFromCandidateKeys(
			SortedMap<String, Goal> map, List<String> candidateKeys,
			Goal adjustdGoal) {
		List<Goal> adjustedGoals = new ArrayList<Goal>();
		for (String candidate : candidateKeys) {
			adjustedGoals.add(map.get(candidate));
		}
		return getRecommendation(false, adjustdGoal, adjustedGoals);
	}

	/**
	 * Helper method to construct a Recommendation object.
	 * 
	 * @param feasible
	 *            boolean whether goal is feasible or not.
	 * @param g
	 *            The goal whose feasibility we were checking.
	 * @param goals
	 *            The existing goals, possible changed based on what was needed
	 *            to make the new goal feasible.
	 * @param messageKey
	 *            A message to report back to the client.
	 * @param args
	 *            The arguments needed to fill out the message.
	 * @return A Recommendation object based the provided parameters.
	 */
	public Recommendation getRecommendation(boolean feasible, Goal g,
			List<Goal> changedGoals) {
		//Lets chnge the feasibliity in the goals cause they should be feasible after all the chnages.
		g.setFeasibility(0);
		if (changedGoals != null) {
			for (Goal chg: changedGoals) {
				chg.setFeasibility(0);
			}
		}
		
		//Now lets create the recommendation object.
		Recommendation r = new Recommendation();
		r.setFeasible(feasible);
		r.setGoal(g);
		r.setNewGoals(changedGoals);
		return r;
	}

	/**
	 * Returns a new Goal, with the appropriate members being changed (end and
	 * deposit amount) based on some amount of time that we want to extend this
	 * goals duration. So lets say the goal originally would require 4 months to
	 * complete, and you pass in an extra month of duration, it would return you
	 * a new goal that would end a month later with its deposit amount modified
	 * to account for this longer duration.
	 * 
	 * @param g
	 *            The goal whose duration we want to extend
	 * @param extraDurationInMonths
	 *            The amount of time (in milliseconds) we want to extend this
	 *            goal
	 * @return A new goal with the new end date and adjusted deposit amount
	 *         based on the longer duration.
	 */
	public Goal getChangedGoalBasedOnExtraDuration(Goal g, int extraDurationInMonths) {
		// To calculate new deposit amount, we need to figure out how much we
		// have remaining on our goal
		double amtLeft = g.getGoalAmount() - g.getSaved();
		// Lets save these values to a temporary goal as the method to calculate
		// new deposits takes a goal as
		// a parameter.
		Goal tmp = extendGoalByNumMonths(g, extraDurationInMonths);
		tmp.setGoalAmount(amtLeft);

		// Now based on the new goal amount, and the new end goal, lets figure
		// out the deposit amount
		double newDepositAmount = getNewDepositAmountBasedOnDuration(tmp);

		// Now lets update the original goal to have the new end date and new
		// deposit amount.
		Goal modifiedDepositAmount = new Goal(g);
		modifiedDepositAmount.setEnd(tmp.getEnd());
		modifiedDepositAmount.setDepositAmount(newDepositAmount);
		return modifiedDepositAmount;
	}
	
	public Comparator<Goal> getGoalComparer() {
		return new GoalComparer();
	}

	/**
	 * Class that helps the Collections.sort() method to sort goals by priority.
	 */
	private class GoalComparer implements Comparator<Goal> {
		public int compare(Goal r1, Goal r2) {
			int compareResults = Constants.EQUAL;
			if (r1.getPriority() < r2.getPriority()) {
				compareResults = Constants.LESS_THAN;
			} else if (r1.getPriority() > r2.getPriority()) {
				compareResults = Constants.GREATER_THAN;
			}
			return compareResults;
		}
	}

	/**
	 * This method takes in some additional duration, and returns a map that has
	 * a key of monthly frequency + '-' + goal.id and the adjusted goal. The map
	 * is sorted so that the goals with the lowest monthly expenditure are
	 * listed first when you loop over the key set.
	 * 
	 * They key is a concatenation of the deposit amount and the goal id as this
	 * is a map that does not allow duplicates, so if two goals deposit the same
	 * amount of money monthly then the two goals would not be in the map. This
	 * ensures the keys are unique and that each goal is added to the sorted map
	 * as intended.
	 * 
	 * @param additionalDurationInMonths
	 *            The amount of time to shift each existing goals end date by
	 * @return List of existing goals whose end date has been pushed out by
	 *         additionalDurationMillis amount of time and had their deposit
	 *         amount modified accordingly.
	 */
	public SortedMap<String, Goal> getGoalsSortedByMonthlyContribution(
			int additionalDurationInMonths, List<Goal> existingGoals) {
		SortedMap<String, Goal> tmp = new TreeMap<String, Goal>();
		for (Goal g : existingGoals) {
			Goal goalNewDuration = getChangedGoalBasedOnExtraDuration(g,
					additionalDurationInMonths);
			if (goalNewDuration.getFeasibility() == Constants.FEASIBLE) {
				tmp.put(getMonthlyFrequency(goalNewDuration)
						+ Constants.KEY_SEPARATOR + goalNewDuration.getId(),
						goalNewDuration);
			}	
		}
		return tmp;
	}
	
	private Goal extendGoalByNumMonths(Goal g, int months) {
		return extendGoalByNum(g, months, true);
	}
	private Goal extendGoalByNum(Goal g, int duration, boolean month) {
		Calendar c = new GregorianCalendar();
		c.setTime(new Date(g.getEnd()));
		int type = month ? Calendar.MONTH : Calendar.WEEK_OF_YEAR;
		c.add(type, duration);
		Goal updated = new Goal(g);
		updated.setEnd(c.getTime().getTime());
		return updated;
	}
}
