// Test Watson Analytics Connection

#import "TestUtils.js"

UIALogger.logStart("Testing Watson Trade-off Analytics Connection Information");
UIALogger.logMessage("Logging In");
performLogin(true);

UIALogger.logMessage("Testing input and output exchange");

target.frontMostApp().mainWindow().buttons()[0].tap();
target.delay(3);
target.frontMostApp().mainWindow().buttons()[7].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()[0].tap();
target.delay(3);

UIALogger.logMessage("Getting first recommendation");
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["ONCE OR TWICE"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["HIGH INTEREST RATE"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["YES"].tap();
target.delay(3)
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["confirm white"].tap();
target.delay(5);
var recommendation = target.frontMostApp().mainWindow().staticTexts()[1];
if (!recommendation.isVisible()){
    UIALogger.logFail("Did not connect to Trade-off Analytics - Incorrect 1st recommendation");
    javascript_abort();
}

backOut(3);

UIALogger.logMessage("Getting second recommendation");
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["AS OFTEN AS I CAN"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["LIQUIDITY"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["NO"].tap();
target.delay(3)
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["confirm white"].tap();
target.delay(5);
var recommendation2 = target.frontMostApp().mainWindow().staticTexts()[1];
if (!recommendation2.isVisible()){
    UIALogger.logFail("Did not connect to Trade-off Analytics - Incorrect 2nd recommendation");
    javascript_abort();
}

backOut(3);

UIALogger.logMessage("Getting third recommendation");
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["NOT SURE"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["BOTH"].tap();
target.delay(3);
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["YES"].tap();
target.delay(3)
target.frontMostApp().mainWindow().scrollViews()[0].buttons()["confirm white"].tap();
target.delay(5);
var recommendation3 = target.frontMostApp().mainWindow().staticTexts()[1];

if (!recommendation3.isVisible()){
    UIALogger.logFail("Did not connect to Trade-off Analytics - Incorrect 3rd recommendation");
    javascript_abort();
}

UIALogger.logPass("Successfully connected to Watson Trade-off Analytics");

function backOut(times) {
    if (times > 0) {
        target.delay(3);
        target.frontMostApp().mainWindow().buttons()["back white"].tap();
        backOut(times - 1);
    }
}
