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
/*eslint "angular/ng_window_service": 0, "angular/ng_document_service": 0, "angular/ng_timeout_service": 0, "angular/ng_json_functions": 0*/
'use strict';
/**
 * @class HybridJS
 * @description A wrapper for all of the Worklight actions from native
 */
var HybridJS = (function() {

    function applyChanges() {
        //We need to get the scope from the current controller in order to force an apply
        //The apply essentially performs a refresh on the view so the data will appear
        var selector = 'hatch-app';
        var scope = angular.element(
            document.getElementById(selector)).
        scope();
        scope.$apply();
    }

    /**
     * @function setupGoals
     * @description receives the initial goal information from the native and sets it in angular
     * @param  {Array(Goal)} goals The goals object to set
     */
    function setupGoals(goals) {
            var appWrapper = document.getElementById('hatch-app');
            var $inj = angular.element(appWrapper).injector();
            var $goals = $inj.get('Goals');
            goals.forEach(function(goal) {
                goal.start = new Date(goal.start);
                goal.end = new Date(goal.end);
                goal.progress = Math.round(goal.progress);

                if (goal.feasibility === 0) {
                    goal.feasibility = 'feasible';
                } else if (goal.feasibility === 1) {
                    goal.feasibility = 'warning';
                } else {
                    goal.feasibility = 'unfeasible';
                }
            });
            $goals.setGoals(goals);
            applyChanges();
        }
    /**
     * @function setupOffers
     * @description receives the initial offer information from the native and sets it in angular
     * @param  {Array(Offer)} goals The goals object to set
     */
    function setupOffers(offers) {
        var appWrapper = document.getElementById('hatch-app');
        var $inj = angular.element(appWrapper).injector();
        var $offers = $inj.get('Offers');
        offers.forEach(function(offer) {
            offer.displayApy = offer.apy + '%';
        });
        $offers.allOffers = offers;
        applyChanges();
    }

    /**
     * @function setupLocale
     * @description receives the initial locale and language information from the native and sets it in angular
     * @param  {String} language The language that text should be displayed in
     */
    function setupLocale(language) {
        var appWrapper = document.getElementById('hatch-app');
        var $inj = angular.element(appWrapper).injector();
        var $translate = $inj.get('$translate');
        var lang = language.split('_')[0];
        $translate.use(lang);
        applyChanges();
    }


    /**
     * @function updatePage
     * @description Updates the native nav bar's title, needed for first screen
     * @param  {string} newTitle The title to set
     * @param {String} newRoute The new route to set
     * @param {Boolean} showBack If the back button should be shown or not
     * @param {headerColor} headerColor The hex color value of the header
     */
    function updatePage(newTitle, newRoute, showBack, headerColor) {
        try {
            WL.App.sendActionToNative('updatePage', {
                title: newTitle,
                route: newRoute,
                showBackButton: showBack,
                headerColor: headerColor
            });
        } catch (e) {
            console.log('Worklight is not running properly');
            console.log(e.message);
        }
    }

    /**
     * @function changePage
     * @description Changes the page to the new route, callback is needed so native can perform the push animation
     * @param  {Object} route The route to go to
     */
    function changePage(route) {
        window.location.hash = '#/' + route;
        if (route === '') {
            updatePage('GOALS', '', false, '#ffffff');
        } else if (route === 'offers') {
            updatePage('ALL OFFERS', '', false, '#ffffff');
        }
    }

    /**
     * @function onBackButtonCalled
     * @description captures when the navbar back button is clicked and goes to previous route using the history API
     */
    function onBackButtonClicked() {
        setTimeout(function() {
            window.history.back();
        }, 10);
    }

    /**
     * @function setFeasibility
     * @description sets the feasibility of the temp goal in the goal factory
     * @param {goal} goal The goal to use as the temp model
     */
    function setFeasibility(goal) {
        var appWrapper = document.getElementById('hatch-app');
        var $inj = angular.element(appWrapper).injector();
        var $goals = $inj.get('Goals');
        var $formatter = $inj.get('Formatter');
        $goals.tempGoal = goal;
        $formatter.convertFeasibilityToString($goals.tempGoal);
        $formatter.milToDate($goals.tempGoal);
        applyChanges();
    }

    /**
     * @function populateOptions
     * @description Populates the otherOptions array
     * @param  {Array<goals>} goals The array of goals to populate from
     */
    function populateOptions(goals) {
        var appWrapper = document.getElementById('hatch-app');
        var $inj = angular.element(appWrapper).injector();
        var $goals = $inj.get('Goals');
        var $formatter = $inj.get('Formatter');
        $goals.optionalGoals = [];
        for (var i = 0; i < goals.length; i++) {
            $goals.optionalGoals.push(goals[i]);
            $formatter.convertFeasibilityToString($goals.optionalGoals[i].goal);
            $formatter.milToDate($goals.optionalGoals[i].goal);

            if (i === 0) {
                $goals.optionIsFeasible = goals[i].isFeasible;
            }
        }
        applyChanges();
    }

    /**
     * @function callback
     * @description The callback function to determine what page to go to after data is recieved from getting feasibility
     * @param  {String}   thePage    The route of the page to go to
     * @param  {Boolean}  isFeasible If the goal is feasible or not
     */
    function callback(thePage, isFeasible) {
        changePage(thePage);
        if (thePage === 'feasibility') {
            if (isFeasible) {
                updatePage('We have good news!', thePage, false, '#8cd211');
            } else {
                updatePage('We have bad news', thePage, false, '#ff7832');
            }
        } else if (thePage === 'options') {
            updatePage('Options', thePage, true, '#8cd211');
        }
    }

    /**
     * @function getPage
     * @description get the page from the util function
     */
    function getPage() {
        var appWrapper = document.getElementById('hatch-app');
        var $inj = angular.element(appWrapper).injector();
        var $util = $inj.get('Utility');
        return $util.feasibilityPage;
    }

    /**
     * @function getFeasibility
     * @description Sends a goal to WL to check the feasibility
     * @param {goal} goalF The goal to find the feasibility of
     */
    function getFeasibility(goalF) {
        var appWrapper = document.getElementById('hatch-app');
        var $inj = angular.element(appWrapper).injector();
        var $goals = $inj.get('Goals');
        var $formatter = $inj.get('Formatter');
        var oldStart = goalF.start;
        var oldEnd = goalF.end;
        var oldList = $goals.allGoals;
        $formatter.convertFeasibilityToInt(goalF);
        $formatter.convertDates(goalF);
        $goals.allGoals.forEach(function(goal) {
          $formatter.convertDates(goal);
          $formatter.convertFeasibilityToInt(goal);
        });
        WL.App.sendActionToNative('checkFeasibility', {newGoal: goalF, goalList: $goals.allGoals});
        $goals.allGoals.forEach(function(goal) {
          $formatter.convertFeasibilityToString(goal);
          $formatter.milToDate(goal);
        });
        $formatter.convertFeasibilityToString(goalF);
        goalF.start = oldStart;
        goalF.end = oldEnd;
        $goals.allGoals = oldList;
    }

    /**
     * @function receiveAction
     * @description acts as an observer to determine which action was fired
     * @param  {Object} received the action which was fired and the data passed with it
     */
    function receiveAction(received) {

            var actions = {
                'backButtonClicked': function() {
                    onBackButtonClicked();
                },
                'changePage': function() {
                    changePage(received.data.route);
                },
                'initialSetup': function() {
                    setupGoals(received.data.goals);
                },
                'offersSetup': function() {
                    setupOffers(JSON.parse(received.data.result));
                },
                'setLocale': function() {
                    setupLocale(received.data.userData.language);
                },
                'receiveFeasibility': function() {
                    setFeasibility(JSON.parse(received.data.result)[0].goal);
                    populateOptions(JSON.parse(received.data.result));
                    callback(getPage(), JSON.parse(received.data.result)[0].isFeasible);
                }
            };

            if (angular.isFunction(actions[received.action]) === false) {
                throw new Error('Invalid action.');
            }
            return actions[received.action]();

        }
    /**
     * @function pressBackButton
     * @description Convenience function for when an action needs to simulate pressing the back button
     */
    function pressBackButton() {
        WL.App.sendActionToNative('pressBackButton', {});
    }

    /**
     * @function sendGoalsToNative
     * @description Sends the list of goals back to the native side
     * @param  {Array(goal)} goals The goals to send
     */
    function sendGoalsToNative(goals) {
        WL.App.sendActionToNative('sendGoals', {
            goals: goals
        });
    }

    /**
     * @function init
     * @description initialize the object with the action receiver to get native actions
     */
    function init() {
        try {
            WL.App.addActionReceiver('myActionReceiver', receiveAction);
        } catch (e) {
            console.log('failed to setup action receiver');
        }
    }

    return {
        init: init,
        callback: callback,
        updatePage: updatePage,
        sendGoalsToNative: sendGoalsToNative,
        pressBackButton: pressBackButton,
        getFeasibility: getFeasibility
    };
}());
