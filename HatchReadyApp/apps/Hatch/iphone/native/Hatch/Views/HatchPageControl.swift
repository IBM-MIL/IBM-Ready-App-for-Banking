/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UIPageControl for Hatch that replaces the default dot images
*/
class HatchPageControl: UIPageControl {
    /// The active image that indicates the active index
    var activeImage: UIImage!
    /// The inactive image that indicates the inactive index(es)
    var inactiveImage: UIImage!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        activeImage = UIImage.activePageDot()
        inactiveImage = UIImage.inactivePageDot()
    }
    
    /**
    Sets the UIPageControl to use green dots rather than white dots
    */
    func useGreenDots() {
        activeImage = UIImage.activeGreenPageDot()
        inactiveImage = UIImage.inactiveGreenPageDot()
        self.updateDots()
    }
    
    /**
    Replaces the default dots with images
    */
    func updateDots() {
        for (index, subview) in self.subviews.enumerate() {
            let dot = self.imageViewForSubview(subview )
            if (index == self.currentPage){
                dot.image = activeImage
            }else{
                dot.image = inactiveImage
            }
        }
    }
    
    /**
    Gets the UIImageView of a dot if one is present and generates on if there is not
    
    - parameter view: The subview of the UIPageControl that is either an UIImageView or not
    
    - returns: A UIImageView to set the dot as
    */
    func imageViewForSubview(view: UIView) -> UIImageView {
        var dot : UIImageView!
        if view.isKindOfClass(UIView){
            for subview in view.subviews {
                if subview.isKindOfClass(UIImageView) {
                    dot = subview as! UIImageView
                    break;
                }
            }
            
            if (dot == nil) {
                dot = UIImageView(frame: CGRectMake(0, 0, view.width, view.height))
                view.addSubview(dot)
            }
        } else {
            dot = view as! UIImageView
        }
        
        return dot
    }
    
    func setCurrentPageIndex(page: Int){
        if page < self.numberOfPages {
            super.currentPage = page
            self.updateDots()
        }
    }
    
}
