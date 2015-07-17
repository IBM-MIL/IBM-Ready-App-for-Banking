/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
*  A shared resource manager for obtaining "Goals" specific data from MobileFirst Platform
*  and injecting into the hybrid component.
*/
public class GoalsDataManager: NSObject {
    ///  The goal data that is set after a successful call to fetchGoalsData()
    var goals: [Goal]!
    
    /// Returns a shared instance of GoalsDataManager
    public class var sharedInstance : GoalsDataManager {
        struct Singleton {
            static let instance = GoalsDataManager()
        }
        return Singleton.instance
    }
    
    /**
    *  Retrieves the goals data from MobileFirst Platform, caches it for future invocations
    *  and then injects it into the hybrid component.
    */
    public func fetchGoalsData() {
            let adapterName = "SBBAdapter"
            let procedureName = "getGoals"
            let caller = WLProcedureCaller(adapterName: adapterName, procedureName: procedureName)
            caller.invokeWithResponse(self, params: nil)
    }
    
    private func sendGoalsData() {
        let jsonData = Goal.convertGoalsArrayToDictionary(goals)
        WL.sharedInstance().sendActionToJS("initialSetup", withData: jsonData)
    }
    
}

extension GoalsDataManager: WLDataDelegate {
    public func onSuccess(response : WLResponse!) {
        goals = Goal.parseJsonArray(response.getResponseJson())

        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        appDelegate.sendDeviceLanguageToHybrid()
        
        sendGoalsData()
        
    }
    
    public func onFailure(response : WLFailResponse!) {
        MQALogger.log("Response \(response.responseText)")
        MILAlertViewManager.sharedInstance.show("Could not connect to the server, click to refresh", callback: fetchGoalsData)
    }
    
    func onPreExecute() {
        MILLoadViewManager.sharedInstance.show()
    }
    
    func onPostExecute() {
        // no implementation necessary
    }
}