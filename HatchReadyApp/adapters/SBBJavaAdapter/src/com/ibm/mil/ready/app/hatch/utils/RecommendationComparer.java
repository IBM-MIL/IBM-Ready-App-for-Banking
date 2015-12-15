package com.ibm.mil.ready.app.hatch.utils;

import java.io.Serializable;
import java.util.Comparator;
import java.util.List;

import com.ibm.mil.ready.app.hatch.model.Goal;
import com.ibm.mil.ready.app.hatch.model.Recommendation;

public class RecommendationComparer implements Serializable,Comparator<Recommendation> {
	private static final long serialVersionUID = -2836500406539002655L;

	public int compare(Recommendation r1, Recommendation r2) {
		int compareResults = Constants.EQUAL;
		List<Goal> r1Changed = r1.getNewGoals();
		List<Goal> r2Changed = r2.getNewGoals();
		if (r2Changed == null && r1Changed == null) {
			compareResults = Constants.EQUAL;
		} else if (r1Changed == null && r2Changed != null) {
			//If r1 is null, we want it to show up first, so it should be larger than the others since
			//the list should be sorted in descending order.
			compareResults = Constants.REVERSE_GREATER_THAN;
		} else if (r1Changed != null && r2Changed == null) {
			//If r2 is null, we want it to show up first, so it should be larger than the others since
			//the list should be sorted in descending order.
			compareResults = Constants.REVERSE_LESS_THAN;
		} else {
			compareResults = getCompareNoneNull(r1Changed, r2Changed);
		}
		return compareResults;
	}
	
	private int getCompareNoneNull(List<Goal> r1, List<Goal> r2) {
		int result = Constants.EQUAL;
		if (r1.size() < r2.size()) {
			result = Constants.REVERSE_LESS_THAN;//Constants.LESS_THAN;
		} else if (r1.size() > r2.size()) {
			result = Constants.REVERSE_GREATER_THAN;//Constants.GREATER_THAN;
		} else if (r1.size() == r2.size()) {
			result = getSameSizeComparison(r1, r2);
		}
		return result;
	}
	
	private int getSameSizeComparison(List<Goal> r1, List<Goal> r2) {
		//Heres the real logic...when they return the same amount of recommendations, we have
		//to sort by priority...this is relatively simple algorithm and does a decent job. 
		int compareResults = Constants.EQUAL;
		int r1tot = 0;
		int r2tot = 0;
		for (Goal g : r1) {
			r1tot += g.getPriority();
		}
		for (Goal g : r2) {
			r2tot += g.getPriority();
		}
		if (r1tot == r2tot) {
			compareResults = Constants.EQUAL;
		} else if (r1tot < r2tot) {
			compareResults = Constants.REVERSE_LESS_THAN;//Constants.LESS_THAN;
		} else {
			compareResults = Constants.REVERSE_GREATER_THAN;//Constants.GREATER_THAN;//r1tot > r2tot
		}
		return compareResults;
	}
}
