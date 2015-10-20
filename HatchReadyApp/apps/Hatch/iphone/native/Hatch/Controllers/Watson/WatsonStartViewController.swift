/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  This view controller is the starting view controller in the Watson questionnaire and tells the user that they will be asked a series of questions to find the best account for him or her.
*/
class WatsonStartViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "HEY \(LoginDataManager.sharedInstance.currentUser.firstName.uppercaseString)!"
        Utils.setUpViewKern(self.view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tappedConfirm(sender: AnyObject) {
        let vc : WatsonViewController = self.parentViewController?.parentViewController as! WatsonViewController
        vc.touchEnabled = true //tell WatsonViewController that swipe to touch is enabled
        //transition to next view
        let viewControllers : [UIViewController] = [vc.viewControllerAtIndex(self.view.tag+1)!]
        vc.setOutletAttributes(self.view.tag+1)
        vc.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
