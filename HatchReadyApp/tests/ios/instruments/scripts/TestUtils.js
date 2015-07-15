// Test Utilities
/////////////////////////////////////////////////////////
// Basic functions needed throughout instruments testing.
/////////////////////////////////////////////////////////

var demoAlertIsActive = false;

// override the default alert handler
UIATarget.onAlert = function onAlert(alert) {
    UIALogger.logMessage("Alert detected!")
    return true;
}

var target = UIATarget.localTarget();
var appWindow = target.frontMostApp();
var window = appWindow.mainWindow();

//////////////////////////
// Dismisses the MQA Alert
//////////////////////////
function dismissMQA() {
    target.delay(1);
    target.tap({x:265.50, y:200.00});
    
}

/////////////////////////
// Performs a valid login
/////////////////////////
function performLogin(isDemoMode) {
    target.delay(8); // wait for alert dialog to appear
    
    if (isDemoMode) {
        target.frontMostApp().alert().buttons()["Yes"].tap();
        target.delay(8); // wait for demo mode to auto-login
    } else {
        target.frontMostApp().alert().buttons()["No"].tap();
        target.delay(3);
    }
}

//////////////////////////////////////////////////////////////
// Performs an abort to prevent the test from running further.
//////////////////////////////////////////////////////////////
function javascript_abort()
{
    //throw new Error('The test has failed. Prevent further execution.');
}