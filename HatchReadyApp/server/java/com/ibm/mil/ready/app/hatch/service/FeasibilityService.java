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

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.Recommendation;
import com.ibm.mil.ready.app.hatch.utils.CashFlow;
import com.ibm.mil.ready.app.hatch.utils.Constants;
import com.ibm.mil.ready.app.hatch.utils.FeasibilityUtilities;
import com.ibm.mil.ready.app.hatch.utils.PropertiesReader;
import com.ibm.mil.ready.app.hatch.utils.RecommendationComparer;

/**
 * Class which takes in a new Goal and a set of existing Goals and returns a potentially changed new Goal and some
 * changed existing Goals, which together would make the new Goal feasible based on our cash flow and the constraints
 * of each Goal.
 *
 * In order to use this class, all you need to do is create an instance of the class and then call the 
 * {@link #getFeasibility()} function to determine feasibility.
 * 
 * Note that this class is not thread safe, so ideally you should create a new instance of this class for each
 * feasibility check you want to make.
 */
public class FeasibilityService {
	private final PropertiesReader appProps = PropertiesReader.getInstance();
	private final Goal newGoal;
	private final List<Goal> existingGoals;
	private final double totalMontlyCashFlow;
	private final Map<String, Goal> goalsLookupById;
	private final int MAX_YEARS_TO_EXTEND_GOAL = appProps.getIntProperty(Constants.MAX_YEARS_KEY);
	private final int MAX_EXTENSION_IN_MONTHS = 12 * MAX_YEARS_TO_EXTEND_GOAL;
	private final int MAX_GOALS_TO_REPLACE = appProps.getIntProperty(Constants.MAX_GOALS_CHANGE_KEY);
	private final FeasibilityUtilities utils = new FeasibilityUtilities();
	
	/**
	 * Constructor that creates the FeasibilityService based on all the REQUIRED parameters.
	 * 
	 * @param cf CashFlow object representing the users current cash flow.
	 * @param newGoal The new goal whose feasibility we will want to check
	 * @param existingGoals The list of existing user goals.
	 * @param locale The locale of the user.
	 */
	@SuppressWarnings("PMD.UseVarargs")
	public FeasibilityService(CashFlow cf, Goal newGoal, Goal[] existingGoals) {
		this.newGoal = newGoal;
		if (newGoal != null && newGoal.getDepositAmount() == 0) { 
			newGoal.setDepositAmount(utils.getNewDepositAmountBasedOnDuration(newGoal));
		}
		if (existingGoals == null) {
			this.existingGoals = new ArrayList<Goal>();
		} else {
			this.existingGoals = Arrays.asList(existingGoals);
		}
		double tmpTotal = 0d;
		if (cf != null) {
			for (String acct : cf.getAccounts()) {
				double cashFlowForAcct = cf.getAverageCashFlowForAccount(acct);
				tmpTotal += cashFlowForAcct;
			}
		}
		totalMontlyCashFlow = tmpTotal;

		goalsLookupById = new HashMap<String, Goal>();
		if (existingGoals != null) {
			for (Goal eg : existingGoals) {
				goalsLookupById.put(eg.getId(), eg);
			}
		}
	}
	
	/**
	 * Returns the feasibility of the new goal based on the goal constraints, existing goals, and the persons
	 * cash flow.
	 * 
	 * @return A list of Recommendation objects that may include changes to the new and existing goals that
	 * would allow the new goal to be feasible without changing the feasibility of the existing goals.
	 */
	public List<Recommendation> getFeasibility() {
		List<Recommendation> recommendations = null;
		if (newGoal != null) {
			boolean isFeasibleWithProvidedValues = utils.isFeasibleBasedOnGoalAndDepositAcrossTime(newGoal);
			
			/*
			 * So here we're checking to see if we're feasible with just the parameters set within the goal.
			 * If not, lets make some recommendations as to how they can become feasible.
			 */
			if (isFeasibleWithProvidedValues) {
				recommendations = getRecommendations(newGoal);
			} else {
				//we call these adjusted recommendations cause they represent the fact that you need to change
				//the original goal in order to make it feasible to begin with.
				recommendations = getAdjustedRecommendations(newGoal);
			}
			//Last but not least lets sort the recommendations so we have them like this...
			//1. Recommendations with less changed goals should always be first, then recommendations with more goals
			//2. Within sets of Recommendations that have the same number of goals changed, the Recommendations should
			//   be sorted such that Recommendations with higher priority goals are listed first.
			Collections.sort(recommendations, new RecommendationComparer());
		}
		return recommendations;
	}
	
