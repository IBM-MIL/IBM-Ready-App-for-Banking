/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation
/**
*  A shared resource manager for obtaining "Offers" specific data from MobileFirst Platform
*  and injecting into the hybrid component.
*/
public class OffersDataManager: NSObject {
    /// Data received from MobileFirst Platform
    var data: [NSObject : AnyObject]!
    
    /// Callback used to send data back to WatsonBestPlanViewController
    var callback : (([NSObject: AnyObject])->())!
    
    /// Returns a shared instance of OffersDataManager
    public class var sharedInstance : OffersDataManager {
        struct Singleton {
            static let instance = OffersDataManager()
        }
        return Singleton.instance
    }
    
    /**
    This method is the callback to retry fetching offer data upon failure
    */
    func retryCall(){
        fetchOffersData(callback)
    }
    
    
    /**
    *  Retrieves the offers data from MobileFirst Platform, caches it for future invocations
    */
    public func fetchOffersData(callback: ([NSObject: AnyObject])->()) {
        self.callback = callback
            let adapterName = "SBBAdapter"
            let procedureName = "getOffers"
            let caller = WLProcedureCaller(adapterName: adapterName, procedureName: procedureName)
            caller.invokeWithResponse(self, params: nil)
    }
    
    /**
    This method will give the offer data back to WatsonBestPlanViewController
    */
    private func sendOffersData() {
            callback(data) //give data to WatsonBestPlanViewController
        WL.sharedInstance().sendActionToJS("offersSetup", withData: data)
    }
}

extension OffersDataManager: WLDataDelegate {
    public func onSuccess(response : WLResponse!) {
        
        data = response.getResponseJson()
        if data != nil {
            let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
            appDelegate.sendDeviceLanguageToHybrid()
            
            sendOffersData()
        }
    }
    
    public func onFailure(response : WLFailResponse!) {
//        MQALogger.log("Response \(response.responseText)")
        MILAlertViewManager.sharedInstance.show("Could not connect to the server, click to refresh", callback: retryCall)
    }
    
    func onPreExecute() {
        MILLoadViewManager.sharedInstance.show()
    }
    
    func onPostExecute() {
        // no implementation necessary
    }
}