/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

extension Double{
    
    var toCGFloat:CGFloat   {return CGFloat(self)}
    
    func roundToDecimalDigits(decimals:Int) -> Double
    {
        let a : Double = self
        let format : NSNumberFormatter = NSNumberFormatter()
        format.numberStyle = NSNumberFormatterStyle.DecimalStyle
        format.roundingMode = NSNumberFormatterRoundingMode.RoundHalfUp
        format.maximumFractionDigits = 2
        let string: NSString = format.stringFromNumber(NSNumber(double: a))!
        return string.doubleValue
    }
}