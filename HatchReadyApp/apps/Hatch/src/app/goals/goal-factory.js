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
 * @description Factory service for keeping track of the user's goals on the client side
 */
angular.module('hatch').factory('Goals', ['Formatter', function() {
    var formatter = this.Formatter;
    /**
     * Example Goal
     *
     * {
        "start" : 1401100352717,
        "_rev" : "5-650c5af71a5884f3a56e2d9c4b68d6e2",
        "feasability" : 0,
        "priority" : 1,
        "goalAmount" : 2600,
        "title" : "Goal 2",
        "progress" : 50,
        "notes" : "",
        "_id" : "3002",
        "depositFrequency" : "month",
        "type" : "goal",
        "end" : 1453695152717,
        "saved" : 1300,
        "depositAmount" : 1300,
        "ownerID" : "1001"
       }
     */
    var allGoals = [];
    var goalToEdit;
    var editGoalIndex;
    var goalToView;
    var tempGoal;
    var optionalGoals = [];
    var changedGoalsList = [];
    var optionIsFeasible;
    var submittedGoal;

    /**
     * @description sortByPriority
     * @description Sorts objects based on their priority attribute
     * @param  {goal} a the first goal to compare
     * @param  {goal} b the second goal to compare
     * @return {int}   Returns -1 if a's priority is higher (0 is the highest),
     * 1 if the priority is lower and 0 if its the same
     */
    function sortByPriority(a, b) {
        if (a.priority < b.priority) {
            return -1;
        } else if (a.priority > b.priority) {
            return 1;
        }
        return 0;
    }

    /**
     * @function setGoals
     * @description Convenience function to set the user's goals.
     * @param {Array(goal)} goals The goals to set for the user
     */
    var setGoals = function(goals) {
       this.allGoals = goals;
       this.sortGoals();
    };

    /**
     * @function addGoal
     * @description Adds a goal to the current user's goal then resorts based on priorities
     * @param {goal} goal The goal to add
     */
    var addGoal = function(goal) {
        this.allGoals.push(goal);
        this.sortGoals();
    };

    /**
     * @function deleteGoal
     * @description Removes a goal using a unique identifier to locate it, updates priorities and resorts when its found
     * @param  {goal} goalToDelete The goal to remove from the list
     */
    var deleteGoal = function(goalToDelete) {
        for(var i = 0; i < this.allGoals.length; i++) {
            var goal = this.allGoals[i];
            if (goalToDelete._id === goal._id) {
                this.allGoals.splice(i, 1);
                for(var j = i; j < this.allGoals.length; j++) {
                    this.allGoals[j].priority -= 1;
                }
                break;
            }

        }
        this.sortGoals();
    };

    /**
     * @function sortGoals
     * @description Sorts the Goals by priority
     */
    var sortGoals = function() {
        this.allGoals.sort(sortByPriority);
    };

    /**
     * @function setGoalToEdit
     * @description sets the Goal to Edit
     * @param {goal} goal The goal to edit
     */
    var setGoalToEdit = function(goal) {
        this.goalToEdit = goal;
        this.editGoalIndex = this.allGoals.indexOf(goal);
        this.submittedGoal = goal;
    };

    /**
     * @function setGoalToView
     * @description sets the Goal to View
     * @param {goal} goal The goal to view
     */
    var setGoalToView = function(goal) {
        this.goalToView = goal;
        this.submittedGoal = goal;
    };

    /**
     * @function setGoal
     * @description Sets one goal to another
     * @param {goal} changedGoal The updated goal
     */
    var setGoal = function(changedGoal) {
        allGoals.forEach(function(goal) {
        if(goal._id === changedGoal._id) {
          goal.depositAmount = changedGoal.depositAmount;
          goal.depositFrequency = changedGoal.depositFrequency;
          formatter.milToDate(changedGoal);
          goal.end = changedGoal.end;
          formatter.convertFeasibilityToString(changedGoal);
          goal.feasibility = changedGoal.feasibility;
          goal.goalAmount = changedGoal.goalAmount;
        }
       });
    };


    return {
        allGoals: allGoals,
        goalToEdit: goalToEdit,
        editGoalIndex: editGoalIndex,
        goalToView: goalToView,
        tempGoal: tempGoal,
        changedGoalsList: changedGoalsList,
        setGoals: setGoals,
        setGoal: setGoal,
        addGoal: addGoal,
        deleteGoal: deleteGoal,
        sortGoals: sortGoals,
        setGoalToEdit: setGoalToEdit,
        setGoalToView: setGoalToView,
        optionalGoals: optionalGoals,
        optionIsFeasible: optionIsFeasible,
        submittedGoal: submittedGoal
    };
}]);
