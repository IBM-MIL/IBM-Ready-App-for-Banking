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
 * Controller that displays the various offers a bank has
 * @param  {Offers} Offers) The Offers service
 */
angular.module('hatch').controller('OffersController', ['Offers', 'Navigation', function(Offers, Navigation) {
	var vm = this;
	vm.offers = Offers;
	vm.navigation = Navigation;
	vm.showFlyover = false;
	/**
	 * @function
	 * Toggles whether or not the flyover should be shown
	 */
    vm.toggleFlyover = function(){
        vm.showFlyover = !vm.showFlyover;
    };

    vm.exitFlow = function(){
    	vm.navigation.exitHybrid();
    };
 }]);
