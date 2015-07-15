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
 * @description Provides utility functions for common calculations
 */
'use strict';
angular.module('hatch').factory('Calc', function() {
    /**
     * @function daydiff
     * @description Determines the number of days between two dates
     * @param  {date} start the start date
     * @param  {date} end   the end date
     * @return {int}       days between start and end
     */
    var daydiff = function(start, end) {
        return (end - start) / (1000 * 60 * 60 * 24);
    };

    /**
     * @function calcTimePercentComplete
     * @description Calculates the percent of time complete
     * @param  {date} start the start date
     * @param  {date} end   the end date
     * @return {int}       Number of days
     */
    var calcTimePercentComplete = function(start, end) {
        var today = new Date();
        var percent = Math.floor(daydiff(start, today) / daydiff(start, end) * 100);
        if (percent <= 100) {
            return percent;
        } else {
            return 100;
        }
    };
    return {
        daydiff: daydiff,
        calcTimePercentComplete: calcTimePercentComplete
    };
});
