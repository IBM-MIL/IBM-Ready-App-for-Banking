// Menu Navigation Tests

#import "TestUtils.js"

UIALogger.logStart("Testing Menu Navigation");
UIALogger.logMessage("Logging In");
performLogin(true);

UIALogger.logMessage("Testing Navigation Menu");

target.frontMostApp().mainWindow().buttons()[0].tap();
target.delay(3);
UIALogger.logMessage("Open Goals");
target.frontMostApp().mainWindow().buttons()[3].tap();
target.delay(3);
var goalsLabel = target.frontMostApp().mainWindow().staticTexts()["GOALS"];
if (!goalsLabel.isVisible()){
    UIALogger.logFail("Menu Navigation Test Failed - Did not navigate to goals");
    javascript_abort();
}

target.frontMostApp().mainWindow().buttons()[1].tap();
target.delay(3);
UIALogger.logMessage("Open New Account");
target.frontMostApp().mainWindow().buttons()[8].tap();
target.delay(3);
var greetingLabel = target.frontMostApp().mainWindow().scrollViews()[0].staticTexts()["HEY MEADOW!"];
if (!greetingLabel.isVisible()){
    UIALogger.logFail("Menu Navigation Test Failed - Did not navigate to new account");
    javascript_abort();
}

target.frontMostApp().mainWindow().buttons()[1].tap();
target.delay(3);
UIALogger.logMessage("Open Settings");
target.frontMostApp().mainWindow().buttons()[9].tap();
target.delay(3);
var settingsLabel = target.frontMostApp().mainWindow().tableViews()[0].staticTexts()["SETTINGS"];
if (!settingsLabel.isVisible()){
    UIALogger.logFail("Menu Navigation Test Failed - Did not navigate to settings");
    javascript_abort();
}

target.frontMostApp().mainWindow().tableViews()[0].buttons()[0].tap();
target.delay(3);
UIALogger.logMessage("Open Accounts");
target.frontMostApp().mainWindow().buttons()[1].tap();
target.delay(3);
var accountsLabel = target.frontMostApp().mainWindow().scrollViews()[0].staticTexts()["ACCOUNTS"];
if (!accountsLabel.isVisible()){
    UIALogger.logFail("Menu Navigation Test Failed - Did not navigate to accounts");
    javascript_abort();
}

target.frontMostApp().mainWindow().buttons()[0].tap();
target.delay(3);
UIALogger.logMessage("Close Menu");
target.frontMostApp().mainWindow().buttons()["menu close dk grey"].tap();
target.delay(3);

var accountsLabel = target.frontMostApp().mainWindow().scrollViews()[0].staticTexts()["ACCOUNTS"];
if (!accountsLabel.isVisible()){
    UIALogger.logFail("Menu Navigation Test Failed - Menu failed to close");
    javascript_abort();
}

UIALogger.logPass("Menu Navigation Passed.");