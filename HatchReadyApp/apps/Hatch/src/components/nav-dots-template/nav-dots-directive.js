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
 * @description Angular Directive for the navigation dots on the add goal pages
 */
angular.module('hatch').directive('navDotsDirective', function() {
  return {
    restrict: 'E',
    templateUrl: 'components/nav-dots-template/nav-dots-directive.html',
    scope: {
      totalItems: '=items',
      current: '=currentItem'
    }
  };
});
