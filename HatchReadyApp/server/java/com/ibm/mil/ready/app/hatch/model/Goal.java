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
import com.ibm.mil.ready.app.hatch.utils.DateUtils;

/**
 * Pojo that represents a Goal
 */
public class Goal extends CloudantObject {
	private String ownerID;
	private String title;
	private long start;
	private long end;
	private double goalAmount;
	private double saved;
	private double depositAmount;
	private String depositFrequency;
	private double progress;
	private String businessID;
	/*
	 * 0 = feasible
	 * 1 = warning
	 * 2 = unfeasible
	 */
	private int feasibility;
	private int priority;
	private String notes;
	private int weeksLeft;
	private int monthsLeft;
	
	/**
	 * default constructor
	 */
	public Goal() {
		super();
	}
	/**
	 * sets the goal attribute for a Goal instance
	 * @param g
	 */
	public Goal(Goal g) {
		super(g);
		this.ownerID = g.getOwnerID();
		this.title = g.getTitle();
		this.start = g.getStart();
		this.end = g.getEnd();
		this.goalAmount = g.getGoalAmount();
		this.saved = g.getSaved();
		this.depositAmount = g.getDepositAmount();
		this.depositFrequency = g.getDepositFrequency();
		this.progress = g.getProgress();
		this.feasibility = g.getFeasibility();
		this.priority = g.getPriority();
		this.notes = g.getNotes();
	}
	/**
	 * gets the goals priority
	 * @return priority
	 */
	public int getPriority() {
		return priority;
	}
	/**
	 * sets the goal priority
	 * @param priority
	 */
	public void setPriority(int priority) {
		this.priority = priority;
	}
	/**
	 * gets the notes for the gaol
	 * @return notes
	 */
	public String getNotes() {
		return notes;
	}
	/**
	 * sets the notes for the goal
	 * @param notes
	 */
	public void setNotes(String notes) {
		this.notes = notes;
	}
	/**
	 * gets the feasibility
	 * @return feasibility
	 */
	public int getFeasibility() {
		return feasibility;
	}
	/**
	 * sets the feasibility
	 * @param feasibility
	 */
	public void setFeasibility(int feasibility) {
		this.feasibility = feasibility;
	}
	/**
	 * gets the progress
	 * @return progress
	 */
	public double getProgress() {
		return progress;
	}
	/**
	 * sets the progress
	 * @param progress
	 */
	public void setProgress(double progress) {
		this.progress = progress;
	}
	/**
	 * gets the ownerID
	 * @return ownerID
	 */
	public String getOwnerID() {
		return ownerID;
	}
	/**
	 * sets the ownerID
	 * @param ownerID
	 */
	public void setOwnerID(String ownerID) {
		this.ownerID = ownerID;
	}
	/**
	 * gets the goal title
	 * @return title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * sets the goal title
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * gets the goal start
	 * @return start
	 */
	public long getStart() {
		return start;
	}
	/**
	 * sets the goal start
	 * @param start
	 */
	public void setStart(long start) {
		this.start = start;
	}
	/**
	 * gets the goal end date
	 * @return end
	 */
	public long getEnd() {
		return end;
	}
	/**
	 * sets the gold end date
	 * @param end
	 */
	public void setEnd(long end) {
		this.end = end;
	}
	/**
	 * gets the goal amount
	 * @return goalAmount
	 */
	public Double getGoalAmount() {
		return goalAmount;
	}
	/**
	 * sets the goal amount
	 * @param goalAmount
	 */
	public void setGoalAmount(Double goalAmount) {
		this.goalAmount = goalAmount;
	}
	/**
	 * gets the saved amount
	 * @return saved
	 */
	public Double getSaved() {
		return saved;
	}
	/**
	 * sets the saved amount
	 * @param saved
	 */
	public void setSaved(Double saved) {
		this.saved = saved;
	}
	/**
	 * gets the deposit amount
	 * @return depositAmount
	 */
	public Double getDepositAmount() {
		return depositAmount;
	}
	/**
	 * sets the deposit amount
	 * @param depositAmount
	 */
	public void setDepositAmount(Double depositAmount) {
		this.depositAmount = depositAmount;
	}
	/**
	 * gets the deposit frequency
	 * @return depositFrequency
	 */
	public String getDepositFrequency() {
		return depositFrequency;
	}
	/**
	 * sets the depoist frequency
	 * @param depositFrequency
	 */
	public void setDepositFrequency(String depositFrequency) {
		this.depositFrequency = depositFrequency;
	}
	/**
	 * gets the business ID
	 * @return businessID
	 */
	public String getBusinessID() {
		return businessID;
	}
	/**
	 * sets the businessID
	 * @param businessID
	 */
	public void setBusinessID(String businessID) {
		this.businessID = businessID;
	}
	/**
	 * 
	 * enum for Frequency
	 *
	 */
	public static enum Frequency {
		day, week, month;
	}
	/**
	 * converts the data object into a JSON object 
	 */
	public String toString() {
		return new Gson().toJson(this);
	}
	/**
	 * updates the weeksLeft and monthsLeft variables based on the duration between the current time and the goal's end date
	 */
	public void updateTimeLeft() {
		Long currentTime = System.currentTimeMillis();
		weeksLeft = DateUtils.differenceInWeeks(currentTime, end);
		monthsLeft = DateUtils.differenceInMonths(currentTime, end);
	}
	/**
	 * get weeksLeft duration
	 * @return weeksLeft
	 */
	public int getWeeksLeft() {
		return weeksLeft;
	}
	/**
	 * get monthsLeft duration
	 * @return monthsLeft
	 */
	public int getMonthsLeft() {
		return monthsLeft;
	}
}


