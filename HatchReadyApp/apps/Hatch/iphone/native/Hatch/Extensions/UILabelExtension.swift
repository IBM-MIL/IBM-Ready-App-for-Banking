/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


import Foundation
import UIKit

extension UILabel {
    
    /**
    Method to resize a label of variable height based on some text and a fixed width.
    
    :param: fixedWidth The size we want our width to always be at.
    */
    func sizeToFitFixedWidth(fixedWidth: CGFloat) {
        if self.text != "" {
            var objcString: NSString = self.text!
            var frame = objcString.boundingRectWithSize(CGSizeMake(fixedWidth, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:self.font], context: nil)
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, frame.size.height)
        }

    }
    
    /**
    Method to return the height based on some text, font, and width.
    
    :param: text The text to base the height on.
    :param: font The font of the text.
    :param: width The width to base the height on.
    */
    class func heightForText(text: String, font: UIFont, width: CGFloat)->CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()

        return label.frame.size.height
    }
    
    func setKernAttribute(size: CGFloat!){
        let kernAttribute : Dictionary = [NSKernAttributeName: size]
        if self.text != nil {
            self.attributedText = NSAttributedString(string: self.text!, attributes: kernAttribute)
        }
    }
}