/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation
import UIKit

extension UIButton{
    
    func setBackgroundColorForState(color: UIColor, forState: UIControlState){
        self.setBackgroundImage(UIButton.imageWithColor(color, width: self.frame.size.width, height: self.frame.size.height), forState: forState)
    }
    
    /**
    Create an image of a given color
    
    :param: color  The color that the image will have
    :param: width  Width of the returned image
    :param: height Height of the returned image
    
    :returns: An image with the color, height and width
    */
    private class func imageWithColor(color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
        var rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setKernAttribute(size: CGFloat!){
        
        let states = [UIControlState.Normal, UIControlState.Application, UIControlState.Disabled, UIControlState.Highlighted, UIControlState.Reserved, UIControlState.Selected]
        
        for state in states{
            let titleColor = self.titleColorForState(state)
            var attributes : [String: AnyObject]
            if titleColor != nil {
                attributes = [NSKernAttributeName: size, NSForegroundColorAttributeName: titleColor!]
            }else{
                attributes = [NSKernAttributeName: size]
            }
            let title = self.titleForState(state)
            if(title != nil){
                self.setAttributedTitle(NSAttributedString(string: title!, attributes: attributes), forState: state)
            }
        }
        
        
    }
}
