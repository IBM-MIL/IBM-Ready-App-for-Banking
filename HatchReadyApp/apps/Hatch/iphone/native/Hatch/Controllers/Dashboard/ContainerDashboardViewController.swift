/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UIViewController that wrapts the DashboardViewController so that the content of the DashboardViewController can be contained inside a UIScrollView
*/
class ContainerDashboardViewController: UIViewController {
    /// Menu Button
    @IBOutlet weak var menuButton: UIButton!
    /// The UIScrollView that holds the Container that holds the DashboadViewController
    @IBOutlet weak var contentScrollView: UIScrollView!
    /// The height of the Container that holds the DashboadViewController
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    /// The Container that holds the DashboadViewController
    @IBOutlet weak var contentContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.navigationController, action: "menuButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /**
    Sets the height for the UIScrollView that holds the DashboadViewController. Called by the DashboadViewController.
    
    :param: height The hieght of the DashboadViewController content
    */
    func setHeight(height: CGFloat){
        containerHeightConstraint.constant = height
        contentContainer.setHeight(height)
        self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width, height)
    }
    
}
