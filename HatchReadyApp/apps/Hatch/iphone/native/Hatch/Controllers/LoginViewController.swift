/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


import UIKit
import LocalAuthentication
import QuartzCore

/**
*  Custom UIViewController for Login page.
*/
public class LoginViewController: UIViewController, UITextFieldDelegate{
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Text field for username
    @IBOutlet var usernameTextField : UITextField!
    /// Text field for password
    @IBOutlet var passwordTextField : UITextField!
    /// Button that triggers login MobileFirst Platform flow
    @IBOutlet var logInButton : UIButton!
    /// Placeholder button that is hooked up to a method but is currently not implemented
    @IBOutlet var forgotPasswordButton : UIButton!
    
    /// View that animates with an error related to login
    @IBOutlet var loginErrorView : UIView!
    /// Label that contains the error text in the loginErrorView
    @IBOutlet var loginErrorMessageLabel : UILabel!
    /// View that encases the username and password text fields
    @IBOutlet var usernamePasswordView : UIView!
    
    let configManager = ConfigManager.sharedInstance
    let loginManager = LoginDataManager.sharedInstance
    
    var loginErrorViewShown = false     // Indicates if loginErrorView is currently displayed
    var keyboardHeight: CGFloat!        // Keyboard height for adjusting screen views when keyboard shows and hides
    
