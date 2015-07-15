// Account Transaction Tests

#import "TestUtils.js"

UIALogger.logStart("Testing Account Information");
UIALogger.logMessage("Logging In");
performLogin(true);

UIALogger.logMessage("Checking Bakery Transaction Information");

target.frontMostApp().mainWindow().scrollViews()[0].tableViews()[0].cells()[1].tap();
target.delay(3);
performSavingsCheck("- $12,024.54", "+ $15,000.00", "+ $100,000.00");
target.frontMostApp().mainWindow().buttons()[0].tap();
target.frontMostApp().mainWindow().scrollViews()[0].tableViews()[0].cells()[2].tap();
target.delay(3);
performCheckingCheck("- $17,000.00", "+ $25,000.00", "+ $3,600.00", "+ $3,600.00", "- $2,400.00", "- $2,700.00", "- $1,600.00", "+ $10,000.00");
target.frontMostApp().mainWindow().buttons()[0].tap();

target.frontMostApp().mainWindow().buttons()[0].tap();
target.delay(3);
target.tap({x:229.00, y:131.50});
target.delay(5);

UIALogger.logMessage("Checking Catering Transaction Information");
target.delay(3);

target.frontMostApp().mainWindow().scrollViews()[0].tableViews()[0].cells()[0].tap();
target.delay(3);
performSavingsCheck("- $12,024.54", "+ $15,000.00", "+ $100,000.00");
target.frontMostApp().mainWindow().buttons()[0].tap();
target.frontMostApp().mainWindow().scrollViews()[0].tableViews()[0].cells()[2].tap();
target.delay(3);
performCheckingCheck("- $15,000.00", "+ $25,000.00", "+ $25,000.00", "+ $3,600.00", "+ $3,600.00", "- $2,400.00", "- $2,700.00", "- $600.00");

UIALogger.logPass("All Transactions Correct");

function performSavingsCheck(e_cell1, e_cell2, e_cell3) {
    
    var transactionTable = target.frontMostApp().mainWindow().tableViews()[0];
    var cell1 = transactionTable.cells()[0].staticTexts()[0].name();
    
    UIALogger.logMessage("Savings Cell 1: " + cell1);
    if (cell1 != e_cell1){
        UIALogger.logFail("Savings Transaction Check Failed - Cell 1 Incorrect");
        javascript_abort();
    }
    
    var cell2 = transactionTable.cells()[1].staticTexts()[0].name();
    
    UIALogger.logMessage("Savings Cell 2: " + cell2);
    if (cell2 != e_cell2){
        UIALogger.logFail("Savings Transaction Check Failed - Cell 2 Incorrect");
        javascript_abort();
    }
    
    var cell3 = transactionTable.cells()[2].staticTexts()[0].name();
    
    UIALogger.logMessage("Savings Cell 3: " + cell3);
    if (cell3 != e_cell3){
        UIALogger.logFail("Savings Transaction Check Failed - Cell 3 Incorrect");
        javascript_abort();
    }
    
 
}

function performCheckingCheck(e_cell1, e_cell2, e_cell3, e_cell4, e_cell5, e_cell6, e_cell7, e_cell8) {
    
    var transactionTable = target.frontMostApp().mainWindow().tableViews()[0];
    var cell1 = transactionTable.cells()[0].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 1: " + cell1);
    if (cell1 != e_cell1){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 1 Incorrect");
        javascript_abort();
    }
    
    var cell2 = transactionTable.cells()[1].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 2: " + cell2);
    if (cell2 != e_cell2){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 2 Incorrect");
        javascript_abort();
    }
    
    var cell3 = transactionTable.cells()[2].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 3: " + cell3);
    if (cell3 != e_cell3){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 3 Incorrect");
        javascript_abort();
    }
    
    var cell4 = transactionTable.cells()[3].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 4: " + cell4);
    if (cell4 != e_cell4){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 4 Incorrect");
        javascript_abort();
    }
    
    var cell5 = transactionTable.cells()[4].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 5: " + cell5);
    if (cell5 != e_cell5){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 5 Incorrect");
        javascript_abort();
    }
    
    var cell6 = transactionTable.cells()[5].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 6: " + cell6);
    if (cell6 != e_cell6){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 6 Incorrect");
        javascript_abort();
    }
    
    var cell7 = transactionTable.cells()[6].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 7: " + cell7);
    if (cell7 != e_cell7){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 7 Incorrect");
        javascript_abort();
    }
    
    var cell8 = transactionTable.cells()[7].staticTexts()[0].name();
    
    UIALogger.logMessage("Checking Cell 8: " + cell8);
    if (cell8 != e_cell8){
        UIALogger.logFail("Checking Transaction Check Failed - Cell 8 Incorrect");
        javascript_abort();
    }
    
}