/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


import UIKit


/**
*  This is the last view controller in the Watson questionnaire to confirm that the bank will call shortly
*/
class WatsonFinishViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.setUpViewKern(self.view)
        

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
    This method will transition back to the dashboard after tapping the confirm button
    
    - parameter sender:
    */
    @IBAction func tappedConfirm(sender: AnyObject) {
        MenuViewController.goToDashboard()
    }

    
}