	/**
	 * Figures out if the new goal is feasible within the following constraints:
	 * 1) is the goal feasible with the available monthly cash flow
	 * 2) is the goal feasible with existing goals (i.e. can we not change any goals and is the new goal still feasible)
	 * 3) if constraint 2 above cannot be met, what goals can we "drop" in order to make the new goal feasible.
	 * 
	 * The function will return a list of recommendations back to the client.  The only time an actual list is
	 * returned is when constraint 3 has to be met.
	 * 
	 * @param g The new goal we want to implement.
	 * @return List of Recommendations in order to make the new goal feasible.
	 */
	private List<Recommendation> getRecommendations(Goal g) {
		List<Recommendation> options = new ArrayList<Recommendation>();
		//So making this even easier.  Lets check if the goal is feasible on its own based on free cash 
		//flow.  
		boolean feasibleWithCashFlow = utils.isFeasibleWithCashFlow(totalMontlyCashFlow, g);
		if (feasibleWithCashFlow) {
			//this goal is no problem with the other goals, lets return "success"
			Goal goal = new Goal(g);
			g.setFeasibility(Constants.FEASIBLE);
			options.add(utils.getRecommendation(true, goal, null));
			options.addAll(getSuccessOptions(g));
		} else {
			//If we got here, there isn't enough free cash to make the goal feasible, lets see how we can adjust other
			//goals to make it feasible.
			options.addAll(getInfeasibleOptions(g));
		}
		return options;
	}
	
	/**
	 * This is the meat function in this class.  Basically it takes the new goal and existing goals (modified by
	 * making them all take some extra amount of time) an determines if the new, longer goals are now feasible
	 * together.  If they are, it returns the Recommendation objects that show how they are now feasible together.
	 * Note that this function does not attempt to make a goal infeasible in order to make the new goal feasible.
	 * 
	 * @param g The new, adjusted goal whose feasibility we want to check
	 * @param map A map of existing goals changed by some duration
	 * @return A list of Recommendations (if any) that would make this new goal feasible without making the existing
	 * goals infeasible.
	 */
	private List<Recommendation> getInfeasibleOptionsForOptions(Goal newGoalSomeTimeOut, SortedMap<String, Goal> map) {
		List<Recommendation> options = new ArrayList<Recommendation>();
		//We basically want to return at least 3 options, and we'll start with the minimal changes first...
		//aka lets move all out a month and see what happens.  We have an upper limit on the amount of goals we
		//can change, so that helps us limit our searching.
		List<String> keys = new ArrayList<String>(map.keySet());
		ArrayList<String> candidateKeys = new ArrayList<String>();
		//the keys at the end will always contain the largest entries so lets look at those first.
		//This for loop looks at all keys and tries to find recommendations where we only have to change one goal
		//to achieve feasibility and adds those to our recommendations options.
		for (int i = keys.size()-1; i >= 0 ; i--) {
			Goal existing = map.get(keys.get(i));
		
			//Whats the cash flow based on the adjusted existing goal..
			double adjustedCashFlow = getAdjustedCashFlow(existing);
			//And then does the new goal fit into the new total available cash flow based on the 
			//Adjusted existing goal.
			if (utils.isFeasibleWithCashFlow(adjustedCashFlow, newGoalSomeTimeOut)) {
				//If we got here then changing the one goal was enough to make the new goal feasible, lets add
				//this change as a recommendation.
				List<Goal> changedGoals = new ArrayList<Goal> ();
				changedGoals.add(existing);
				options.add(utils.getRecommendation(false, newGoalSomeTimeOut, changedGoals));
			} else {
				//If it doesnt then lets see if this goal is a candidate for a multi-existing goal change.
				//If the new adjusted cash flow is greated than 1/Nth of the monthly frequency, then this
				//goal is a candidate to be joined with other goals to achieve feasibility.
				//This is rudimentary if there is one goal just slightly less than 1/maxgoals of the monthly needed
				//for the new adjusted goal.  Better ways to do this but this is easier.
				double nthPart = utils.getMonthlyFrequency(newGoalSomeTimeOut)/this.MAX_GOALS_TO_REPLACE;
				if (adjustedCashFlow >= nthPart) {
					candidateKeys.add(keys.get(i));
				}
			}
		}
		//Only if we haven't found the minimum amount of recommendations should we keep looking for more.
		if (options.size() < Constants.MIN_RECOMMENDATIONS){
			options.addAll(getRecommendationsOffCandidateList(candidateKeys, newGoalSomeTimeOut, map));
		}
			
		return options;
	}
	
