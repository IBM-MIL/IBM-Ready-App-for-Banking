/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Contains the webview that holds the hybrid view components in the app.
*/
class HybridViewController: CDVViewController {
    /// determines whether the HybridViewController is rendering the initial hybrid view screen
    var isFirstInstance = true
    /// determines whether the HybridViewController was instantiated for showing the goals screens
    var fromGoals: Bool = false
    ///  determines whether the HybridViewController was instantiated for showing the dashboard screens
    var fromDash: Bool = false
    ///  saves a screenshot of the hybrid view which is helpful for reducing flickering between screen transitions
    var image : UIImage!
    
    /**
    This init method is called when the hybridViewController is first initialized in the app delegate
    
    - parameter aDecoder: <#aDecoder description#>
    
    - returns: <#return value description#>
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.startPage = WL.sharedInstance().mainHtmlFilePath()
        print("Start Page: \(self.startPage)")
    }
    
    /**
    When the hybridViewController is first loaded, it sets the start page and sends a message to the javascript passing the person data to prepopulate the fields
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.scrollView.bounces = false
        addTapRecognizer()
    }
    
    /**
    Adds a UITapGestureRecognizer to the view that will be used to know when to update the screenshot of the view for transitioning
    */
    func addTapRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "updateImage")
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    /**
    Takes a screenshot of the current state of the view. This is used to make the transitions smoother
    */
    func updateImage(){
        image = Utils.imageWithView(self.view)    
	}
    
}

extension HybridViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
