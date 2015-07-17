'use strict';

module.exports = function(config) {

  config.set({
    // enable / disable watching file and executing tests whenever any file changes
    autoWatch : true,

    //include single run and chrome to view html.js file paths in browser
    //singleRun : false,

    // list of files / patterns to load in the browser
    files: [
        'bower_components/angular/angular.js',
        'bower_components/angular-route/angular-route.js',
        'bower_components/angular-mocks/angular-mocks.js',
        'bower_components/angular-animate/angular-animate.js',
        'bower_components/angular-touch/angular-touch.js',
        'bower_components/angular-sanitize/angular-sanitize.js',
        'bower_components/angular-translate/angular-translate.js',
        'bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js',
        'bower_components/ng-sortable/dist/ng-sortable.js',
        'src/app/*.js',
        'src/app/goals/*/*.js',
        'src/components/*/*.js',
        'src/i18n/*.js',
        'tests/*.js',


        //load html files
        'src/app/*/*/*.html',
        'src/components/*/*.html'
    ],

    // list of files to exclude
    exclude: [
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'src/app/*/*/*.html': 'ng-html2js',
      'src/components/*/*.html' : 'ng-html2js'
    },

    //set options of the html2jsPreprocessor
    ngHtml2JsPreprocessor: {
        moduleName: 'dir-templates'
    },

    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    // frameworks to use
    frameworks: ['jasmine'],

    // start these browsers
    browsers : ['PhantomJS'],
    //browsers : ['Chrome'],

    plugins : [
        //'karma-chrome-launcher',
        'karma-ng-html2js-preprocessor',
        'karma-phantomjs-launcher',
        'karma-jasmine'
    ]
  });
};
