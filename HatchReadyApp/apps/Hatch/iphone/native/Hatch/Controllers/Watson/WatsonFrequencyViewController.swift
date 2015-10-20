/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit


/**
*  This view controller is 1/5 of the Watson questionnaire, and asks the user how frequently they plan to withdraw from an account.
*/
class WatsonFrequencyViewController: UIViewController {
    
    @IBOutlet var check1: UIImageView!
    @IBOutlet var check2: UIImageView!
    @IBOutlet var check3: UIImageView!
    
    var hasSelected : Bool = false
    
    var watsonChoice : [Int] = [-1,-1,-1]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.setUpViewKern(self.view)
        
        if (watsonChoice[0] == 0) {
            self.check1.hidden = false
        }
        else if (watsonChoice[0] == 1) {
            self.check2.hidden = false
        }
        else if (watsonChoice[0] == 2) {
            self.check3.hidden = false
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    This method is called when any button/option is tapped on this view controller to push to the next view controller in the UIPageViewController. Buttons' tags have been set to determine which button has been pressed
    
    - parameter sender:
    */
    @IBAction func tappedOption(sender: AnyObject) {
        let vc : WatsonViewController = self.parentViewController?.parentViewController as! WatsonViewController
        vc.touchEnabled = true //tell WatsonViewController that swipe to touch is enabled
        
        //transition to next view
        let viewControllers : [UIViewController] = [vc.viewControllerAtIndex(self.view.tag+1)!]
        vc.setOutletAttributes(self.view.tag+1)
        vc.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        switch sender.tag {
        case 0:
            MQALogger.log("tapped item 0")
            hasSelected = true
            check1.hidden = false
            check2.hidden = true
            check3.hidden = true
            vc.watsonChoice[0] = 0 //tell WatsonViewController which choice was picked
            
        case 1:
            MQALogger.log("tapped item 1")
            hasSelected = true
            check2.hidden = false
            check1.hidden = true
            check3.hidden = true
            vc.watsonChoice[0] = 1 //tell WatsonViewController which choice was picked
            
        case 2:
            MQALogger.log("tapped item 2")
            hasSelected = true
            check3.hidden = false
            check1.hidden = true
            check2.hidden = true
            vc.watsonChoice[0] = 2 //tell WatsonViewController which choice was picked
            
        default:
            MQALogger.log("tag not set!")
        }
        
    }
    
    
}
