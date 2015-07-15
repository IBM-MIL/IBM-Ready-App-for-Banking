/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2014, 2015. All Rights Reserved.

*/

import Foundation
import UIKit

/**
This class interacts with the MobileFirst Server to authenticate the user upon login. If the user has been timed out,
it will present the user with the login view controller, so they can login.
*/
public class ReadyAppsChallengeHandler : ChallengeHandler {
    
    public var loginViewController : LoginViewController!
    
    override init(){
        
        let configManager = ConfigManager.sharedInstance
        super.init(realm: configManager.hatchRealm)

    }
    
    /**
    Callback method for MobileFirst platform authenticator which determines if the user has been timed out.
    :param: response
    */
    override public func isCustomResponse(response: WLResponse!) -> Bool {
        MQALogger.log("--------- isCustomResponse in readyapps------")
        //check for bad token here
        if (response != nil && response.getResponseJson() != nil) {
            var jsonResponse = response.getResponseJson() as NSDictionary
            var authRequired = jsonResponse.objectForKey("authRequired") as! Bool?
            if authRequired != nil {
                return authRequired!
            }
        }
        return false
    }
    
    /**
    Callback method for MobileFirst platform which handles the success scenario
    :param: response
    */
    override public func onSuccess(response: WLResponse!) {
        MQALogger.log("challenge handler on onSuccess")
        submitSuccess(response)
        
        let responseJson = response.getResponseJson() as NSDictionary
        LoginDataManager.sharedInstance.parseLoginResponse(responseJson)
        
        loginViewController.setKeychainCredentials()
        loginViewController.dismissViewControllerAnimated(true, completion: nil)
        loginViewController = nil
        
    }
    
    /**
    Callback method for MobileFirst platform which handles the failure scenario
    :param: response
    */
    override public func onFailure(response: WLFailResponse!) {
        MQALogger.log("on ReadyAppsChallengeHandler onFailure");
        MQALogger.log("Response: \(response)")
        submitFailure(response)
        
        // Reenable login and show error on failure
        loginViewController.logInButton.enabled = true
        loginViewController.displayLoginError(NSLocalizedString("INVALID USERNAME OR PASSWORD", comment: "Invalid username or password error message in login"))
        
        MILAlertViewManager.sharedInstance.hide()
        
    }
    
    /**
    Callback method for MobileFirst platform which handles challenge presented by the server, It shows the login view controllers, so the user
    can re-authenticate.
    :param: response
    */
    override public func handleChallenge(response: WLResponse!) {
        if loginViewController == nil {
            MQALogger.log("show login view controller")
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            loginViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            
            // Present login view controller
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            let nav = root?.navigationController
            root?.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            root?.presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
}

