#import "TestUtils.js"

UIALogger.logStart("Testing Goals Information");
UIALogger.logMessage("Logging In");
performLogin(true);

UIALogger.logMessage("Navigating to goals");
target.frontMostApp().mainWindow().buttons()[0].tap();
target.delay(2);
target.frontMostApp().mainWindow().buttons()["GOALS"].tap();
target.delay(2)
UIALogger.logMessage("Testing Goals");

CheckText(0, "NEW MIXER");
CheckText(1, "85%");
CheckText(2, "NEW KITCHEN SPACE");
CheckText(3, "60%");
CheckText(4, "NEW OVEN");
CheckText(5, "24%");
CheckText(6, "CONVECTION OVEN");
CheckText(7, "18%");
CheckText(8, "UPDATE SIGNAGE");
CheckText(9, "45%");
CheckText(10, "EXTRA VAN");
CheckText(11, "50%");
CheckText(12, "DISPLAY CASE");
CheckText(13, "6%");
CheckText(14, "REFRIGERATOR");
CheckText(15, "70%");
CheckText(16, "COOLING RACKS");
CheckText(17, "40%");
CheckText(18, "NEW BARTENDER");
CheckText(19, "12%");
CheckText(20, "NEW MIXER");
CheckText(21, "60%");
CheckText(22, "NEW MIXER");
CheckText(23, "96%");

UIALogger.logPass("All goals loaded correctly.");

function CheckText(index, expectedText) {
    
    var actualText = target.frontMostApp().mainWindow().scrollViews()[0].webViews()[0].staticTexts()[index].name();
    UIALogger.logMessage("Checking Static Text " + index + " Actual: " + actualText + " Expected: " + expectedText);
    if (actualText != expectedText) {
        UIALogger.logFail("Incorrect data - Expected: " + expectedText + " Actual: " + actualText);
        javascript_abort();
    }
    
}