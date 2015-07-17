/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
*  A shared resource manager for validating a log in and obtaining the user specific data from MobileFirst Platform
*/
public class LoginDataManager: NSObject{
    public var challengeHandler: ReadyAppsChallengeHandler!

    // User data from MobileFirst Platform
    var currentUser : CurrentUser!
    
    typealias LogInCallback = (Bool, WLFailResponse!, WLResponse!)->Void
    var logInCallback: LogInCallback!
    
    //Class variable that will return a singleton when requested
    public class var sharedInstance : LoginDataManager{
        
        struct Singleton {
            static let instance = LoginDataManager()
        }
        return Singleton.instance
    }
    
    override init() {
        challengeHandler = ReadyAppsChallengeHandler()
        WLClient.sharedInstance().registerChallengeHandler(challengeHandler)
    }

    /**
    Submits authentication to MobileFirst Platform service with provided username and password.
    
    :param: username
    :param: password
    */
    public func submitAuthentication(username: String!, password: String!){

        let adapterName : String = "SBBAdapter"
        let procedureName : String = "submitAuthentication"
        let caller = WLProcedureInvocationData(adapterName : adapterName, procedureName: procedureName)
        caller.parameters = [username, password]
        let locale = NSLocale.currentLocale().localeIdentifier
        self.challengeHandler.submitAdapterAuthentication(caller, options: nil)
        
        
    }
    
    /**
    Parses MobileFirst Platform's login response and creates and fills out a current user.
    
    :param: worklightResponseJson JSON Response from MobileFirst Platform
    */
    func parseLoginResponse(worklightResponseJson: NSDictionary){
        
        MQALogger.log("---------parseLoginResponse-------------")
        MQALogger.log("MobileFirst Platform response json:\(worklightResponseJson)")
        
        var error: NSError?
        
        var jsonResult = worklightResponseJson["result"] as! NSDictionary
        currentUser = CurrentUser()
        
        currentUser.id          = jsonResult["_id"] as! String!
        currentUser.firstName   = jsonResult["firstName"] as! String!
        currentUser.lastName    = jsonResult["lastName"] as! String!
        currentUser.locale      = jsonResult["locale"] as! String!
        currentUser.username    = jsonResult["username"] as! String!
      
    }
    
}