	private List<Recommendation> getRecommendationsOffCandidateList(ArrayList<String> candidateKeys,
			Goal newGoalSomeTimeOut, SortedMap<String, Goal> map) {
		List<Recommendation> options = new ArrayList<Recommendation>();
		//Here we look to see if any keys can be combined to make this goal feasible.  We want
		//to stay within our MAX_GOALS_TO_REPLACE setting.  We just want to ensure we don't change all goals
		//to make one feasible. Note its not possible to combine goals without a minimum of 2 goals.
		if (candidateKeys.size() > 2) {
			//Note that these keys are sorted by largest number first
			//This first check is easy, if there's at least MAX_GOALS_TO_REPLACE goals 
			//we can make a new recommendation out of the goals. 
			if (candidateKeys.size() == MAX_GOALS_TO_REPLACE) {
				Recommendation r = utils.getRecommendationFromCandidateKeys(map, 
						candidateKeys, newGoalSomeTimeOut);
				options.add(r);
			} else if (candidateKeys.size() < MAX_GOALS_TO_REPLACE){
				//We have less than the minimum required to be sure we can use this as a recommendation. lets see anyway.
				List<Goal> adjustedGoals = new ArrayList<Goal>();
				for (String candidate : candidateKeys) {
					adjustedGoals.add(map.get(candidate));
				}
				double adjustedCashFlow = getAdjustedCashFlow(adjustedGoals.toArray(new Goal[]{}));
				if (utils.isFeasibleWithCashFlow(adjustedCashFlow, newGoalSomeTimeOut)) {
						options.add(utils.getRecommendation(false, newGoalSomeTimeOut, adjustedGoals));
				}
			} else {
				List<Goal> adjustedGoals = new ArrayList<Goal>();
				for (String candidate : candidateKeys) {
					adjustedGoals.add(map.get(candidate));
				}
				Collections.sort(adjustedGoals, utils.getGoalComparer());
				//we have more than enough goals to make a recommendation, lets make some random combinations.
				for (int i = 0 ; i <= (adjustedGoals.size() - MAX_GOALS_TO_REPLACE) ; ++i) {
					List<Goal> subCandidates = adjustedGoals.subList(i,MAX_GOALS_TO_REPLACE + i);
					Recommendation r = utils.getRecommendation(false, newGoalSomeTimeOut, subCandidates);
					options.add(r);
				}
			}
		}
		
		return options;
	}
	
