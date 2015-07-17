'use strict';

describe('nav-dots-directive', function(){

  beforeEach(module('hatch', function ($translateProvider) {
    $translateProvider
      .translations('en', englishTranslations)
      .preferredLanguage('en');
  }));

  beforeEach(module('dir-templates'));

  var $rootScope, $compile, html, element;

  beforeEach(inject(function(_$rootScope_, _$compile_) {
    $rootScope = _$rootScope_;
    $compile = _$compile_;
  }));

  it('should have elements with class name "nav-dot"', function() {
    html = $compile('<nav-dots-directive items="[\'one\', \'two\', \'three\']" current-item="\'one\'"></nav-dots-directive>')($rootScope);
    $rootScope.$digest();
    element = html[0].querySelectorAll('.nav-dot');
    expect(angular.element(element).hasClass('nav-dot')).toBeTruthy();
  });

  describe('ng-repeat works as expected', function() {
    it('should have 3 elements', function() {
      element = html[0].getElementsByClassName('nav-dot');
      expect(element.length).toEqual(3);
    });

    it('should have 5 elements', function() {
      html = $compile('<nav-dots-directive items="[\'one\', \'two\', \'three\', \'four\', \'five\']" current-item="\'one\'"></nav-dots-directive>')($rootScope);
      $rootScope.$digest();
      element = html[0].getElementsByClassName('nav-dot');
      expect(element.length).toEqual(5);
    });

    it('should only have 1 element with the class name "current"', function() {
      element = html[0].getElementsByClassName('current');
      expect(element.length).toEqual(1);
    });
  });

});
