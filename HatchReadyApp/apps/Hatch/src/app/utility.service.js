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
 * @description The Utility service
 */
angular.module('hatch').factory('Utility',
    function() {
    var feasibilityPage = 'feasibility';

    /**
     * @function toOptions
     * @description checks feasibility in the case of entering the Options screen
     * @param {goal} goal The goal to find the new feasibility of
     */
    var toOptions = function(goal) {
        HybridJS.getFeasibility(goal);
    };

    /**
     * @function setFeasPage
     * @description sets the page to go to after returning feasibility
     * @param {string} route The route of the page to go to
     */
    var setFeasPage = function(route) {
        this.feasibilityPage = route;
    };

	return {
        toOptions: toOptions,
        feasibilityPage: feasibilityPage,
        setFeasPage: setFeasPage
	};


});

