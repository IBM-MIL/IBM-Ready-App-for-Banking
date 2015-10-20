/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
*  A shared resource manager for obtaining Transactions for a specific account from MobileFirst Platform
*/
public class TransactionsDataManager: NSObject {
    // Callback function that will execute after the call returns
    var callback : ((Bool, [TransactionDay]!)->())!
    /// The id of the account the call is for
    var accountID: String!
    
    // Class variable that will return a singleton when requested
    public class var sharedInstance : TransactionsDataManager{
        
        struct Singleton {
            static let instance = TransactionsDataManager()
        }
        return Singleton.instance
    }
    
    /**
    Calls the MobileFirst Platform server and passes the accountID
    
    - parameter accountID: ID of the account to get the transactions for
    - parameter callback:  Callback to determine success
    */
    func getTransactions(accountID: String, callback: ((Bool, [TransactionDay]!)->())!){
        self.callback = callback
        self.accountID = accountID
        let adapterName : String = "SBBAdapter"
        let procedureName : String = "getTransactions"
        let caller = WLProcedureCaller(adapterName : adapterName, procedureName: procedureName)
        let params = [accountID]
        caller.invokeWithResponse(self, params: params)
    }
    
    /**
    Method that is fired when a retry is attempted for dashboard data.
    */
    func retryGetTransactions(){
        getTransactions(accountID, callback: callback)
    }
    
    /**
    Parses MobileFirst Platform's response and returns an array of transaction objects.
    
    - parameter worklightResponseJson: JSON response from MobileFirst Platform with Dashboard data.
    
    - returns: Array of account objects.
    */
    func parseTransactionsResponse(worklightResponseJson: NSDictionary) -> [TransactionDay]{
        
        let transactionJsonString = worklightResponseJson["result"] as! String
        let data = transactionJsonString.dataUsingEncoding(NSUTF8StringEncoding)
        let transactionJsonArray = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)))  as! [AnyObject]
        
        var transactionDays: [TransactionDay] = []
        var transactions: [Transaction] = []
        
        for transactionJson in transactionJsonArray as! [[String: AnyObject]]  {
            var transaction = Transaction()
            transaction.amount = fabsf(transactionJson["amount"] as! Float)
            transaction.title = transactionJson["to"] as! String
            transaction.date = NSDate(timeIntervalSince1970: (transactionJson["date"] as! NSTimeInterval)/1000)

            if  (transactionJson["transactionType"] as! String) == "deposit" {
                transaction.type = .Deposit
            }else{
                transaction.type = .Withdrawal
            }
            
            transactions.append(transaction)
        }
        
        transactions.sortInPlace(sorterForTransactionsDESC)
        
        for transaction in transactions {
            let dayTimePeriodFormatter = NSDateFormatter()
            dayTimePeriodFormatter.dateFormat = "EEEE M/d/y"
            
            let dateString = dayTimePeriodFormatter.stringFromDate(transaction.date)
            var transactionDay : TransactionDay
            
            if transactionDays.last == nil || transactionDays.last!.date != dateString {
                transactionDay = TransactionDay()
                transactionDay.date = dateString
                transactionDay.transactions = []
                transactionDay.transactions.append(transaction)
                transactionDays.append(transactionDay)
            }else if transactionDays.last!.date == dateString {
                transactionDay = transactionDays.last!
                transactionDay.transactions.append(transaction)
            }
            
        }
        
        return transactionDays
    }
    
    /**
    Sorter for the transactions to insure they are in decending order by date
    
    - parameter transaction1: First transaction
    - parameter transaction2: Second transaction
    
    - returns: <#return value description#>
    */
    func sorterForTransactionsDESC(transaction1:Transaction, transaction2:Transaction) -> Bool {
        return transaction1.date.isLaterThanDate(transaction2.date)
    }
}

extension TransactionsDataManager: WLDataDelegate {
    
    /**
    Delegate method for MobileFirst Platform. Called when connection and return is successful
    
    - parameter response: Response from MobileFirst Platform
    */
    public func onSuccess(response: WLResponse!) {
        let responseJson = response.getResponseJson() as NSDictionary
        
        // Parse JSON response into dashboard format and store in accounts
        let transactionDays = parseTransactionsResponse(responseJson)
        
        // Execute the callback from the view controller that instantiated the dashboard call
        callback(true, transactionDays)
    }
    
    /**
    Delegate method for MobileFirst Platform. Called when connection or return is unsuccessful
    
    - parameter response: Response from MobileFirst Platform
    */
    public func onFailure(response: WLFailResponse!) {
        MQALogger.log("Response: \(response.responseText)")
        
        if (response.errorCode.rawValue == 0) {
            MILAlertViewManager.sharedInstance.show("Can not connect to the server, click to refresh", callback: retryGetTransactions)
        }
        
        callback(false, nil)
        
    }
    
    
    /**
    Delegate method for MobileFirst Platform. Task to do before executing a call.
    */
    public func onPreExecute() {
    }
    
    /**
    Delegate method for MobileFirst Platform. Task to do after executing a call.
    */
    public func onPostExecute() {
    }

}
