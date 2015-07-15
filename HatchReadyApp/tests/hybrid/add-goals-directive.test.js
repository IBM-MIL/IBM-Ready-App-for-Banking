/*'use strict';

var element;

describe('add-goals-directive', function(){

  beforeEach(module('hatch', function ($translateProvider) {
    $translateProvider
      .translations('en', englishTranslations)
      .preferredLanguage('en');
  }));

  beforeEach(module('dir-templates'));

  var $rootScope, $compile;

  beforeEach(inject(function(_$rootScope_, _$compile_) {
    $rootScope = _$rootScope_;
    $compile = _$compile_;
  }));

  it('should say "New Goal" when in English', function() {
    element = $compile('<add-goals-directive layout="{title: \'ADD_GOAL_TITLE\', text: \'ADD_GOAL_Q1\', placeholder: \'ADD_GOAL_P1\', showPage: true, swipeLeft: false}"></add-goals-directive>')($rootScope);
    $rootScope.$digest();
    expect(element.text()).toContain('New Goal');
  });

  it('should say "What are you saving for?" when in English', function() {
    expect(element.text()).toContain('What are you saving for?');
  });

});*/
