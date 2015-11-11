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
    var problemSentIn : Array<AnyObject>!
    
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
     *  Retrieves the Watson tradeoff data from MobileFirst Platform based on problem given
     */
    public func fetchWatsonData(problem: Array<AnyObject>, callback: ([NSObject: AnyObject])->()) {
        self.problemSentIn = problem
        self.callback = callback
        let adapterName = "SBBJavaAdapter"
        let procedureName = "getTradeoffSolution"
        let caller = WLProcedureCaller(adapterName: adapterName, procedureName: procedureName)
        
        var params: [String: AnyObject]!
        params["dilemma"] = problem
        
        caller.invokeWithResponse(self, pathParam: nil, queryParams: params as! Dictionary<String,String>)
        
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