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
 * Controller for viewing goals
 * @param  {Factory} Goals Factory containing the goals to view
 * @param  {Service} Navigation The Navigation service
 * @property vm The representaion of the controller object
 */
angular.module('hatch').controller('ViewGoalsController', ['Goals', 'Navigation', function(Goals, Navigation) {

    var vm = this;
    vm.hideInfo = false;
    vm.goals = Goals;
    vm.navigation = Navigation;
    vm.dragging = false;
    vm.oldPriorities = {};
    vm.goals.allGoals.forEach(function(goal) {
        goal.showGoal = true;
        goal.showEdit = false;
        goal.showDelete = false;
    });

    /**
     * List of events related to the sorting directive
     */
    vm.dragControlListeners = {
        accept: function(sourceItemHandleScope, destSortableScope) {
            vm.dragging = true;
            return true;
        }, //override to determine drag is allowed or not. default is true.
        itemMoved: function(event) {},
        orderChanged: function(event) {
            if(angular.isUndefined(vm.oldPriorities[vm.goals.allGoals[event.source.index].title])) {
                vm.oldPriorities[vm.goals.allGoals[event.source.index].title] = vm.goals.allGoals[event.source.index].priority;
            }
            if(angular.isUndefined(vm.oldPriorities[vm.goals.allGoals[event.dest.index].title])) {
                vm.oldPriorities[vm.goals.allGoals[event.dest.index].title] = vm.goals.allGoals[event.dest.index].priority;
            }
            vm.goals.allGoals[event.dest.index].priority = event.dest.index + 1;
            vm.goals.allGoals[event.source.index].priority = event.source.index + 1;
        },
        containment: '#goal-container' //optional param.
    };
    /**
     * Tells the sort directive how to position the elements when they're dragged
     */
    vm.sortableOptions = {
        'containerPositioning': 'relative'
    };
    /**
     * @function addGoal
     * @description adds a new goal
     */
    vm.addGoal = function() {
        vm.goals.addGoal({
            title: 'Goal' + (vm.goals.allGoals.length + 1),
            goalAmount: Math.floor(Math.random() * (10000 - 1000 + 1) + 1000),
            progress: Math.floor(Math.random() * (100 - 1 + 1) + 1) + '%',
            showGoal: true,
            showEdit: false,
            showDelete: false,
            priority: vm.goals.allGoals.length
        });
    };
    /**
     * @function submitPriorites
     * @description Locks goals in place
     */
    vm.submitPriorities = function() {
        vm.oldPriorities = {};
        WL.App.sendActionToNative('updatedPriorities', {
            newGoals: vm.goals.allGoals
        });
        vm.dragging = false;
    };
    /**
     * @function cancelPriorities
     * @description Undoes reordering the goals
     */
    vm.cancelPriorities = function() {
        vm.goals.allGoals.forEach(function(goal) {
            if(angular.isDefined(vm.oldPriorities[goal.title])) {
                goal.priority = vm.oldPriorities[goal.title];
            }
        });
        vm.goals.sortGoals();
        vm.oldPriorities = {};
        vm.dragging = false;
    };
}]);
