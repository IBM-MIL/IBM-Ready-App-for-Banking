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
 * @description The controller for adding goals
 * @param  {Factory} Goals      Factory containing the goal list
 * @param  {Service} Utility The Utility service
 * @property vm The representation of the controller object
 */
angular.module('hatch').controller('AddGoalsController', ['Goals', 'Utility', function(Goals, Utility) {
  var vm = this;
  vm.goal = Goals;
  vm.util = Utility;

  vm.emptyGoal = ['title', 'goalAmount', 'start', 'end', 'depositFrequency'];
  vm.formItems = {
    title: '',
    goalAmount: 0,
    start: new Date(),
    end: new Date(),
    depositFrequency: 'week'
  };

  vm.pageLayout = [
    {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q1', placeholder: 'TITLE_PLACEHOLDER', showPage: true, swipeLeft: false},
    {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q2', placeholder: 'MONEY_PLACEHOLDER', showPage: false, swipeLeft: false},
    {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q3', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false},
    {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q4', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false},
    {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q5', placeholder: '', showPage: false, swipeLeft: false}
  ];

  /**
   * @description This function controls the showing/hiding and animations that happen when swiping left or pressing the button to go to the next page
   * @param  {string} page     The current page
   * @param  {string} formName The name of the form; only perform actions if the form is currently valid, or there is no form associated
   */
  vm.nextPage = function(page, formName) {
    if(angular.isUndefined(formName) || formName.$valid) {
      if(vm.getIndex(page) < vm.pageLayout.length - 1) {
        vm.pageLayout[vm.getIndex(page)].showPage = false;
        vm.pageLayout[vm.getIndex(page) + 1].showPage = true;
        vm.pageLayout[vm.getIndex(page)].swipeLeft = true;
      }
    }
  };

  /**
   * @description This function controls the showing/hiding and animations that happen when swiping right to go back to the previous page
   * @param  {string} page The current page
   */
  vm.lastPage = function(page) {
    if(vm.getIndex(page) > 0) {
      vm.pageLayout[vm.getIndex(page)].showPage = false;
      vm.pageLayout[vm.getIndex(page) - 1].showPage = true;
      vm.pageLayout[vm.getIndex(page)].swipeLeft = false;
    }
  };

  /**
   * @description This function controls the actions that occur when the submit button is pressed, including submitting the new goal in order to receive feasibility calculations
   * @param  {string} page The current page
   * @param  {string} formName The name of the form; only perform actions if the form is currently valid, or there is no form associated
   */
  vm.submitButton = function(page, formName) {
    if(vm.getIndex(page) === vm.pageLayout.length - 1) {
      vm.goal.submittedGoal = vm.formItems;
      vm.util.setFeasPage('feasibility');
      HybridJS.getFeasibility(vm.formItems);
    }
    else {
      vm.nextPage(page, formName);
    }
  };

  /**
   * @description This function returns the index of the current page
   * @param  {string} page The current page
   * @return {int} The current page's index (with respect to the page container)
   */
  vm.getIndex = function(page) {
    return vm.pageLayout.indexOf(page);
  };
}]);
