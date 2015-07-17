// Test for a failed login.

#import "TestUtils.js"

UIALogger.logStart("Running Invalid Login Test");

performLogin(false);
                
window.textFields()[0].textFields()[0].tap();
target.delay(1);
window.textFields()[0].setValue("fakeuser");
window.secureTextFields()[0].secureTextFields()[0].tap();
target.delay(1);
window.secureTextFields()[0].setValue("fakepassword");
target.delay(1);
target.frontMostApp().mainWindow().buttons()["confirm white"].tap();
target.delay(8);

if (window.staticTexts()[0].isVisible()) {
    UIALogger.logPass("Invalid Login Test Passed - Invalid alert displayed");
} else {
    UIALogger.logFail("Invalid Login Test Failed - Invalid alert was not displayed");
}
