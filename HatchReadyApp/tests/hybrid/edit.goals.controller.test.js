'use strict';

describe('view-goals-controller', function(){

  beforeEach(module('hatch', function ($translateProvider) {
    $translateProvider
      .translations('en', englishTranslations)
      .preferredLanguage('en');
  }));

  beforeEach(module('dir-templates'));

  var $rootScope, $compile, $controller, goals;

  beforeEach(inject(function(_$rootScope_, _$compile_, _$controller_, $injector) {
    $rootScope = _$rootScope_;
    $compile = _$compile_;
    $controller = _$controller_;
    goals = $injector.get('Goals');
  }));

  //commented for sanity
  /*describe('$rootScope.changeActivePeriod', function() {
    it('should not change period if Month is active and is also input', function() {
      var $scope = {};
      console.log("GOALS");
      goals.setGoalToEdit({
        "start" : new Date(1401100352717),
        "_rev" : "5-650c5af71a5884f3a56e2d9c4b68d6e2",
        "feasability" : "feasible",
        "priority" : 1,
        "goalAmount" : 2600,
        "title" : "Goal 2",
        "progress" : 50,
        "notes" : "",
        "_id" : "3002",
        "depositFrequency" : "month",
        "type" : "goal",
        "end" : new Date(1453695152717),
        "saved" : 1300,
        "depositAmount" : 1300,
        "ownerID" : "1001"
       });
      var controller = $controller('EditGoalsController', { $scope: $scope, Goals: goals});
      console.log(controller.Goals.goalToEdit);
      controller.changeActivePeriod('month');
      expect(controller.showMonthly).toBeTruthy();
      expect(controller.showWeekly).not.toBeTruthy();
    });

    it('should change period if Month is active and Week is the input', function() {
      var $scope = {};
      var controller = $controller('EditGoalsController', { $scope: $scope });
      controller.changeActivePeriod('week');
      expect(controller.showMonthly).not.toBeTruthy();
      expect(controller.showWeekly).toBeTruthy();
    });
  });*/
});
