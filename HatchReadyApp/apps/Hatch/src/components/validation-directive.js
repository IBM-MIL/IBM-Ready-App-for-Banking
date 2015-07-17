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
 * @description Form validation directive to make sure the input value is not 0
 * @return {bool}   True if the value is not zero, False otherwise
 */
angular.module('hatch').directive('zero', function() {
  return {
    restrict: 'A',
    require: '?ngModel',
    link: function(scope, element, attributes, ngModel) {
		ngModel.$validators.zero = function(modelValue) {
			return parseFloat(modelValue) !== 0;
		};
    }
  };
});

/**
 * @description Form validation directive to make sure the input value is not a lone currency seperator
 * @return {bool}   True if the value is not a lone currency seperator, False otherwise
 */
angular.module('hatch').directive('period', ['$locale', function($locale) {
  return {
    restrict: 'A',
    require: '?ngModel',
    link: function(scope, element, attributes, ngModel) {
		ngModel.$validators.period = function(modelValue) {
      var curDecimalSep = $locale.NUMBER_FORMATS.DECIMAL_SEP;
			return modelValue !== curDecimalSep;
		};
    }
  };
}]);

/**
 * @description Form validation directive to make sure the end day value is not today
 * @return {bool}   False if the value is today or before, True otherwise
 */
angular.module('hatch').directive('past', function() {
  return {
    restrict: 'A',
    require: '?ngModel',
    link: function(scope, element, attributes, ngModel) {
    ngModel.$validators.period = function(modelValue) {
      var today = new Date();
      if(modelValue <= today) {
        return false;
      }
      else {
        return true;
      }
    };
    }
  };
});
