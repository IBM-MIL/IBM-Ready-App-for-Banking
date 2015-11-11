/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
 *  Retrieves the feasibility for a user's goal from MobileFirst Platform. The data returned is then passed along to the hybrid view via the "receiveFeasibility" action. Make sure the data property is set before calling retrieveFeasibility(), otherwise the call is silent.
 */
public class FeasibilityDataManager: NSObject {
    /// Contains a mapping of the goal being checked for feasiblity as well as an array of all the other user's goals. Set this property before calling retrieveFeasibility().
    var data: [NSObject : AnyObject]!
    
    // Returns a shared instance (singleton) of the FeasibilityDataManager. All operations in the FeasibilityDataManager should be done via the sharedInstance property.
    public class var sharedInstance: FeasibilityDataManager {
        struct Singleton {
            static let instance = FeasibilityDataManager()
        }
        return Singleton.instance
    }
    
    /**
     Retrieves the feasibility data for a goal. This assumes the data property was set previously. The retrieved data is then sent to the hybvrid view via the "receiveFeasibility" action.
     */
    public func retrieveFeasibility() {
        if data != nil {
            let newGoal = data["newGoal"] as! [NSObject : AnyObject]
            let existingGoals = data["goalList"] as! [[NSObject : AnyObject]]
            
            let goal = GoalsDataManager.sharedInstance.goals[0]
            let userId = goal.ownerId
            let businessId = goal.businessID
            
            // Send userId and businessId as query parameters
            var queryParams: [String: String] = [:]
            queryParams["userId"]        = userId!
            queryParams["businessId"]    = businessId!
            
            // Send complex data (goals) as form parameters
            var formParams: [String: AnyObject] = [:]
            formParams["newGoal"]       = newGoal
            formParams["existingGoals"] = existingGoals
            
            let procedureCaller = WLProcedureCaller(adapterName: "SBBJavaAdapter", procedureName: "getFeasibility")
            procedureCaller.invokeWithResponse(self, pathParam: nil, queryParams: queryParams, formParams: formParams)
        }
    }
}

extension FeasibilityDataManager: WLDataDelegate {
    public func onSuccess(response: WLResponse!) {
        NavViewController.isLoadingScreenTransition = true
        WL.sharedInstance().sendActionToJS("receiveFeasibility", withData: response.getResponseJson())
        MILLoadViewManager.sharedInstance.hide()
    }
    
    public func onFailure(response: WLFailResponse!) {
        MQALogger.log("CheckfeasibilityDelegate error: \(response.errorMsg)")
        MILAlertViewManager.sharedInstance.show("Could not connect to the server, click to refresh", callback: retrieveFeasibility)
    }
    
    public func onFailureError(error: NSError!) {
        MQALogger.log("CheckfeasibilityDelegate error: \(error.description)")
        MILAlertViewManager.sharedInstance.show("Could not connect to the server, click to refresh", callback: retrieveFeasibility)
    }
    
    func onPreExecute() {
        MILLoadViewManager.sharedInstance.show()
    }
    
    func onPostExecute() {
        // no implementation necessary
    }
}
