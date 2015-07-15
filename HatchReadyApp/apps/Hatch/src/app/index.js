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
angular.module('hatch', ['ngAnimate', 'ngTouch', 'ngSanitize', 'ngRoute', 'pascalprecht.translate', 'ui.sortable', 'countTo'])
  .config(function ($routeProvider, $translateProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'app/goals/view-goals/view-goals.html',
        controller: 'ViewGoalsController',
        controllerAs: 'viewGoals'
      })
      .when('/add', {
        templateUrl: 'app/goals/add-goals/add-goals.html',
        controller: 'AddGoalsController',
        controllerAs: 'addGoals'
      })
      .when('/edit', {
        templateUrl: 'app/goals/edit-goals/edit-goals.html',
        controller: 'EditGoalsController',
        controllerAs: 'editGoals'
      })
      .when('/details', {
        templateUrl: 'app/goals/view-goal-details/view-goal-details.html',
        controller: 'GoalDetailsController',
        controllerAs: 'detailGoals'
      })
      .when('/offers', {
        templateUrl: 'app/offers/offers.html',
        controller: 'OffersController',
        controllerAs: 'offers'
      })
      .when('/feasibility', {
        templateUrl: 'app/goals/goal-feasibility/goal-feasibility.html',
        controller: 'GoalFeasibilityController',
        controllerAs: 'feasibility'
      })
      .when('/options', {
        templateUrl: 'app/goals/goal-feasibility/feasibility-options.html',
        controller: 'GoalFeasibilityController',
        controllerAs: 'feasibility'
      })
      .otherwise({
        redirectTo: '/'
      });
      $translateProvider
      .translations('en', englishTranslations)
      .translations('es', spanishTranslations)
      .preferredLanguage('en');
  })
;

angular.module('hatch').filter('parseInt', function() {
    return function(input) {
      return parseInt(input, 10);
    };
});