    /**
    Method sets up delegates and actions for UIElements on the screen.
    */
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if usernameTextField != nil{
            usernameTextField.delegate = self
            usernameTextField.returnKeyType = UIReturnKeyType.Next
            usernameTextField.spellCheckingType = UITextSpellCheckingType.No
            usernameTextField.autocorrectionType = .No
            usernameTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: .EditingChanged)
        }
        
        if passwordTextField != nil{
            passwordTextField.delegate = self
            passwordTextField.returnKeyType = UIReturnKeyType.Go
            passwordTextField.secureTextEntry = true
            passwordTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: .EditingChanged)
        }
        
        if logInButton != nil{
            logInButton.addTarget(self, action: "logInButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        if forgotPasswordButton != nil{
            forgotPasswordButton.addTarget(self, action: "forgotPasswordButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    /**
    Method sets up keyboard observers and presents touchID if it is viable.
    
    - parameter animated:
    */
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpLoginView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        if (configManager.useTouchID()) {
            touchID()
        }else{
            // Allow user to opt into demo mode to bypass login
            self.showDemoPopup()
        }
        
        
    }
    
    /**
    Method removes all NSNotificationCenter observers before view disappears.
    
    - parameter animated:
    */
    override public func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        super.viewWillDisappear(animated)
    }
    
    /**
    This function adjusts the view when the keyboard is shown to allow the user to view the entire bottom of the screen whilst typing. This is called when the keyboard is shown.
    
    - parameter notification: NSNotification sent when keyboard is shown, has information about the keyboard's size.
    */
    func keyboardWillShow(notification: NSNotification){

        // Get size of keyboard, through the notification
        let keyboardInfo: AnyObject? = notification.userInfo![UIKeyboardFrameEndUserInfoKey]
        let keyboardFrame = keyboardInfo?.CGRectValue
        
        // Set the size of the keyboard so when it dismisses so the view can go to the appropriate location
        self.keyboardHeight = keyboardFrame!.height
        
        // Adjust the view's frame
        let newKeyboardPosition = self.view.origin.y - keyboardHeight
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y -= keyboardHeight
        
        self.view.frame = viewFrame

    }
    
    /**
    This function adjusts the view back to its initial position, when the keyboard is dismissed. This is triggered when the keyboard is dismissed.
    
    - parameter notification: NSNotification sent when keyboard is shown, has information about the keyboard's size.
    */
    func keyboardWillHide(notification: NSNotification){
        
        // Adjust the view's frame
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y += keyboardHeight
        
        self.view.frame = viewFrame
    }
    
    /**
    Dismisses keyboard on touch outside of text fields.
    
    - parameter touches:
    - parameter event:
    */
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = event!.allTouches()?.first
        
        if !(touch?.view is UITextField){
            view.endEditing(true)
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    /**
    Handles the return key being pressed when the username or password UITextFields are active.
    
    - parameter textField: The current text UITextField
    
    - returns: bool that indicates the UITextField should return
    */
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField?.becomeFirstResponder()
            usernameTextField?.resignFirstResponder()

            return true
        } else {
            textField.resignFirstResponder()
            logInButtonPressed(logInButton)
            return true
        }
    }
    
    /**
    Enables login upon validation of username and password text fields. Disables if doesn't pass check.
    
    - parameter sender:
    */
    func textFieldDidChange(sender: UITextField) {
        if (!usernameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty){
            logInButton.enabled = true
        } else {
            logInButton.enabled = false
        }
    }
    
    /**
    Enables quick login for demonstrations.
    
    - parameter sender:
    */
    func showDemoPopup(){
        
        let alertController = UIAlertController(title: nil,
            message: NSLocalizedString("Would you like to use \"Hatch\" in demo mode?", comment: ""),
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let noAction = UIAlertAction(title: NSLocalizedString("No", comment: ""),
            style: UIAlertActionStyle.Cancel){
            (action) in
            MQALogger.log("User opted out of demo mode")}

        let yesAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""),
            style: UIAlertActionStyle.Default){
            (action) in
            
            MQALogger.log("User opted into demo mode")
            
            let configManager = ConfigManager.sharedInstance
            
            self.usernameTextField.text = configManager.demoUsername
            self.passwordTextField.text = configManager.demoPassword
            self.logInButtonPressed(nil)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    /**
    Submits authentication to login manager.
    
    - parameter sender:
    */
    @IBAction private func logInButtonPressed(sender: AnyObject!) {
        
        view.endEditing(true)
        self.logInButton.enabled = false
        
        let usernameString = usernameTextField.text
        let passwordString = passwordTextField.text

        MILLoadViewManager.sharedInstance.show()
 
        loginManager.submitAuthentication(usernameString, password: passwordString)
        

        
    }
    
    /**
    Saves the username and password in keychain
    */
    func setKeychainCredentials(){
        
        let usernameString = usernameTextField.text!
        let passwordString = passwordTextField.text!

        // Turn off Touch ID if username or password are not the same in keychain. Use case: Every time a new user logs in, they must elect to use Touch ID.
        if let keychainUsername: String? = KeychainWrapper.stringForKey(self.configManager.UsernameKey){
            if let keychainPassword: String? = KeychainWrapper.stringForKey(self.configManager.PasswordKey){
                
                if (keychainUsername != usernameString) || (keychainPassword != passwordString){
                    
                    NSUserDefaults.standardUserDefaults().setObject(false, forKey: ConfigManager.sharedInstance.touchIDKey)
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            }
        }

        KeychainWrapper.setString(usernameString, forKey: self.configManager.UsernameKey)
        KeychainWrapper.setString(passwordString, forKey: self.configManager.PasswordKey)
    }
    
    /**
    Animates loginErrorView in and out of view, depending on visibility setting.
    
    - parameter isVisible: bool that determines if loginErrorView should or should not be visible
    */
    func errorViewSetVisible(isVisible: Bool){
        
        let directionMultiplier: CGFloat = isVisible ? -1.0 : 1.0 // Determines direction of animation
        
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .CurveEaseIn,
            animations: {
                var updatedLoginErrorViewFrame = self.loginErrorView.frame
                
                updatedLoginErrorViewFrame.origin.y += (updatedLoginErrorViewFrame.size.height * directionMultiplier)
                self.loginErrorView.frame = updatedLoginErrorViewFrame
            },
            completion: {
                finished in
                self.loginErrorViewShown = isVisible
        })
        
    }
    
    /**
    Skeleton function for forgotPasswordButtonPressed. This functionality ended up being out of scope for our project, but exists for future use.
    
    - parameter sender:
    */
    @IBAction private func forgotPasswordButtonPressed(sender: AnyObject) {
         MQALogger.log("Forgot Password Fired")
    }
    
    /**
    Displays a login error message to the user
    
    - parameter errorMessage: error message to be displayed to user
    */
    func displayLoginError(errorMessage: String){
        
        loginErrorMessageLabel.text = errorMessage
        loginErrorMessageLabel.setKernAttribute(configManager.KernValue)
        loginErrorView.hidden = false
        
        if (!loginErrorViewShown) { errorViewSetVisible(true) }
    }
    
    /**
    Sets up UI elements in the login view.
    */
    func setUpLoginView(){
        
        // Set up letter spacing
        let textFieldKernAttributes : Dictionary = [NSKernAttributeName: configManager.KernValue,
            NSForegroundColorAttributeName: UIColor.lightGrayTextHatch()]
        
        let usernameAttributedString = NSAttributedString(string: usernameTextField.placeholder!, attributes: textFieldKernAttributes)
        let passwordAttributedString = NSAttributedString(string: passwordTextField.placeholder!, attributes:textFieldKernAttributes)
        
        usernameTextField.attributedPlaceholder = usernameAttributedString
        passwordTextField.attributedPlaceholder = passwordAttributedString
        forgotPasswordButton.setKernAttribute(configManager.KernValue)
        
        // Hide error view
        loginErrorView.hidden = true
        
    }
    
    /**
    Processes what to do if touch ID is enabled and called. This handles if the touch id succeeds, fails, or is not enabled on the device.
    */
    func touchID(){
        // Get the local authentication context:
        let context = LAContext()
        var error: NSError?
        
        // Test if TouchID fingerprint authentication is available on the device and a fingerprint has been enrolled.
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
        
            // evaluate
            let reason = NSLocalizedString("Authenticate to login", comment: "Touch ID authentication message")
            
            context.localizedFallbackTitle = ""
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {
                (success: Bool, authenticationError: NSError?) -> Void in
                
                // check whether evaluation of fingerprint was successful
                if success {
                    // fingerprint validation was successful
                    MQALogger.log("Fingerprint validated.")
                    if let username: String? = KeychainWrapper.stringForKey(self.configManager.UsernameKey){
                        if let password: String? = KeychainWrapper.stringForKey(self.configManager.PasswordKey){
                            MQALogger.log("Username: " + username!)
                            MQALogger.log("Password: " + password!)
                            dispatch_async(dispatch_get_main_queue(), {
                                self.usernameTextField.text = username
                                self.passwordTextField.text = password
                                self.logInButtonPressed(self.logInButton)
                            })
                        }
                        
                    }
                } else {
                    // fingerprint validation failed
                    // get the reason for validation failure
                    var failureReason = "unable to authenticate user"
                    switch authenticationError!.code {
                    case LAError.AuthenticationFailed.rawValue:
                        failureReason = "authentication failed"
                    case LAError.UserCancel.rawValue:
                        failureReason = "user canceled authentication"
                    case LAError.UserFallback.rawValue:
                        failureReason = "user chose password"
                    case LAError.SystemCancel.rawValue:
                        failureReason = "system canceled authentication"
                    case LAError.PasscodeNotSet.rawValue:
                        failureReason = "passcode not set"
                    default:
                        failureReason = "unable to authenticate user"
                    }
                    
                    MQALogger.log("Fingerprint validation failed: \(failureReason).");
                }
            })
        } else {
            //get more information
            var reason = "Local Authentication not available"
            switch error!.code {
            case LAError.TouchIDNotAvailable.rawValue:
                reason = "Touch ID not available on device"
            case LAError.TouchIDNotEnrolled.rawValue:
                reason = "Touch ID is not enrolled yet"
            case LAError.PasscodeNotSet.rawValue:
                reason = "Passcode not set"
            default: reason = "Authentication not available"
            }
            
            MQALogger.log("Error: Touch ID fingerprint authentication is not available: \(reason)");
        }
    }
}