	/**
	 * This method will call {@link #getInfeasibleOptionsForOptions(Goal, SortedMap)} several times until it either
	 * reaches the max amount of time its allowed to push back a goals end date (default is 5 years) or it finds
	 * some minimum amount of recommendations (default is 3).
	 * 
	 * The method executes by moving out the end date by the following intervals and rechecking feasibility based
	 * on the new end dates for both the new goal and the existing goals.
	 * 
	 *  1 month
	 *  3 months
	 *  6 months
	 * 12 months
	 * 24 months
	 *  5 years //This is configurable, but defaults to 5 years
	 * 
	 * @param g The Goal we want to see if its feasible after adjusting all goals end dates.
	 * @return The list of Recommendations (if any) that would make the new goal (g) feasible and keep the feasibility
	 * of existing goals the same.
	 */
	private List<Recommendation> getInfeasibleOptions(Goal g) {
		//so our goal is infeasible, lets start by moving goals one month out and see if we find feasibility options
		//if not next move to 3 months out, etc.
		List<Recommendation> options = new ArrayList<Recommendation>();
		int[] stepTimeIntervals = new int[] {1, 3, 6, 12, 24, MAX_EXTENSION_IN_MONTHS};
		//We'll basically loop over our time intervals that we're pushing back until we 
		for (int i = 0 ; i < stepTimeIntervals.length ; ++i) {
			int stepChange = stepTimeIntervals[i];
			List<Recommendation> someOptions = getInfeasibleOptionsForOptions(
					utils.getChangedGoalBasedOnExtraDuration(g, stepChange), 
					utils.getGoalsSortedByMonthlyContribution(stepChange, existingGoals));
			options.addAll(someOptions);
			if (options.size() >= Constants.MIN_RECOMMENDATIONS) {
				break;
			}
		}
		
		return options;
	}
	
	/**
	 * Returns a new adjusted cash flow.  Basically this takes in the total cash flow, and adjusts it (usually means
	 * the total cash flow will get larger) by taking in an adjusted existing goal and adding back the amount of 
	 * money being saved by moving the goals durations back.
	 * 
	 * The adjusted goal's end date has been pushed out some amount of time, which in turn possibly reduced
	 *  its deposit amount, and thus accounts for less against the total cash flow).
	 * 
	 * @param adjustedGoals The adjusted goals whose changed contribution amounts we want to potentially add back
	 * to our monthly cash flow.
	 * @return The new available free cash based on the adjusted goals new contribution amounts.
	 */
	private double getAdjustedCashFlow(Goal... adjustedGoals) {
		double adjusted = totalMontlyCashFlow;
		for (Goal g : adjustedGoals) {
			//First we figure out the difference between the original existing goals monthly contribution
			//and the its new adjusted contribution. The adjusted contribution shoudl always be less than
			//the original contribution by some amount.
			Goal origGoal = goalsLookupById.get(g.getId());
			double origGoalMonthly = utils.getMonthlyFrequency(origGoal);
			double newGoalMonthly = utils.getMonthlyFrequency(g);
			double difference = origGoalMonthly - newGoalMonthly;
			//Then we add this positive difference back to the available cash flow we have now.
			adjusted += difference ;
		}
		
		//In the end, the adjusted cash flow is always higher than the amount we had previously.
		return adjusted;
	}
	
