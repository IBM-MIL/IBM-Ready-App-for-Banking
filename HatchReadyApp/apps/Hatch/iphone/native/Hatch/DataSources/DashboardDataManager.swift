/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


import Foundation

/**
*  A shared resource manager for obtaining Business and Accounts specific data from MobileFirst Platform
*/
public class DashboardDataManager: NSObject{
    
    // Callback function that will execute after the call returns
    var callback : ((Bool, [Business]!)->())!
    // Holds the business objects returned from MFP
    var businesses: [Business]!
    // Index to intiate the dashboard with
    var businessIndex = 0
    
    // Class variable that will return a singleton when requested
    public class var sharedInstance : DashboardDataManager{
        
        struct Singleton {
            static let instance = DashboardDataManager()
        }
        return Singleton.instance
    }
    
    /**
    Calls the MobileFirst Platform service
    
    - parameter callback:  Callback to determine success
    */
    func getDashboardData(callback: ((Bool, [Business]!)->())!){
        self.callback = callback
        let adapterName : String = "SBBAdapter"
        let procedureName : String = "getDashboardData"
        let caller = WLProcedureCaller(adapterName : adapterName, procedureName: procedureName)
        let params = []
        caller.invokeWithResponse(self, params: nil)
        var userExists = false
    }
    
    /**
    Method used for testing
    */
    public func getDashboardDataTest(){
        getDashboardData(nil)
    }
    
    /**
    Method that is fired when a retry is attempted for dashboard data.
    */
    func retryGetDashboardData(){
        getDashboardData(callback)
    }
    
    /**
    Parses MobileFirst Platform's response and returns an array of account objects.
    
    - parameter worklightResponseJson: JSON response from MobileFirst Platform with Dashboard data.
    
    - returns: Array of account objects.
    */
    func parseDashboardResponse(worklightResponseJson: NSDictionary) -> [Business]{
        
        let businessesJsonString = worklightResponseJson["result"] as! String
        let data = businessesJsonString.dataUsingEncoding(NSUTF8StringEncoding)
        let businessJsonArray = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)))  as! [AnyObject]
        
        var businesses: [Business] = []
        
        for businessJson in businessJsonArray as! [[String: AnyObject]]  {
            let business = Business()
            business.name = (businessJson["businessName"] as! String).uppercaseString
            business.imageName = businessJson["imageFile"] as! String
            
            var accounts : [Account] = []
            for accountJson in businessJson["accounts"] as! [[String: AnyObject]] {
                let account = Account()
                account.id = accountJson["_id"] as! String
                account.accountName = (accountJson["name"] as! String).uppercaseString
                account.accountType = AccountType.Account
                account.balance = accountJson["balance"] as! Float
                account.hasTransactions = (account.accountName == "CHECKING") || (account.accountName == "SAVINGS")
                accounts.append(account)
            }
            
            business.accounts = accounts
            
            var spendings : [Account] = []
            
            for spendingJson in businessJson["spending"] as! [[String: AnyObject]] {
                let spending = Account()
                spending.id = spendingJson["_id"] as! String
                spending.accountName = (spendingJson["name"] as! String).uppercaseString
                spending.accountType = AccountType.Spending
                spending.balance = spendingJson["balance"] as! Float
                
                spendings.append(spending)
            }
            
            business.spendings = spendings
            
            businesses.append(business)
        }
        
        return businesses
    }
}

extension DashboardDataManager: WLDataDelegate{
    
    /**
    Delegate method for MobileFirst Platform. Called when connection and return is successful
    
    - parameter response: Response from MobileFirst Platform
    */
    public func onSuccess(response: WLResponse!) {
        let responseJson = response.getResponseJson() as NSDictionary
        
        // Parse JSON response into dashboard format and store in accounts
        businesses = parseDashboardResponse(responseJson)
        
        
        
        // Execute the callback from the view controller that instantiated the dashboard call
        callback(true, businesses)
    }
    
    /**
    Delegate method for MobileFirst Platform. Called when connection or return is unsuccessful
    
    - parameter response: Response from MobileFirst Platform
    */
    public func onFailure(response: WLFailResponse!) {
        MQALogger.log("Response: \(response.responseText)")

        if (response.errorCode.rawValue == 0) {
            MILAlertViewManager.sharedInstance.show("Can not connect to the server, click to refresh", callback: retryGetDashboardData)
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