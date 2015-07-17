/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  The view presented when an loading sequence is triggered
*/
public class MILLoadView : UIView {
    /// The UIImageView that holds the loading image
    @IBOutlet weak var loadingImageView : UIImageView!

    /**
    Initializer for MILLoadView
    
    :returns: And instance of MILLoadView
    */
    class func instanceFromNib() -> MILLoadView {
        return UINib(nibName: "MILLoadView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! MILLoadView
    }
    
    /**
    Begins and repetition of a series of images
    */
    func showLoadingAnimation() {
        self.loadingImageView.image = UIImage.animatedImageNamed("", duration: 2.5)
        self.loadingImageView.hidden = false
    }
}
