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
 * @description The Nagivation service
 * @param  {Factory} Goals      Factory containing the goal list
 * @param  {Service} $location The angular $location service
 * @param  {Service} $timeout The angular $timeout service
 */
angular.module('hatch').factory('Navigation', ['$location', 'Goals', '$timeout',
    function($location, Goals, $timeout) {

    var delayTime = 50;

    /**
    * @function toEdit
    * @description Goes to edit goals path
    * @param  {goal} goal The goal to edit
    */
     var toEdit = function(goal) {
        $timeout(function(){
        Goals.setGoalToEdit(goal);
        $location.path('edit');
     }, delayTime);
        HybridJS.updatePage('EDIT ' + (goal.title).toUpperCase(), 'edit', true, '#8cd211');
     };

     /**
     * @function toView
     * @description Goes to view goals path
     * @param  {goal} goal The goal to view
     */
    var toView = function(goal) {
        $timeout(function(){
        $location.path('details');
        }, delayTime);
        Goals.setGoalToView(goal);
        HybridJS.updatePage( (goal.title).toUpperCase(), 'details', true, '#ffffff');
    };

    /**
     * @function toAddGoal
     * @description Goes to the Add Goal flow
     */
    var toAddGoal = function() {
        $timeout(function(){
        $location.path('add');
        }, delayTime);
        HybridJS.updatePage('New Goal', 'add', true, '#8cd211');
    };

    /**
     * @function toOptions
     * @description Goes to the feasibility options page
     */
    var toOptions = function() {
        $timeout(function(){
        $location.path('options');
        }, delayTime);
        HybridJS.updatePage('Options', 'options', true, '#8cd211');
    };

    /**
    * @function exitPage
    * @description Exits the current page and goes back to the view goals screen
    */
    var exitPage = function() {
        $timeout(function(){
        $location.path('');
        }, delayTime);
        HybridJS.updatePage('GOALS', '#', false, '#ffffff');
    };

    return {
        toEdit: toEdit,
        toView: toView,
        toAddGoal: toAddGoal,
        toOptions: toOptions,
        exitPage: exitPage
    };
}]);
