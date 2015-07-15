/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit
import Foundation
import LocalAuthentication

/**
*  Singleton class that is used to hold configuration information
*/
public class ConfigManager: NSObject {
    /// MQA Application Key
    var mqaApplicationKey: String!
    /// Password Key for keychain
    let PasswordKey = "password"
    /// Username Key for keychain
    let UsernameKey = "username"
    /// TouchID Key for NSUserDefaults
    let touchIDKey = "touchIDBool"
    /// The Kern Value for all the text in the app
    let KernValue : CGFloat = 3.0
    /// Says if the app is in development to hide some features
    var isDevelopment = true
    /// Realm that is used for MobileFirst Platform calls
    var hatchRealm: String!
    /// Username to be used in demo mode
    var demoUsername: String!
    /// Password to be used in demo mode
    var demoPassword: String!
    
    public class var sharedInstance : ConfigManager{
        
        struct Singleton {
            static let instance = ConfigManager()
        }
        return Singleton.instance
    }
    
    override init(){
        super.init()
        // Read configurations from the Config.plist.
        var configurationPath = NSBundle.mainBundle().pathForResource("Config", ofType: "plist")
        
        var hasValidConfiguration = true
        var errorMessage = ""
        
        if((configurationPath) != nil){
            var configuration = NSDictionary(contentsOfFile: configurationPath!) as! [String: AnyObject]!
            
            isDevelopment = configuration["isDevelopment"] as! Bool
            if(configuration["isDevelopment"] == nil){
                hasValidConfiguration = false
                errorMessage = "Open the Config.plist file and set the isDevelopment boolean"
            }
            
            mqaApplicationKey = configuration["mqaApplicationKey"] as! String
            if(mqaApplicationKey == nil){
                hasValidConfiguration = false
                errorMessage = "Open the Config.plist file and set the mqaApplicationKey to the MQA application key"
            }
            
            hatchRealm = configuration["hatchRealm"] as! String
            if (hatchRealm == nil){
                hasValidConfiguration = false
                errorMessage = "Open the Conflig.plist file and set the hatchRealm"
            }

            demoUsername = configuration["demoUsername"] as! String
            if (demoUsername == nil){
                hasValidConfiguration = false
                errorMessage = "Open the Conflig.plist file and set the demoUsername"
            }
            
            demoPassword = configuration["demoPassword"] as! String
            if (demoPassword == nil){
                hasValidConfiguration = false
                errorMessage = "Open the Conflig.plist file and set the demoPassword"
            }
        }
        
        if(!hasValidConfiguration){
            NSException().raise()
        }
        
    }
    
    /**
    This method determines if TouchID should be used by examining the Keychain and touchID value in NSUserDefaults.
    
    :returns:
    */
    func useTouchID()->Bool{
        
        // Only enable touchID if enabled in user defaults and username/password are in the keychain
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if (userDefaults.objectForKey(touchIDKey) == nil){
            userDefaults.setObject(false, forKey: touchIDKey)
            userDefaults.synchronize()
        }
        let touchIDUserDefaultValue: Bool = userDefaults.objectForKey(touchIDKey)!.boolValue!
        
        let useTouchID: Bool = KeychainWrapper.hasValueForKey(UsernameKey)
            && KeychainWrapper.hasValueForKey(PasswordKey)
            && touchIDUserDefaultValue
        
        return useTouchID
    }
    
    /**
    This method returns true if a device has TouchID ability.
    
    :returns:
    */
    func deviceHasTouchIDAbility()->Bool{
        
        // Get the local authentication context:
        var context = LAContext()
        var error : NSError?
        
        // Test if TouchID fingerprint authentication is available on the device and a fingerprint has been enrolled.
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&error) {
            return true
        } else {
            return false
        }
    }
}
