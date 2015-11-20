/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
 *  A shared resource manager for obtaining "Watson" specific data from MobileFirst Platform
 */
public class WatsonDataManager: NSObject {
    /// Data received from MobileFirst Platform
    var data: [NSObject : AnyObject]!
    
    /// Callback used to send data upon completion
    var callback : (([NSObject: AnyObject])->())!
    
    /// Parameter to send containing Watson Problem
    var problemSentIn : [NSObject : AnyObject]!
    
    /// Returns a shared instance of WatsonDataManager
    public class var sharedInstance : WatsonDataManager {
        struct Singleton {
            static let instance = WatsonDataManager()
        }
        return Singleton.instance
    }
    
    /**
     This method is the callback to retry fetching Watson data upon failure
     */
    func retryCall(){
        fetchWatsonData(problemSentIn, callback: callback)
    }
    
    /**
     *  Retrieves the Watson tradeoff data directly from Watson service
     */
    public func fetchWatsonData(problem: [NSObject : AnyObject], callback: ([NSObject: AnyObject])->()) {
        self.problemSentIn = problem
        self.callback = callback
        
        //let externUrl = "https://gateway.watsonplatform.net/tradeoff-analytics/api/v1/dilemmas"
        let externUrl = "https://api.apim.ibmcloud.com/dennisschultzusibmcom-dev/sb/tradeoff-analytics/api/v1/dilemmas"
        let caller = WLProcedureCaller(externalResourceURL: externUrl, headers: [
            "Authorization" : "Basic YTQwMGY1ZDAtZjU5Zi00M2UyLWIzYjktMWQ4YTdlZDFjZTIxOnlsMm5XZktnRXRWcA==",
            "Content-Type"  : "application/json",
            "Accept"        : "application/json"])

        // Send problem as body text
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(problem, options: NSJSONWritingOptions(rawValue: 0))
            let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
            
            caller.invokeWithResponse(self, pathParam: nil, queryParams: nil, bodyText: jsonString as? String)

        } catch {
        }
        
    }
    
    /**
     This method gives the watson solution data back to
     */
    private func sendWatsonSolution(){
        callback(data) //give data to WatsonBestPlanViewController
        
    }
    
    
}

extension WatsonDataManager: WLDataDelegate {
    public func onSuccess(response : WLResponse!) {
        data = response.getResponseJson()
        sendWatsonSolution()
    }
    
    public func onFailure(response : WLFailResponse!) {
        MQALogger.log("Failure Response : \(response.responseText)")
        MILAlertViewManager.sharedInstance.show("Could not connect to the server, click to refresh", callback: retryCall)
    }
    
    public func onFailureError(error: NSError!) {
        MQALogger.log("Failure Response : \(error.description)")
        MILAlertViewManager.sharedInstance.show("Could not connect to the server, click to refresh", callback: retryCall)
    }
    
    func onPreExecute() {
        MILLoadViewManager.sharedInstance.show()
    }
    
    func onPostExecute() {
        // no implementation necessary
    }
}