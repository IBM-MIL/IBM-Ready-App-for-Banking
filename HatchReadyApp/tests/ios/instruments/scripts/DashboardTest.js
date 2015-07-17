// Dashboard Tests

#import "TestUtils.js"

UIALogger.logStart("Testing Dashboard Information");
UIALogger.logMessage("Logging In");
performLogin(true);

UIALogger.logMessage("Checking Dashboard Information");

checkUserInfo();

UIALogger.logPass("Dashboard Information Correct");

function checkUserInfo() {
    
    UIALogger.logMessage("Checking User Information");
    var name = target.frontMostApp().mainWindow().scrollViews()[0].staticTexts()[1].name();
    
    UIALogger.logMessage("Name: " + name);
    if (name != "MEADOW!") {
        UIALogger.logFail("User Information Check Failed - Name Incorrect");
        javascript_abort();
    }
    
    var business1 = target.frontMostApp().mainWindow().scrollViews()[0].scrollViews()[0].staticTexts()[0].name();
    UIALogger.logMessage("Business: " + business1);
    if (business1 != "FANNIE'S BAKERY") {
        UIALogger.logFail("User Information Check Failed - Business 1 Incorrect");
        javascript_abort();
    }
    
    checkBalances("$146,295.46", "$24,820.00", "$102,975.46", "$18,500.00", "$2,014.29", "$558.34", "$1,416.67", "$3,989.30", "$142,306.16");
    
    target.frontMostApp().mainWindow().buttons()[0].tap();
    target.delay(3);
    target.tap({x:229.00, y:131.50});
    target.delay(5);
    
    var business2 = target.frontMostApp().mainWindow().scrollViews()[0].scrollViews()[0].staticTexts()[0].name();
    UIALogger.logMessage("Business: " + business2);
    if (business2 != "FANNIE'S CATERING") {
        UIALogger.logFail("User Information Check Failed - Business 2 Incorrect");
        javascript_abort();
    }
    
    checkBalances("$272,309.46", "$102,975.46", "$132,834.00", "$36,500.00", "$7,730.00", "$475.00", "$1,250.00", "$9,455.00", "$262,854.46");
    
}

function checkBalances(e_total, e_cell1, e_cell2, e_cell3, e_cell4, e_cell5, e_cell6, e_spent,e_available) {
    
    UIALogger.logMessage("Checking Account/Spending Balances");
    var totalBalance = window.scrollViews()[0].staticTexts()[4].name();
    
    UIALogger.logMessage("Total Balance: " + totalBalance + " Expected: " + e_total);
    if (totalBalance != e_total) {
        UIALogger.logFail("Account Balance Checks Failed - Total Balance Incorrect");
        javascript_abort();
    }
    
    var accountsTable = target.frontMostApp().mainWindow().scrollViews()[0].tableViews()[0];
    var cell1 = accountsTable.cells()[0].staticTexts()[1].name();
    
    UIALogger.logMessage("Account 1: " + cell1  + " Expected: " + e_cell1);
    if (cell1 != e_cell1) {
        UIALogger.logFail("Account Balance Checks Failed - Account Cell 1 Incorrect");
        javascript_abort();
    }
    
    var cell2 = accountsTable.cells()[1].staticTexts()[1].name();
    
    UIALogger.logMessage("Account 2: " + cell2 + " Expected: " + e_cell2);
    if (cell2 != e_cell2) {
        UIALogger.logFail("Account Balance Checks Failed - Account Cell 2 Incorrect");
        javascript_abort();
    }
    
    var cell3 = accountsTable.cells()[2].staticTexts()[1].name();

    UIALogger.logMessage("Account 3: " + cell3 + " Expected: " + e_cell3);
    if (cell3 != e_cell3) {
        UIALogger.logFail("Account Balance Checks Failed - Account Cell 3 Incorrect");
        javascript_abort();
    }
    
    var spendingTable = target.frontMostApp().mainWindow().scrollViews()[0].tableViews()[1];
    var cell4 = spendingTable.cells()[0].staticTexts()[1].name();
    
    UIALogger.logMessage("Spending 1: " + cell4 + " Expected: " + e_cell4);
    if (cell4 != e_cell4) {
        UIALogger.logFail("Account Balance Checks Failed - Spending Cell 1 Incorrect");
        javascript_abort();
    }
    
    var cell5 = spendingTable.cells()[1].staticTexts()[1].name();
    
    UIALogger.logMessage("Spending 2: " + cell5 + " Expected: " + e_cell5);
    if (cell5 != e_cell5) {
        UIALogger.logFail("Account Balance Checks Failed - Spending Cell 2  Incorrect");
        javascript_abort();
    }
    
    var cell6 = spendingTable.cells()[2].staticTexts()[1].name();
    
    UIALogger.logMessage("Spending 3: " + cell6 + " Expected: " + e_cell6);
    if (cell6 != e_cell6) {
        UIALogger.logFail("Account Balance Checks Failed - Spending Cell 3  Incorrect");
        javascript_abort();
    }
    
    var spent = target.frontMostApp().mainWindow().scrollViews()[0].staticTexts()[7].name();
    
    UIALogger.logMessage("Available: " + spent + " Expected: " + e_spent);
    if (spent != e_spent) {
        UIALogger.logFail("Account Balance Checks Failed - Total Spending Amount Incorrect");
        javascript_abort();
    }
    
    var available = target.frontMostApp().mainWindow().scrollViews()[0].staticTexts()[9].name();
    
    UIALogger.logMessage("Available: " + available + " Expected: " + e_available);
    if (available != e_available) {
        UIALogger.logFail("Account Balance Checks Failed - Available Amount Incorrect");
        javascript_abort();
    }
    
    return;
    
}
