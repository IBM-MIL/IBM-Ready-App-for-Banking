/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UIViewController for a business which contains the business name and logo. Used on the dashboard.
*/
class BusinessViewController: UIViewController {
    /// The UILabel for the business name
    @IBOutlet weak var businessNameLabel: UILabel!
    /// The UIImageView for the business's logo
    @IBOutlet weak var logoImageView: UIImageView!
    /// The index of the UIPageViewController that this view represents
    var pageIndex: Int!
    /// The name of the business
    var businessName: String!
    /// The image of the logo of the business
    var logoImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.image = logoImage
        logoImageView.roundImageView()
        businessNameLabel.text = businessName
        Utils.setUpViewKern(self.view)
    }
    
}
