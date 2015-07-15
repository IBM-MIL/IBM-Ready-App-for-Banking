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
 * Factory service for keeping track of the user's goals on the client side
 */
angular.module('hatch').factory('Focus', function() {
    var focus = {};
    focus.isTyping = false;
    /**
     * sets the current focus state
     * @param {boolean} state The focus state to set
     */
    focus.setFocus = function (state) {
        focus.isTyping = state;
    };
    return focus;
});
