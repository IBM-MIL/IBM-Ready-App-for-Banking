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

// Uncomment the initialization options as required. For advanced initialization options please refer to IBM MobileFirst Platform Foundation Knowledge Center
var wlInitOptions = {

    showIOS7StatusBar: false

    // # To disable automatic hiding of the splash screen uncomment this property and use WL.App.hideSplashScreen() API
    //autoHideSplash: false,

    // # The callback function to invoke in case application fails to connect to MobileFirst Server
    //onConnectionFailure: function (){},

    // # MobileFirst Server connection timeout
    //timeout: 30000,

    // # How often heartbeat request will be sent to MobileFirst Server
    //heartBeatIntervalInSecs: 20 * 60,

    // # Enable FIPS 140-2 for data-in-motion (network) and data-at-rest (JSONStore) on iOS or Android.
    //   Requires the FIPS 140-2 optional feature to be enabled also.
    //enableFIPS : false,

    // # The options of busy indicator used during application start up
    //busyOptions: {text: "Loading..."}
};

if (window.addEventListener) {
    window.addEventListener('load', function() {
        try {
            WL.Client.init(wlInitOptions);
        } catch (e) {
            console.log('Worklight is not running properly');
            console.log(e.message);
        }
    }, false);
} else if (window.attachEvent) {
    window.attachEvent('onload', function() {
        try {
            WL.Client.init(wlInitOptions);
        } catch (e) {
            console.log('Worklight is not running properly');
            console.log(e.message);
        }
    });
}
function onConnectSuccess() {
    WL.Logger.debug('Successfully connected to Worklight Server.');
    WL.App.sendActionToNative('connectStatus', {
            status: true
        });
}

function onConnectFailure() {
    WL.Logger.debug('Failed connecting to Worklight Server.');
    WL.App.sendActionToNative('connectStatus', {
            status: false
        });
}

function wlCommonInit() {
    /*
     * Use of WL.Client.connect() API before any connectivity to a MobileFirst
     * Server is required. This API should be called only once, before any other
     * WL.Client methods that communicate with the MobileFirst Server. Don't
     * forget to specify and implement onSuccess and onFailure callback
     * functions for WL.Client.connect(), e.g:
     */

    try {
        WL.Logger.debug('Attempting to connect to WL server...');

        // Calling connect() forces the direct update check against the WL server
        WL.Client.connect({
            onSuccess: onConnectSuccess,
            onFailure: onConnectFailure
        });
    } catch (e) {
        console.log('Worklight is not running properly');
        console.log(e.message);
    }
    // Common initialization code goes here
    // //Initialize Action Receiver
    HybridJS.init();
}


