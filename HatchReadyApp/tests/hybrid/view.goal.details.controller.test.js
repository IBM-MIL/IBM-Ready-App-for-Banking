'use strict';

describe('goal-details-controller', function(){

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

  describe('calcTimePercentComplete', function() {
    it('should calculate how much time has elapsed', function() {
      var $scope = {};
      var controller = $controller('GoalDetailsController', { $scope: $scope });
      var day1 = new Date();
      var day2 = new Date();
      expect(controller.calc.calcTimePercentComplete(day1, day2)).toBe(100);
    });
  });
});
