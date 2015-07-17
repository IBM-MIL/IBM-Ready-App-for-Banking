// Logout Test

#import "TestUtils.js"

var enableDemoMode = true;

UIALogger.logStart("Testing Logout");
UIALogger.logMessage("Logging In");
performLogin(true);

UIALogger.logMessage("Open Menu");
target.frontMostApp().mainWindow().buttons()[0].tap();
target.delay(2);
UIALogger.logMessage("Press Log Out");
target.frontMostApp().mainWindow().buttons()[10].tap();

performLogin(false);

var usernameField = target.frontMostApp().mainWindow().textFields()[0].textFields()[0];

if (usernameField.isVisible()){
    UIALogger.logPass("Successfully logged out.");
} else {
    UIALogger.logFail("Failed to log out.");
}