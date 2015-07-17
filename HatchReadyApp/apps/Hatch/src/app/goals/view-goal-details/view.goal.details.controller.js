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
 * @description The controller for viewing goals
 * @param  {Factory} Goals      Factory containing the goal list
 * @param  {Service} $location The angular $location service
 * @param  {Service} Utility The angular $location service
 * @param  {Service} Formatter The Formatter service
 * @param  {Service} Calc The Calc service
 * @param  {Service} Nagivation The Navigation service
 * @property vm The representation of the controller object
 */
angular.module('hatch').controller('GoalDetailsController', [ 'Goals', 'Utility', 'Formatter', 'Calc', 'Navigation',
    function(Goals, Utility, Formatter, Calc, Navigation) {
	var vm = this;
    vm.goals = Goals;
    vm.utility = Utility;
    vm.formatter = Formatter;
    vm.calc = Calc;
    vm.navigation = Navigation;

    /**
     * @function toOptions
     * @description The procedure for getting to the Options page from an unfeasible goal
     */
    vm.toOptions = function() {
		vm.utility.setFeasPage('options');
		var index = Goals.allGoals.indexOf(Goals.goalToView);
		vm.goals.deleteGoal(Goals.goalToView);
		HybridJS.getFeasibility(Goals.goalToView);
		vm.goals.allGoals.splice(index, 0, Goals.goalToView);
    };
}]);

