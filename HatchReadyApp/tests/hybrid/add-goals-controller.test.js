'use strict';

describe('add-goals-controller', function() {

  beforeEach(module('hatch', function ($translateProvider) {
    $translateProvider
      .translations('en', englishTranslations)
      .preferredLanguage('en');
  }));

  beforeEach(module('dir-templates'));

  var $controller;

  beforeEach(inject(function(_$controller_) {
    $controller = _$controller_;
  }));

  describe('nextPage function', function() {
    it('should update the current page\'s pageShow boolean to false', function() {
      var $scope = {};
      var controller = $controller('AddGoalsController', { $scope: $scope });
      controller.pageLayout = [
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q1', placeholder: 'ADD_GOAL_P1', showPage: true, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q2', placeholder: 'MONEY_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q3', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q4', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false}
      ];
      expect(controller.pageLayout[0].showPage).toBeTruthy();
      controller.nextPage(controller.pageLayout[0]);
      expect(controller.pageLayout[0].showPage).toBeFalsy();
    });

    it('should update the next page\'s pageShow boolean to true', function() {
      var $scope = {};
      var controller = $controller('AddGoalsController', { $scope: $scope });
      controller.pageLayout = [
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q1', placeholder: 'ADD_GOAL_P1', showPage: true, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q2', placeholder: 'MONEY_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q3', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q4', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false}
      ];
      expect(controller.pageLayout[1].showPage).toBeFalsy();
      controller.nextPage(controller.pageLayout[0]);
      expect(controller.pageLayout[1].showPage).toBeTruthy();
    });

    it('should update the current page\'s swipeLeft boolean to true', function() {
      var $scope = {};
      var controller = $controller('AddGoalsController', { $scope: $scope });
      controller.pageLayout = [
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q1', placeholder: 'ADD_GOAL_P1', showPage: true, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q2', placeholder: 'MONEY_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q3', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q4', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false}
      ];
      expect(controller.pageLayout[0].swipeLeft).toBeFalsy();
      controller.nextPage(controller.pageLayout[0]);
      expect(controller.pageLayout[0].swipeLeft).toBeTruthy();
    });
  });

  describe('lastPage function', function() {
    it('should update the current page\'s pageShow boolean to false', function() {
      var $scope = {};
      var controller = $controller('AddGoalsController', { $scope: $scope });
      controller.pageLayout = [
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q1', placeholder: 'ADD_GOAL_P1', showPage: false, swipeLeft: true},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q2', placeholder: 'MONEY_PLACEHOLDER', showPage: true, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q3', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q4', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false}
      ];
      expect(controller.pageLayout[1].showPage).toBeTruthy();
      controller.lastPage(controller.pageLayout[1]);
      expect(controller.pageLayout[1].showPage).toBeFalsy();
    });

    it('should update the next page\'s pageShow boolean to true', function() {
      var $scope = {};
      var controller = $controller('AddGoalsController', { $scope: $scope });
      controller.pageLayout = [
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q1', placeholder: 'ADD_GOAL_P1', showPage: false, swipeLeft: true},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q2', placeholder: 'MONEY_PLACEHOLDER', showPage: true, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q3', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q4', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: false}
      ];
      expect(controller.pageLayout[0].showPage).toBeFalsy();
      controller.lastPage(controller.pageLayout[1]);
      expect(controller.pageLayout[0].showPage).toBeTruthy();
    });

    it('should update the current page\'s swipeLeft boolean to false', function() {
      var $scope = {};
      var controller = $controller('AddGoalsController', { $scope: $scope });
      controller.pageLayout = [
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q1', placeholder: 'ADD_GOAL_P1', showPage: false, swipeLeft: true},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q2', placeholder: 'MONEY_PLACEHOLDER', showPage: false, swipeLeft: true},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q3', placeholder: 'DATE_PLACEHOLDER', showPage: false, swipeLeft: true},
        {title: 'ADD_GOAL_TITLE', text: 'ADD_GOAL_Q4', placeholder: 'DATE_PLACEHOLDER', showPage: true, swipeLeft: true}
      ];
      expect(controller.pageLayout[3].swipeLeft).toBeTruthy();
      controller.lastPage(controller.pageLayout[3]);
      expect(controller.pageLayout[3].swipeLeft).toBeFalsy();
    });
  });

});
