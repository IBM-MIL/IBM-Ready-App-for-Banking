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
 * @description Controller for goal feasibility
 * @param  {Service} $location The angular $location service
 * @param  {Service} Utility The Utility service
 * @param  {Factory} Goals Factory containing the goal list
 * @param  {Service} Formatter The Formatter service
 * @param  {Service} Navigation The Navigation service
 * @property vm The representation of the controller object
 */
angular.module('hatch').controller('GoalFeasibilityController', ['$location', 'Utility', 'Goals', 'Formatter', 'Navigation',
  function($location, Utility, Goals, Formatter, Navigation) {
  var vm = this;
  vm.goals = Goals;
  vm.utility = Utility;
  vm.navigation = Navigation;
  vm.formatter = Formatter;

  vm.goal = {
      'start': Goals.tempGoal.start,
      '_rev': Goals.tempGoal._rev,
      'feasibility': Goals.tempGoal.feasibility,
      'priority': Goals.tempGoal.priority,
      'goalAmount': Goals.tempGoal.goalAmount,
      'title': Goals.tempGoal.title,
      'progress': Goals.tempGoal.progress,
      'notes': Goals.tempGoal.notes,
      '_id': Goals.tempGoal._id,
      'depositFrequency': Goals.tempGoal.depositFrequency,
      'type': Goals.tempGoal.type,
      'end': Goals.tempGoal.end,
      'saved': Goals.tempGoal.saved,
      'depositAmount': Goals.tempGoal.depositAmount,
      'ownerID': Goals.tempGoal.ownerID
    };

  vm.options = vm.goals.optionalGoals;

  vm.optionIsFeasible = vm.goals.optionIsFeasible;

  vm.submittedGoal = vm.goals.submittedGoal;

  /**
   * @function getIndex
   * @description Returns the index of an item with an itemGroup
   * @param  {Object} item     The item to find the index of
   * @param  {Array} itemGroup The group the item is located in
   * @return {Int} The index of the item
   */
  this.getIndex = function(item, itemGroup) {
    return itemGroup.indexOf(item) + 1;
  };

  /**
   * @function swapGoal
   * @description This function swaps the goal data from a "More Options" choice with the original goal data
   * @param  {goal} newGoal The goal to swap in
   * @param  {string} path The new page to navigate to
   */
  vm.swapGoal = function(option, path) {
    Goals.tempGoal = option.goal;
    if(angular.isDefined(option.changedGoals)){
      vm.goals.changedGoalsList = option.changedGoals;
    } else {
      vm.goals.changedGoalsList = [];
    }

    vm.goals.optionIsFeasible = option.isFeasible;

    vm.goals.submittedGoal = option.goal;

    $location.path(path);
    HybridJS.callback('feasibility', option.isFeasible);

  };

  /**
   * @function saveFeasibility
   * @description Saves the goal's feasibility to the goal list
   */
  vm.saveFeasibility = function() {
    for(var i = 0; i < vm.goals.allGoals.length; i++){
      if(vm.goals.allGoals[i]._id === vm.goal._id) {
        vm.goals.allGoals[i].depositFrequency = vm.goal.depositFrequency;
        vm.goals.allGoals[i].goalAmount = vm.goal.goalAmount;
        vm.goals.allGoals[i].feasibility = vm.goal.feasibility;
        vm.goals.allGoals[i].progress = vm.goal.progress;
        vm.goals.allGoals[i].end = vm.goal.end;
        vm.goals.allGoals[i].depositAmount = vm.goal.depositAmount;
        return;
      }
    }
    vm.goals.addGoal(vm.goal);
  };

  /**
   * @function confirmFeasibility
   * @description The confirmation on the feasibility page
   */
  vm.confirmFeasibility = function() {
    vm.saveFeasibility();
    vm.goals.changedGoalsList.forEach(function(goal) {
       vm.goals.setGoal(goal);
      });
    vm.navigation.exitPage();
  };

}]);