	/**
	 * Some contrived adjustments that could be made to existing goals.  These really aren't needed as the new goal
	 * is actually feasible within its given constraints and existing cash flow and existing goals.
	 * 
	 * @param g The new goal who is already feasible
	 * @return Some more Recommendations for when the new goal is already feasible.
	 */
	private List<Recommendation> getSuccessOptions(Goal g) {
		List<Recommendation> options = new ArrayList<Recommendation>();
		//First, can we optimize the goal end date further?
		Goal optimized = goalOptimized(g);
		System.out.println("");
		Recommendation optimizedGoal = utils.getRecommendation(true, optimized, null);
		options.add(optimizedGoal);
		
		//What can reduce the goal by not taking up more free cash but instead removing cash from a goal?
		List<Goal> goalsWithHighestFrequencyPayment = utils.getLastTwoInSortedMap(
				utils.getGoalsSortedByMonthlyContribution(1, existingGoals) );
		Goal newGoalOneMonthOut = utils.getChangedGoalBasedOnExtraDuration(g, 1);
		for(Goal goalToRecommend : goalsWithHighestFrequencyPayment) {
			List<Goal> changedGoals = new ArrayList<Goal>();
			changedGoals.add(goalToRecommend);
			Recommendation r = utils.getRecommendation(true, newGoalOneMonthOut, changedGoals);
			options.add(r);
		}
		return options;
	}
	
	/**
	 * "Optimizes" the goal by seeing whats the shortest amount of time we could spend acheiving this goal if we
	 * put all our free cash into it.
	 * @param g The new goal which is already feasible
	 * @return A new goal whose end date is the shortest it could possibly be based on the users free cash.s
	 */
	private Goal goalOptimized(Goal g) {
		Goal optimized = new Goal(g);
		//do we have more cashflow than this goal?
		if (totalMontlyCashFlow > optimized.getGoalAmount()) {
			//new end date is start date as you only need one payment :)
			optimized.setEnd(optimized.getStart());
			optimized.setDepositAmount(optimized.getGoalAmount());
		} else {
			//we dont have enough cash flow to take care of this goal with one payment, whast the shortest we could
			//make it....basically lets set the depositAmount to the totalFreeCash minus a few bucks and recalculate
			//**lets not take the whole thing, lets leave some free cashflow
			double newDeposit = totalMontlyCashFlow * .9d;
			double formatted = Double.parseDouble(new DecimalFormat("#.00").format(newDeposit));
			optimized.setDepositAmount(formatted);
			long newEnd = utils.calculateNewDuration(optimized);
			optimized.setEnd(newEnd);
		}
		return optimized;
	}

	/**
	 * So if you call this method, then the goal is not feasible within its parameters. Usually this means that
	 * the amount of money you are saving is insufficient for the amount of time you will be saving that money. This
	 * method basically adjusts the new goal in two ways to make it feasible and then checks the goals feasibility
	 * based on these new settings.  The two ways it changes the goals are:
	 * 
	 * 1. Leave the end date alone and increase the deposit amount so that the goal is now achieveable in the specified
	 * amount of time.
	 * 
	 * 2. Leave the contribution amount alone and extend the Goal's end date so that the goal is now achievable based
	 * on the amount we are saving based on the frequency of the deposits.
	 * 
	 * @param newGoal The original goal that was not feasible based on its own constraints.
	 * @return Any recommendations found by changing the goals constraints to make it achievalbe within its own
	 * constraints.
	 */
	private List<Recommendation> getAdjustedRecommendations(Goal newGoal) {
		List<Recommendation> recommendations = new ArrayList<Recommendation>();
		double formatted = utils.getNewDepositAmountBasedOnDuration(newGoal);
		Goal goalNewPayment = new Goal(newGoal);
		goalNewPayment.setDepositAmount(formatted);
		//getRecommendations(Goal) will never return null so its safe to call addAll()
		recommendations.addAll(getRecommendations(goalNewPayment));
		if (recommendations.size() < Constants.MIN_RECOMMENDATIONS) {
			long newEnd = utils.calculateNewDuration(newGoal);
			Goal goalNewDuration = new Goal(newGoal);
			goalNewDuration.setEnd(newEnd);
			//getRecommendations(Goal) will never return null so its safe to call addAll()
			recommendations.addAll(getRecommendations(goalNewDuration));
		}
		//Since we had to change the original goal, its actually not feasible, so let me change feasiblity just in
		//case
		for (Recommendation r : recommendations) {
			r.setFeasible(false);
		}
		return recommendations;
	}
}