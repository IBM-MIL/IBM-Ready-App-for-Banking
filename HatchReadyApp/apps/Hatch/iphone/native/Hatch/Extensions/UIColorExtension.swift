/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

//Project Specific Colors
extension UIColor {
    class func lightGreenHatch() -> UIColor{return UIColor(hex:"b4e051")}
    
    class func greenHatch() -> UIColor{return UIColor(hex:"8cd211")}
    
    class func darkGreenHatch() -> UIColor{return UIColor(hex:"5aa700")}
    
    class func darkerGreenHatch() -> UIColor{return UIColor(hex:"4b8400")}
    
    class func redHatch() -> UIColor{return UIColor(hex:"d74108")}
    
    class func orangeHatch() -> UIColor{return UIColor(hex:"FF7832")}
    
    class func peachHatch() -> UIColor{return UIColor(hex:"ffd4a0")}
    
    class func yellowHatch() -> UIColor{return UIColor(hex:"efc100")}
    
    class func darkGrayUIHatch() -> UIColor{return UIColor(hex:"3c4646")}
    
    class func lightGrayUIHatch() -> UIColor{return UIColor(hex:"f7f5f5")}
    
    class func darkGrayTextHatch() -> UIColor{return UIColor(hex:"5a6464")}
    
    class func lightGrayTextHatch() -> UIColor{return UIColor(hex:"aeb8b8")}
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        var hexString = ""
                
        if hex.hasPrefix("#") {
            let nsHex = hex as NSString
            hexString = nsHex.substringFromIndex(1)
            
        } else {
            hexString = hex
        }
        
        let scanner = NSScanner(string: hexString)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexLongLong(&hexValue) {
            switch (count(hexString)) {
            case 3:
                red = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue = CGFloat(hexValue & 0x00F)              / 15.0
            case 6:
                red = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue = CGFloat(hexValue & 0x0000FF)           / 255.0
            default:
                print("Invalid HEX string, number of characters after '#' should be either 3, 6")
            }
        } else {
            println("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init?(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat = 1.0){
        var cmykColorSpace = CGColorSpaceCreateDeviceCMYK()
        var colors = [cyan, magenta, yellow, black, alpha] // CMYK+Alpha
        var cgColor = CGColorCreate(cmykColorSpace, colors)
        self.init(CGColor: cgColor)
    }
    
}