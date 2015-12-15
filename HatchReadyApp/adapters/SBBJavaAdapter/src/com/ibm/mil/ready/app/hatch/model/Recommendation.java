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

import java.util.List;

import com.google.gson.Gson;

/**
 * Represents the Recommendation to return to the client based on any changes made to the goal whose feasibility
 * we want to check and the changes to feasibility of existing goals based on this new goal.
 * 
 */
public class Recommendation {
	private boolean isFeasible;
	private Goal goal;
	private List<Goal> changedGoals;
	
	public boolean isFeasible() {
		return this.isFeasible;
	}
	public void setFeasible(boolean feasible) {
		this.isFeasible = feasible;
	}
	public Goal getGoal() {
		return goal;
	}
	public void setGoal(Goal goal) {
		this.goal = goal;
	}
	public List<Goal> getNewGoals() {
		return changedGoals;
	}
	public void setNewGoals(List<Goal> newGoals) {
		this.changedGoals = newGoals;
	}
	
	public String toString() {
		return new Gson().toJson(this);
	}
}
