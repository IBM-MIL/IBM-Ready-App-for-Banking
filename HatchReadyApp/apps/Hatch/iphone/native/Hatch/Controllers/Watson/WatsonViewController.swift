/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


import UIKit
/**
*  This view controller controls logic for the UIPageViewController that is inside of a container view. This will begin the Watson questionnaire.
*/
class WatsonViewController: UIViewController {
    
    /// menu button
    @IBOutlet weak var menuBar: UIButton!
    
    /// PageViewController to present Watson questionnaire
    var pageViewController : UIPageViewController!
    
    /// back button
    @IBOutlet weak var backButton: UIButton!
    
    /// custom UIPageControl
    @IBOutlet weak var hatchPage: HatchPageControl!
    
    /// the array containing the user's choice for each Question. watsonChoice[0] = 1 for example means that the user pressed option 2 for question 1
    var watsonChoice : [Int] = [-1,-1,-1]
    
    /// boolean to only allow user to swipe forward to next viewcontroller if they have already answered the next question
    var touchEnabled : Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup menubar action
        menuBar.addTarget(self.navigationController, action: "menuButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.backButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /**
    This method takes in a view controller, and based on its type will set the check mark associated with the option the user has previously selected in watsonChoice
    
    - parameter startingViewController: the view controller whose checkmark will be updated
    */
    func updateChecks(startingViewController : UIViewController){
        if (startingViewController.isKindOfClass(WatsonFrequencyViewController)) {
            let vc = startingViewController as! WatsonFrequencyViewController
            vc.watsonChoice = watsonChoice
        }
        
        if (startingViewController.isKindOfClass(WatsonImportanceViewController)) {
            let vc = startingViewController as! WatsonImportanceViewController
            vc.watsonChoice = watsonChoice
        }
        
        if (startingViewController.isKindOfClass(WatsonOverdraftViewController)) {
            let vc = startingViewController as! WatsonOverdraftViewController
            vc.watsonChoice = watsonChoice
        }
    }
    
    
    /**
    This method will either set the back button as hidden or not based on the index.
    
    - parameter index: index of view controller
    */
    func setBackButtonHidden(index: Int){
        switch index {
        case 2...3:
            self.backButton.hidden = false
        default:
            self.backButton.hidden = true
        }
    }
    
    /**
    This method will either set the hatch page control as hidden or not based on the index.
    
    - parameter index: index of the view controller
    */
    func setHatchPageControlHidden(index: Int){
        switch index {
        case 1...3:
            self.hatchPage.hidden = false
        default:
            self.hatchPage.hidden = true
        }
    }
    
    /**
    This method will either hide or unhide both the back button and the hatch page control based on the index. Also, the hatch page control is updated to the correct page.
    
    - parameter index: index of the view controller
    */
    func setOutletAttributes(index: Int){
        self.hatchPage.setCurrentPageIndex(index-1)
        setBackButtonHidden(index)
        setHatchPageControlHidden(index)
    }
    
    /**
    This method is called when the back button is tapped. The hatchPageControl is updated to the correct state and the correct view controller is displayed with animation
    
    - parameter sender:
    */
    @IBAction func backButtonTapped(sender: AnyObject) {
        let vc : UIViewController = pageViewController.viewControllers!.last!
        
        //set next view controller to be presented
        let startingViewController : UIViewController = self.viewControllerAtIndex(vc.view.tag-1)!
        self.setOutletAttributes(vc.view.tag-1)
        let viewControllers : [UIViewController] = [startingViewController]
        pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
    }
    
    
    /**
    This method is called initially to connect the navigation view controller + WatsonViewController to the pageViewController + the controllers it will show
    
    - parameter segue:
    - parameter sender:
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "watsonPageSegue"{
            pageViewController = segue.destinationViewController as! UIPageViewController
            pageViewController.view.backgroundColor = UIColor.greenHatch()
            pageViewController.dataSource = self
            pageViewController.delegate = self
            
            let startingViewController : UIViewController = self.viewControllerAtIndex(0)!
            
            self.setOutletAttributes(startingViewController.view.tag)
            let viewControllers : [UIViewController] = [startingViewController]
            pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
    }
    
    
    /**
    This method returns the view controller at a particular index passed in
    
    - parameter index: desired index of view controller to return
    
    - returns: a UIViewController
    */
    func viewControllerAtIndex(index : NSInteger) -> UIViewController? {
        if (index > 3 || index < 0) {
            return nil
        }
        
        //create new vc based on index
        var vc : UIViewController = UIViewController()
        
        switch (index){
        case 0:
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("start") as! WatsonStartViewController
        case 1:
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("frequency") as! WatsonFrequencyViewController
        case 2:
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("important") as! WatsonImportanceViewController
        case 3:
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("overdraft") as! WatsonOverdraftViewController
        default:
            break
        }
        touchEnabled = false
        
        //update check marks for next view controller shown
        self.updateChecks(vc)
        
        MQALogger.log("pageIndex = \(vc.view.tag)")
        
        
        return vc
    }
    
}


extension WatsonViewController: UIPageViewControllerDataSource {
    /**
    This method must be implemented since WatsonViewController uses UIPageViewControllerDataSource. It will return the viewcontroller to be shown before whichever viewcontroller is currently being shown
    Note: This method is only used if pageViewController.dataSource is set (not set for Watson flow to disable touch to slide)
    
    - parameter pageViewController:
    - parameter viewController:
    
    - returns:
    */
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index : NSInteger
        index = viewController.view.tag
        
        if ((index <= 1) || (index == NSNotFound)) {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    
    
    /**
    This method must be implemented since WatsonViewController uses UIPageViewControllerDataSource. It will return the viewcontroller to be shown after whichever viewcontroller is currently being shown
    Note: This method is only used if pageViewController.dataSource is set (not set for Watson flow to disable touch to slide)
    
    - parameter pageViewController:
    - parameter viewController:
    
    - returns:
    */
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index : NSInteger
        
        
        if (viewController.view.tag < 3 && viewController.view.tag != 0) {
            
            if (watsonChoice[viewController.view.tag - 1] != -1) {
                touchEnabled = true //only allow user to swipe forward if question has already been answered
            }
        } else {
            return nil
        }
        
        if (touchEnabled == true) {
            index = viewController.view.tag //use the following if touch to swipe is needed (and set pageViewController.dataSource) : viewController.view.tag
        }
        else {
            return nil
        }
        
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        if (index > 3) {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0 //set to 0 so default pagecontrol does not show up
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
}




extension WatsonViewController: UIPageViewControllerDelegate {
    
    /**
    This method should update the hatchPageControl's current page (shows correct dot based on page being shown) and hide or show the back button
    Note: This method is only used if pageViewController.dataSource is set (not set for Watson flow to disable touch to slide)
    
    - parameter pageViewController:
    - parameter finished:
    - parameter previousViewControllers:
    - parameter completed:
    */
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        
        let vc = pageViewController.viewControllers!.last!
        
        MQALogger.log("PAGEINDEX HERE : \(vc.view.tag)")
        self.setOutletAttributes(vc.view.tag)
        
        MILLoadViewManager.sharedInstance.hide()
    }
    
    
}


