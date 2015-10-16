/**************************************
 *
 *  Licensed Materials - Property of IBM
 *  © Copyright IBM Corporation 2015. All Rights Reserved.
 *  This sample program is provided AS IS and may be used, executed, copied and modified without royalty payment by customer
 *  (a) for its own instruction and study, (b) in order to develop applications designed to run with an IBM product,
 *  either for customer's own internal use or for redistribution by customer, as part of such an application, in customer's
 *  own products.
 *
 ***************************************/
'use strict';

/**
 * @description Controller for editing goals
 * @param  {Factory} Goals Factory containing the goal list
 * @param  {Factory} Focus Factory containing custom focus value
 * @param  {Service} Utility The Utility service
 * @param  {Service} Calc The Calc service
 * @property vm The representation of the controller object
 */
angular.module('hatch').controller('EditGoalsController', [ 'Goals', 'Focus', 'Utility', 'Calc',
 function(Goals, Focus, Utility, Calc) {
        var vm = this;
        vm.goals = Goals;
        vm.utility = Utility;
        vm.calc = Calc;
        vm.focus = Focus;

        if(Goals.goalToEdit.depositFrequency === 'month') {
			vm.showMonthly = true;
			vm.showWeekly = false;
        }
        else {
			vm.showWeekly = true;
			vm.showMonthly = false;
        }

        /**
         * @description goalCopy datastructure to hold user's changes
         * @type {Object}
         */
        vm.goalCopy = {
        'start': Goals.goalToEdit.start,
        '_rev': Goals.goalToEdit._rev,
        'feasibility': Goals.goalToEdit.feasibility,
        'priority': Goals.goalToEdit.priority,
        'goalAmount': Goals.goalToEdit.goalAmount,
        'title': Goals.goalToEdit.title,
        'progress': Goals.goalToEdit.progress,
        'notes': Goals.goalToEdit.notes,
        '_id': Goals.goalToEdit._id,
        'depositFrequency': Goals.goalToEdit.depositFrequency,
        'type': Goals.goalToEdit.type,
        'end': Goals.goalToEdit.end,
        'saved': Goals.goalToEdit.saved,
        'depositAmount': Goals.goalToEdit.depositAmount,
        'ownerID': Goals.goalToEdit.ownerID,
        'weeksLeft': Goals.goalToEdit.weeksLeft,
        'monthsLeft': Goals.goalToEdit.monthsLeft
        };

        /**
         * @function changeActivePeriod
         * @description This function handles changing if the user wants monthly or weekly payments
         */
        vm.changeActivePeriod = function(period) {
			if(vm.showMonthly === true && vm.showWeekly === false){
				if(period !== 'month'){
					vm.showMonthly = false;
					vm.showWeekly = true;
					vm.goalCopy.depositFrequency = 'week';
				}
			}
			else if(vm.showMonthly === false && vm.showWeekly === true){
				if(period !== 'week'){
					vm.showMonthly = true;
					vm.showWeekly = false;
					vm.goalCopy.depositFrequency = 'month';
				}
			}
		};

		/**
		 * @function getWeeklyTotal
		 * @description Determines weekly payment
		 * @param  {int} totalAmount the goal total
		 * @param  {date} endDate     the end date
		 * @return {int}             the estimated amount to pay per week to reach the goal
		 */
		vm.getWeeklyTotal = function(totalAmount, endDate) {
			var today = new Date();
			var daysLeft = vm.calc.daydiff(today, endDate);
			var total = Math.ceil(totalAmount / Math.ceil(daysLeft / 7.0) * 100) / 100;
			vm.goalCopy.depositAmount = total;
			return total;
		};

		/**
		 * @function getMonthlyTotal
		 * @description Determines monthly payment
		 * @param  {int} totalAmount the goal total
		 * @param  {date} endDate     the end date
		 * @return {int}             the estimated amount to pay per month to reach the goal
		 */
		vm.getMonthlyTotal = function(totalAmount, endDate) {
			var today = new Date();
			var daysLeft = vm.calc.daydiff(today, endDate);
			var total = Math.ceil(totalAmount / Math.ceil(daysLeft / (365.0/12.0)) * 100) / 100;
			vm.goalCopy.depositAmount = total;
			return total;
		};

		/**
		 * @function getTotal
		 * @description Determines the monthly or weekly payment, depending which duration is passed in.
		 * @param  {int} totalAmount the total goal amount
		 * @param  {int} savedAmount the total amount saved so far
		 * @param  {int} duration    the number of weeks or months until the end of the goal
		 * @return {int}             the estimated amount to pay per week or month
		 */
		vm.getTotal = function(totalAmount, savedAmount, duration) {
			var total = Math.ceil((totalAmount - savedAmount) / duration * 100) / 100;
			return total;
		}

		//Position: fixed doesn't work in iOS as expected, as when using an input field or the keyboard the viewport will not
		//update until the focus blurred. Focusing and Blurring is a workaround to that
		/**
		 * @function focusing
		 * @description Function to set our own focus variable
		 */
		vm.focusing = function() {
			vm.focus.isTyping = true;
			vm.focus.setFocus(true);
		};
		/**
		 * @function blurring
		 * @description Function to set our own blur variable
		 */
		vm.blurring = function() {
			vm.focus.isTyping = false;
			vm.focus.setFocus(false);
		};

		/**
		 * @function cancelEdit
		 * @description Cancels the edit
		 */
		vm.cancelEdit = function() {
			HybridJS.pressBackButton();
		};

		/**
		 * @function submitChanges
		 * @description Submits the changes to the goal
		 * @param  {goal} editedGoal the goal to submit
		 */
		vm.submitChanges = function(editedGoal) {
				editedGoal.progress = Math.round((editedGoal.saved / editedGoal.goalAmount) * 100);
				vm.utility.setFeasPage('feasibility');
				HybridJS.getFeasibility(editedGoal);
		};

}]);

