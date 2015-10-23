/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UINavigationController for the navigation
*/
class NavViewController: UINavigationController, WLActionReceiver {
    private struct StaticStruct { static var isLoadingScreenTransition = false }
    
    /// Lets NavViewController know whether to animate the transition on the next page change. It will automatically reset this property to false when the next page change does occur.
    class var isLoadingScreenTransition: Bool {
        get { return StaticStruct.isLoadingScreenTransition }
        set { StaticStruct.isLoadingScreenTransition = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.addActionReceiver(self)
    }
    
    /**
    Called when the menu button is tapped. Shows the menu from the top via a custom animation.
    
    - parameter sender: The button calling this function
    */
    @IBAction func menuButtonTapped(sender: AnyObject!){
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        menuViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        menuViewController.transitioningDelegate = self
        
        self.presentViewController(menuViewController, animated: (sender != nil), completion: nil)
    }
    
    /**
    Called when the back button is tapped in the header (returns to initial goals screen)
    
    - parameter sender: the back button itself
    */
    @IBAction func backButtonTapped(sender: UIButton) {
        // self.popToRootViewControllerAnimated(true)
        self.popViewControllerAnimated(true)
        WL.sharedInstance().sendActionToJS("backButtonClicked")
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    /**
    Callback that is triggered when an action is receieved from the hybrid component. Acts as a direct line of communication from the hybrid component to the native component.
    
    - parameter action: the native action to perform
    - parameter data:   any data that is associated with the specified actionsd
    */
    func onActionReceived(action: String!, withData data: [NSObject : AnyObject]!) {
        MQALogger.log("onActionReceived invoked!")
        MQALogger.log("action: \(action)")
        MQALogger.log("data: \(data)")
        
        var selector: () -> ()
        
        switch action {
        case "updatePage":
            selector = { self.updatePage(data) }
        case "deleteGoal":
            selector = { self.deleteGoal(data) }
        case "checkFeasibility":
            selector = { self.checkFeasibility(data) }
        case "updatedPriorities":
            selector = { self.updatedPriorities(data) }
        case "pressBackButton":
            selector = { self.backButtonTapped(UIButton()) }
        case "exitHybrid":
            selector = { self.navigateToDashboard() }
        default:
            selector = { MQALogger.log("invalid action") }
        }
        
        dispatch_async(dispatch_get_main_queue(), selector)
        
    }
    
    private func navigateToDashboard() {
        MenuViewController.goToDashboard()
    }
    
    private func updatePage(data: [NSObject : AnyObject]!){
        let route = data["route"] as! String!
        let title = data["title"] as! String!
        let showBackButton = data["showBackButton"] as! Bool!
        let headerColor = data["headerColor"] as! String!
        
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: title)
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
        var routeDictionary : [NSObject : AnyObject]! = [:]
        routeDictionary["route"] = route
        
        self.changePage(title, showBackButton: showBackButton, headerColor: headerColor)
    }
    
    private func changePage(title: String, showBackButton: Bool, headerColor: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if !appDelegate.hybridViewController.isFirstInstance {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nativeViewController = storyboard.instantiateViewControllerWithIdentifier("NativeViewController") as! NativeViewController
            
            nativeViewController.showBackButton = showBackButton
            nativeViewController.headerTitle = title.uppercaseString
            nativeViewController.headerColor = headerColor
            
            let showAnimation = !NavViewController.isLoadingScreenTransition
            NavViewController.isLoadingScreenTransition = false // reset value for subsequent pages
            
            self.pushViewController(nativeViewController, animated: showAnimation)
        }else {

            appDelegate.hybridViewController.isFirstInstance = false
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                MILLoadViewManager.sharedInstance.hide()
            }
        }
    }
    
    
    private func deleteGoal(data: [NSObject : AnyObject]!) {
        let goalId = data["goalToDelete"] as! String
        MQALogger.log("deleteGoal Goal ID: \(goalId)")
        GoalsDataManager.sharedInstance.goals = GoalsDataManager.sharedInstance.goals.filter { (goal: Goal) -> Bool in
            goal._id != goalId
        }
    }
    
    private func checkFeasibility(data: [NSObject : AnyObject]!) {
        MQALogger.log("checkFeasibility data: \(data)")
        
        FeasibilityDataManager.sharedInstance.data = data
        FeasibilityDataManager.sharedInstance.retrieveFeasibility()
    }
    
    private func updatedPriorities(data: [NSObject : AnyObject]!) {
        MQALogger.log("updatedPriorities data: \(data)")
       
    }
    
}

extension NavViewController: UIViewControllerTransitioningDelegate{
    
    /**
    Delegate method for a custom transition needed to show the menu from the top
    */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = ReverseCoverVertical()
        transition.presenting = true
        return transition
    }
    
    /**
    Delegate method for a custom transition needed to dismiss the menu back to the top
    */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = ReverseCoverVertical()
        transition.presenting = false
        return transition
    }
}
