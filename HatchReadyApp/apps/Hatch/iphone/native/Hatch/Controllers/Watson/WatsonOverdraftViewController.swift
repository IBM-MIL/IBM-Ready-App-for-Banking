/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  This view controller is 3/5 of the Watson questionnaire, and asks the user a question on overdraft protection. 
*/
class WatsonOverdraftViewController: UIViewController {
    
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var check1: UIImageView!
    @IBOutlet var check2: UIImageView!
    var watsonChoice : [Int] = [-1,-1,-1]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.setUpViewKern(self.view)
        if (watsonChoice[2] == 0) {
            self.check1.hidden = false
            confirmButton.enabled = true
            
        }
        else if (watsonChoice[2] == 1) {
            self.check2.hidden = false
            confirmButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let vc : WatsonViewController = self.parentViewController?.parentViewController as! WatsonViewController
        vc.touchEnabled = false //tell WatsonViewController that swipe to touch is enabled
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
        self.confirmButton.enabled = true //allow user to continue now
        var vc : WatsonViewController = self.parentViewController?.parentViewController as! WatsonViewController
        //vc.touchEnabled = true //tell WatsonViewController that swipe to touch is enabled
        
        switch sender.tag {
        case 0:
            MQALogger.log("tapped item 0")
            check1.hidden = false
            check2.hidden = true
            vc.watsonChoice[2] = 0 //tell WatsonViewController which choice was picked
            
        case 1:
            MQALogger.log("tapped item 1")
            check2.hidden = false
            check1.hidden = true
            vc.watsonChoice[2] = 1 //tell WatsonViewController which choice was picked
            
        default:
            MQALogger.log("tag not set!")
        }
        
    }
    
    @IBAction func tappedConfirm(sender: AnyObject) {
        let vc : WatsonViewController = self.parentViewController?.parentViewController as! WatsonViewController
        //transition to next view
        let viewControllerDestination = self.storyboard?.instantiateViewControllerWithIdentifier("bestplan") as! WatsonBestPlanViewController
        viewControllerDestination.watsonChoice = vc.watsonChoice
        vc.navigationController?.pushViewController(viewControllerDestination, animated: false)
    }
    
    
    
}
