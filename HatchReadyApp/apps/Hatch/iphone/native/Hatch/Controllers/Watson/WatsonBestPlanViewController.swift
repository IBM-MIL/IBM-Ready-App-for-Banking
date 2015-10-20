/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


import UIKit

/**
*  This view controller is 4/5 of the Watson questionnaire, and presents the user with the best bank plan for them, and allows them to either accept or refuse to switch to this recommended account. It also will initiate the MobileFirst Platform call to receive all available offers and generate a WatsonTradeoffSolution from the bank. The user may also tap to view all account options.
*/
class WatsonBestPlanViewController: UIViewController {
    
    @IBOutlet var whiteView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var animationImage: UIImageView!
    @IBOutlet var accountLabel: UILabel!
    var watsonChoice : [Int] = [-1,-1,-1]

    var coverView : UIView!
    
    //@IBOutlet weak var menuBar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.navigationController, action: "menuButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        backButton.addTarget(self.navigationController, action: "backButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: UIControlEvents.TouchDown)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.coverView = UIView(frame: self.view.frame)
        self.coverView.backgroundColor = UIColor.greenHatch()
        self.view.addSubview(self.coverView)
        self.accountLabel.text = ""
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        MILLoadViewManager.sharedInstance.show()
        formatWatsonProblem()
    }
    /**
    This method will push to the next view controller in the UIPageViewController
    
    - parameter sender:
    */
    @IBAction func tappedYes(sender: AnyObject) {
        //transition to next view
        let viewControllerDestination = self.storyboard?.instantiateViewControllerWithIdentifier("finish")
        self.navigationController?.pushViewController(viewControllerDestination!, animated: true)
    
    }
    
    /**
    This method will push to the next view controller in the UIPageViewController
    
    - parameter sender:
    */
    @IBAction func tappedNo(sender: AnyObject) {
        MenuViewController.goToDashboard()
        
    }
    /**
    This method will display the all offers page
    
    - parameter sender:
    */
    @IBAction func tappedAccountOptions(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Watson", bundle: nil)
        
        let nativeViewController = storyboard.instantiateViewControllerWithIdentifier("AllOffersNativeViewController") as! NativeViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.hybridViewController.isFirstInstance = true
        WL.sharedInstance().sendActionToJS("changePage", withData: ["route":"offers"]);
        self.navigationController?.pushViewController(nativeViewController, animated: true)
    }
    
    /**
    This method will fetch the list of available offers and call gotOffers upon completion
    */
    func formatWatsonProblem() {
        
        OffersDataManager.sharedInstance.fetchOffersData(gotOffers)
        
    }
    
    /**
    This method is called when the list of offers is returned from MobileFirst Platform. A Watson problem is then created and sent to watson in order to receive a Watson Tradeoff Solution.
    
    - parameter offers: Offers dictionary received from MobileFirst Platform
    */
    func gotOffers(offers : [NSObject: AnyObject]) {
        let offerArray : [Offer] = Offer.parseJsonArray(offers) //make all offers into an array of Offer objects
        var problem = [NSObject : AnyObject]()
        problem = ProblemJSONHelper.formatProblemJSON(offerArray, response: watsonChoice) //send this JSON that contains Watson Problem back to WL
        var singleProblemArray : Array<AnyObject> = []
        singleProblemArray.append(problem)
        WatsonDataManager.sharedInstance.fetchWatsonData(singleProblemArray,callback:  gotWatsonSolution)
        
        
    }
    
    
    /**
    This method is called when the Watson Tradeoff Solution has been received. The resolution is parsed and the recommended bank account (offer) is displayed to the user.
    
    - parameter solution: The solution dictionary returned from MobileFirst Platform
    */
    func gotWatsonSolution (solution : [NSObject : AnyObject]) {
        let resolution = Resolution(jsonDict: solution)
        
        let solutionArray = resolution.solutions as [Solution]
        var chosenOffer : String = ""
        
        for solution in solutionArray {
            if (solution.status == "FRONT") {
                chosenOffer = solution.solutionRef
                break
            }
        }
        var attributedString : NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        switch chosenOffer {
        case "offer0" :
            attributedString = NSMutableAttributedString(string: "BUSINESS BASIC\nCHECKING ACCOUNT")
        case "offer1" :
            attributedString = NSMutableAttributedString(string:"BUSINESS SELECT\nCHECKING ACCOUNT")
        case "offer2" :
            attributedString = NSMutableAttributedString(string:"BUSINESS ADVANTAGE\nCHECKING ACCOUNT")
        case "offer3" :
            attributedString = NSMutableAttributedString(string: "BUSINESS BASIC\nSAVINGS ACCOUNT")
        case "offer4" :
            attributedString = NSMutableAttributedString(string:"BUSINESS SELECT\nSAVINGS ACCOUNT")
        case "offer5" :
            attributedString = NSMutableAttributedString(string:"BUSINESS ADVANTAGE\nSAVINGS ACCOUNT")
        default : ""
            attributedString = NSMutableAttributedString(string:"")
        }
        accountLabel.attributedText = attributedString
        
        Utils.setUpViewKern(self.view)
        self.coverView.removeFromSuperview()
        MILLoadViewManager.sharedInstance.hide(self.startAnimation)
    }
    
    
    /**
    This method will animate an egg rolling to reveal the suggested Account offer after pausing
    */
    func startAnimation () {
        self.accountLabel.hidden = false
        self.animationImage.hidden = false
        NSTimer.scheduledTimerWithTimeInterval(0.35, target: self, selector: Selector("beginAnimation"), userInfo: nil, repeats: false)
    }
    
    /**
    This method will animate an egg rolling to reveal the suggested Account offer
    */
    func beginAnimation () {
        var imageArray : [UIImage] = []
        for (var i = 1; i < 100; i++) {
            let image : UIImage = UIImage(named: "hatchegg\(i)")!
            imageArray.append(image)
        }
        self.animationImage.animationImages = imageArray
        self.animationImage.animationDuration = 3.00
        self.animationImage.animationRepeatCount = 1
        self.animationImage.image = imageArray.last
        self.animationImage.startAnimating()
        self.whiteView.hidden = false
    }
    
    
    /**
    This method will hide the animation of the egg rolling when the user has pressed back
    */
    func backButtonTapped(){
        self.animationImage.hidden = true
    }

    
}
