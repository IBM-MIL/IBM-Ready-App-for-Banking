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

/**
 * @description Provides utility functions for formatting and converting data for display and use
 * @param  {$locale} $locale     The angular $locale service
 */
'use strict';
angular.module('hatch').factory('Formatter', ['$locale', function($locale) {
    /**
     * @function getDecimalSeperator
     * @description Uses the locale service to get the decimal seperator
     * @return {string} The decimal seperator
     */
    var getDecimalSeperator = function() {
        return $locale.NUMBER_FORMATS.DECIMAL_SEP;
    };

    /**
     * @function convertDates
     * @description Converts date objects into miliseconds for WL
     * @param {goal} goal The goal to convert
     */
    var convertDates = function(goal) {
        goal.start = goal.start.getTime();
        goal.end = goal.end.getTime();
    };

    /**
     * @function milToDate
     * @description Converts milliseconds to the corresponding Date object
     * @param  {goal} goal The goal whose dates to convert
     */
    var milToDate = function(goal) {
        goal.start = new Date(goal.start);
        goal.end = new Date(goal.end);
    };

    /**
     * @function convertFeasibilityToInt
     * @description Converts string version of goal feasibility to int
     * @param {goal} goal The goal whose feasibility to convert
     */
    var convertFeasibilityToInt = function(goal) {
        if (goal.feasibility === 'feasible') {
            goal.feasibility = 0;
        } else if (goal.feasibility === 'warning') {
            goal.feasibility = 1;
        } else {
            goal.feasibility = 2;
        }
    };

    /**
     * @function convertFeasibilityToStrong
     * @description Converts goal to String
     * @param {goal} goal The goal to convert
     */
    var convertFeasibilityToString = function(goal) {
        if (goal.feasibility === 0) {
            goal.feasibility = 'feasible';
        } else if (goal.feasibility === 1) {
            goal.feasibility = 'warning';
        } else {
            goal.feasibility = 'unfeasible';
        }
    };
    return {
        getDecimalSeperator: getDecimalSeperator,
        convertDates: convertDates,
        milToDate: milToDate,
        convertFeasibilityToInt: convertFeasibilityToInt,
        convertFeasibilityToString: convertFeasibilityToString
    };
}]);
