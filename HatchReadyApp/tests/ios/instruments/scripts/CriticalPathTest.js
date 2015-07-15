// Critical Path Test

#import "TestUtils.js"

UIALogger.logStart("Running Critical Path Test");

UIALogger.logMessage("Logging In");

performLogin(true);

UIALogger.logMessage("Navigating Goals");
target.frontMostApp().mainWindow().scrollViews()[0].tableViews()[0].tapWithOptions({tapOffset:{x:0.50, y:0.20}});
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].webViews()[0].tapWithOptions({tapOffset:{x:0.65, y:0.12}});
target.delay(3);
target.frontMostApp().mainWindow().buttons()[0].tap();
target.delay(3);
UIALogger.logMessage("Navigating New Account");
target.frontMostApp().mainWindow().buttons()[1].tap();
target.delay(3);
target.frontMostApp().mainWindow().buttons()["NEW ACCOUNT"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()[0].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["ONCE OR TWICE"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["HIGH INTEREST RATE"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["YES"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["confirm white"].tap();
target.delay(5);
UIALogger.logMessage("Logging Out");
target.frontMostApp().mainWindow().buttons()["menu white"].tap();
target.delay(3);
target.frontMostApp().mainWindow().buttons()["LOG OUT"].tap();

performLogin(false);

var usernameField = target.frontMostApp().mainWindow().textFields()[0].textFields()[0];

if (usernameField.isVisible()){
    UIALogger.logPass("Successfully finished critical path.");
} else {
    UIALogger.logFail("Did not reach end of critical path.");
}

