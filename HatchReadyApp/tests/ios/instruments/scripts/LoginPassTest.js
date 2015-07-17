// Tests for a successful login.

#import "TestUtils.js"

UIALogger.logStart("Running Valid Login Test");

performLogin(true);

if (target.frontMostApp().mainWindow().buttons()["menu white"].isVisible()) {
    UIALogger.logPass("Valid Login Test Passed - Dashboard visible");
} else {
    UIALogger.logFail("Valid Login Test Failed - Dashboard not visible");
}