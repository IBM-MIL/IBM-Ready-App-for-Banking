/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit
@UIApplicationMain

/**
*  Entry point for the application.
*/
class AppDelegate: WLAppDelegate {
    var hybridViewController: HybridViewController!
    private var actionReceiver: WLActionReceiver!
    
     override func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            WL.sharedInstance().initializeWebFrameworkWithDelegate(self)
            
            let configManager = ConfigManager.sharedInstance
            if !configManager.isDevelopment {
                
                //enabling MQA in Market Mode
                MQALogger.settings().mode = MQAMode.Market
                
                // Starts a quality assurance session using a dummy key and QA mode
                MQALogger.startNewSessionWithApplicationKey(configManager.mqaApplicationKey)
                
                // Enables the quality assurance application crash reporting
                NSSetUncaughtExceptionHandler(exceptionHandlerPointer)
                
             
            }
        
            OCLogger.setLevel(OCLogger_FATAL)
            
            return true
    }
    
     override func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
     override func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restorwe your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    override func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    override func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    override func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /**
    Invokes the MobileFirst Platform logout procedure and shows the Hatch loading screen.
    */
    func logout(){
        
        // Invoke MobileFirst Platform logout procedure
        let configManager = ConfigManager.sharedInstance
        WLClient.sharedInstance().logout(configManager.hatchRealm, withDelegate: ReadyAppsLogoutListener())

    }
    /**
    Sends language that is currently set on device to the hybrid side.
    */
    func sendDeviceLanguageToHybrid(){
        var userDataDictionary : [NSObject:AnyObject] = [:]
        userDataDictionary["language"] = NSLocale.currentLocale().objectForKey(NSLocaleIdentifier)
        userDataDictionary["locale"] = LoginDataManager.sharedInstance.currentUser.locale
        
        let userData = ["userData" : userDataDictionary]
    
        MQALogger.log("locale json data: \(userData)")
        WL.sharedInstance().sendActionToJS("setLocale", withData: userData)
    }
    
    /**
    Sets the specified WLActionReceiver to receive actions from the hybrid component. Any WLActionReceivers that were passed to addActionReceiver() previously will be removed before adding the new one. This method should always be called in favor of calling WL.sharedInstance().addActionReceiver() directly.
    
    :param: wlActionReceiver The action receiver that will receive actions from the hybrid component.
    */
    func addActionReceiver(wlActionReceiver: WLActionReceiver) {
        if actionReceiver != nil {
            WL.sharedInstance().removeActionReceiver(actionReceiver)
        }
        WL.sharedInstance().addActionReceiver(wlActionReceiver)
        actionReceiver = wlActionReceiver
    }
}

extension AppDelegate : WLInitWebFrameworkDelegate {
    func wlInitWebFrameworkDidCompleteWithResult(result: WLWebFrameworkInitResult) {
        if result.statusCode.value == WLWebFrameworkInitResultSuccess.value {
            self.wlInitDidCompleteSuccessfully()
        } else {
            self.wlInitDidFail(result)
        }
    }
    
    private func wlInitDidCompleteSuccessfully() {
        LoginDataManager.sharedInstance
        self.hybridViewController = HybridViewController(coder: NSCoder.empty())
        
        // proceed to initial storyboard
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController() as? UIViewController
        self.window?.makeKeyAndVisible()
    }
    
    private func wlInitDidFail(result: WLWebFrameworkInitResult) {
        let alertView = UIAlertView(title: "MobileFirst Platform Init Error", message: result.message, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }

}

