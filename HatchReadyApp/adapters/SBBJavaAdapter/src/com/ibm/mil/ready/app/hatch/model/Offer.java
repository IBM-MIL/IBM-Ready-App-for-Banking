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

/**
 * Pojo that represents an Offer
 */
public class Offer extends CloudantObject {
	private String name;
	private Double apy;
	private String fee;
	private Integer withdrawals;
    private Integer overdraft;
    private Integer liquidity;
	private Feature[] features;
	
	/*
	 * default constructor
	 */
	public Offer() {
		super();
	}
	/**
	 * sets the offer attribute for a Offer instance
	 * @param o
	 */
	public Offer(Offer o) {
		super(o);
		this.name = o.getName();
		this.apy = o.getApy();
		this.withdrawals = o.getWithdrawals();
		this.overdraft = o.getOverdraft();
		this.liquidity = o.getLiquidity();
		this.fee = o.getFee();
		this.features = o.getFeatures();
	}
	/**
	 * Gets the offer name
	 * @return String the name of the offer
	 */
	public String getName() {
		return name;
	}
	/**
	 * Sets the name of the offer
	 * @param name The offer name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * Gets the apy
	 * @return Double the apy to get
	 */
	public Double getApy() {
		return apy;
	}
	/**
	 * Sets the apy
	 * @param apy The apy to set
	 */
	public void setApy(Double apy) {
		this.apy = apy;
	}
	/**
	 * Gets the number of withdrawals an offer allows per month
	 * @return Integer the number of withdrawals
	 */
	public Integer getWithdrawals() {
		return withdrawals;
	}
	/**
	 * Sets the number of withdrawals
	 * @param withdrawals The number of withdrawals to set
	 */
	public void setWithdrawals(Integer withdrawals) {
		this.withdrawals = withdrawals;
	}
	/**
	 * Gets whether an offer provides overdraft or not
	 * Value is an integer for use with Watson Tradeoff
	 * @return Integer 0 if it doesn't 1 if it does
	 */
	public Integer getOverdraft() {
		return overdraft;
	}
	/**
	 * Sets whether or not an offer has overdraft
	 * @param overdraft 1 if it does, 0 if it doesn't
	 */
	public void setOverdraft(Integer overdraft) {
		this.overdraft = overdraft;
	}
	/**
	 * gets the liquidity of an offer
	 * @return Integer the liquidity of the offer
	 */
	public Integer getLiquidity() {
		return liquidity;
	}
	/**
	 * Sets the offers liquidity
	 * @param liquidity
	 */
	public void setLiquidity(Integer liquidity) {
		this.liquidity = liquidity;
	}
	/**
	 * Gets the fee of the offer
	 * @return String The offer's fee
	 */
	public String getFee() {
		return fee;
	}
	/**
	 * Sets the offer's fee
	 * @param fee The fee of the offer
	 */
	public void setFee(String fee) {
		this.fee = fee;
	}
	/**
	 * Gets features associated with an account
	 * @return Array<Feature> The array of features for an offer
	 */
	public Feature[] getFeatures() {
		return features.clone();
	}
	/**
	 * Sets the features an offer has
	 * @param features The array of features for an offer
	 */
	@SuppressWarnings("PMD.UseVarargs")
	public void setFeatures(Feature[] features) {
		this.features = features.clone();
	}

	/**
	 * Data model for the account Feature
	 */
	@SuppressWarnings("unused")
	private class Feature {
		private String name;
		/**
		 * default constructor
		 */
		public Feature() {
			super();
		}
		/**
		 * sets the Feature attribute for a Feature instance
		 * @param f
		 */
		public Feature(Feature f) {
			this.name = f.getName();
		}
		/**
		 * Gets the name of a feature
		 * @return String the feature's name
		 */
		public String getName() {
			return name;
		}
		/**
		 * Sets the features name
		 * @param name The name of the feature to set
		 */
		public void setName(String name) {
			this.name = name;
		}
	}
}
