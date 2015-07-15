'use strict';

module.exports = function(config) {

  config.set({
    // enable / disable watching file and executing tests whenever any file changes
    autoWatch : true,

    //include single run false and chrome to view html.js file paths in browser
    singleRun : true,

    

    basePath : '',

    // list of files / patterns to load in the browser
    files: [
        '../../apps/Hatch/bower_components/angular/angular.js',
        '../../apps/Hatch/bower_components/angular-route/angular-route.js',
        '../../apps/Hatch/bower_components/angular-mocks/angular-mocks.js',
        '../../apps/Hatch/bower_components/angular-animate/angular-animate.js',
        '../../apps/Hatch/bower_components/angular-touch/angular-touch.js',
        '../../apps/Hatch/bower_components/angular-sanitize/angular-sanitize.js',
        '../../apps/Hatch/bower_components/angular-translate/angular-translate.js',
        '../../apps/Hatch/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js',
        '../../apps/Hatch/bower_components/ng-sortable/dist/ng-sortable.js',
        '../../apps/Hatch/src/app/index.js',
        '../../apps/Hatch/src/**/*.js',
        '../../apps/Hatch/src/i18n/*.js',
        '*.test.js',


        //load html files
        '../../apps/Hatch/src/**/*.html'
    ],

    // list of files to exclude
    exclude: [
    'gulpfile.js'
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      '../../apps/Hatch/src/**/*.html': 'ng-html2js'
    },

    //set options of the html2jsPreprocessor
    ngHtml2JsPreprocessor: {
        stripPrefix: '.*/src/',
        //prependPrefix: 'src',
        moduleName: 'dir-templates'
    },

    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress', 'junit'],

    junitReporter: {
        outputFile: 'test-results.xml'
    },

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
        'karma-jasmine',
        'karma-junit-reporter'
    ]
  });
};
