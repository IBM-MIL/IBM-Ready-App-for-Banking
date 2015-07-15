/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Useful methods specifically for localization
*/
class LocalizationUtils: NSObject {
    
    /**
    Takes a float value and returns a string representing the value using the user account locale.
    
    :param: amount A Float amount for a currency
    
    :returns: The value using the user's locale
    */
    class func localizeCurrency(amount: Double) -> String {
        var currencyFormatter = NSNumberFormatter()
        
        // Based off locale of user account pulled from MobileFirst Platform instance
        let userLocale = NSLocale(localeIdentifier: LoginDataManager.sharedInstance.currentUser.locale)
        currencyFormatter.locale = userLocale
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.alwaysShowsDecimalSeparator = true
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        return currencyFormatter.stringFromNumber(amount)!
    }

}
