/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2014, 2015. All Rights Reserved.

*/

import Foundation
import UIKit

/**
This class handles the success/failures relating to the user logout
*/
class ReadyAppsLogoutListener : NSObject, WLDelegate {
    
    /**
    Handles the logout user success scenario
    */
    func onSuccess(response: WLResponse!) {
    
        MQALogger.log("onSuccess in LogoutListener")
        MQALogger.log("Successfully logged out of MobileFirst Server. Response: \(response)");
        
        // Clear keychain if touchID is not being used
        let configManager = ConfigManager.sharedInstance
        
        if (!configManager.useTouchID()){
            KeychainWrapper.removeObjectForKey(configManager.UsernameKey)
            KeychainWrapper.removeObjectForKey(configManager.PasswordKey)
        }
        
        // Changing storyboard to dashboard to get back to the "root" of the application
        // The backend call in the DashboardVC will trigger the login page
        let dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let viewController = dashboardStoryboard.instantiateInitialViewController()
        UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
        
        // Hide loading screen
        MILLoadViewManager.sharedInstance.hide()

    }
    
    /**
    Handles the logout user failure scenario
    */
    func onFailure(response: WLFailResponse!) {
        MQALogger.log("onFailure in LogoutListener")
        MQALogger.log("Failed logging out of MobileFirst Server. Response: \(response)");
        
        MILAlertViewManager.sharedInstance.show("Something went wrong, click to try again.",
            callback: {
                let configManager = ConfigManager.sharedInstance
                WLClient.sharedInstance().logout(configManager.hatchRealm, withDelegate: ReadyAppsLogoutListener()) })
    }
    
    func onPreExecute(){
        
    }
}