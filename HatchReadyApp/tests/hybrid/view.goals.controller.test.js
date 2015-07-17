'use strict';

describe('view-goals-controller', function(){

  beforeEach(module('hatch', function ($translateProvider) {
    $translateProvider
      .translations('en', englishTranslations)
      .preferredLanguage('en');
  }));

  beforeEach(module('dir-templates'));

  var $rootScope, $compile, $controller;

  beforeEach(inject(function(_$rootScope_, _$compile_, _$controller_) {
    $rootScope = _$rootScope_;
    $compile = _$compile_;
    $controller = _$controller_;
  }));


  describe('add a goal', function() {
    it('should add goal', function() {
      var $scope = {};
      var controller = $controller('ViewGoalsController', { $scope: $scope });
      var oldNum = controller.goals.allGoals.length;
      controller.addGoal();
      expect(controller.goals.allGoals.length).toBe(oldNum + 1);
    });
  });

  describe('delete a goal', function() {
    it('should delete a goal', function() {
      var $scope = {};
      var controller = $controller('ViewGoalsController', { $scope: $scope });
      controller.addGoal();
      controller.addGoal();
      controller.addGoal();
      var oldNum = controller.goals.allGoals.length;
      controller.goals.deleteGoal(controller.goals.allGoals[0]);
      expect(controller.goals.allGoals.length).toBe(oldNum - 1);
    });
  });
});
