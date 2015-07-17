/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit
import QuartzCore
/**
*  Useful Utility methods
*/
class Utils: NSObject {
    
    /**
    Recursively searches a view for labels and buttons to set the kern attributes on them
    
    :param: view The view to set kern levels on
    */
    class func setUpViewKern(view: UIView, kernValue: CGFloat! = nil){
        let kern : CGFloat! = (kernValue != nil) ? kernValue : ConfigManager.sharedInstance.KernValue
        for subview in view.subviews{
            if subview.isKindOfClass(UILabel){
                let label = subview as! UILabel
                label.setKernAttribute(kern)
            }
            
            if subview.isKindOfClass(UIButton){
                let button = subview as! UIButton
                button.setKernAttribute(kern)
            }
            
            if subview.isKindOfClass(UIView){
                self.setUpViewKern(subview as! UIView, kernValue: kernValue)
            }
        }
    }
   
    /**
    Builds an attributed string for a dollar representation that has two different sizes for the dollar portion and the cents portion
    
    :param: amount     The string of the dollar amount
    :param: dollarSize Size of the font for the dollar portion
    :param: centSize   Size of the font for the cent portion
    :param: color       Color of the string
    :returns: The appropriate attributed string
    */
    class func getPriceAttributedString(amount: NSString, dollarSize: CGFloat, centSize: CGFloat, color: UIColor)->NSAttributedString{
        var attrString = NSMutableAttributedString()
        
        let index = amount.length-3
        
        let wholeDollar = amount.substringToIndex(index)
        let wholeDollarAttr = [NSFontAttributeName: UIFont.tuffy(dollarSize), NSForegroundColorAttributeName: color, NSKernAttributeName: ConfigManager.sharedInstance.KernValue]
        let wholeDollarAttrString = NSAttributedString(string: wholeDollar, attributes: wholeDollarAttr)
        
        let cents = amount.substringFromIndex(index)
        let centsAttr = [NSFontAttributeName: UIFont.tuffy(centSize), NSForegroundColorAttributeName: color, NSKernAttributeName: ConfigManager.sharedInstance.KernValue]
        let centsAttrString = NSAttributedString(string: cents, attributes: centsAttr)
        
        attrString.appendAttributedString(wholeDollarAttrString)
        attrString.appendAttributedString(centsAttrString)
        
        return attrString
    }
    
    /**
    Takes a UIView and adds bars across the width of the UIView with an individual width that represents an accounts portion of a total value
    
    :param: barView    UIView to modify
    :param: accounts   An array of Accounts
    :param: isAccounts True if the array is of accounts. False if the array is of spendings
    */
    class func generateAccountsBar(barView: UIView, accounts: [Account], isAccounts: Bool) {
        let accountTotal = Utils.getAccountsTotal(accounts)
        
        let accountColors: [UIColor] = [UIColor.darkGreenHatch(), UIColor.darkerGreenHatch(), UIColor.greenHatch(), UIColor.lightGreenHatch()]
        let spendingColors: [UIColor] = [UIColor.redHatch(), UIColor.orangeHatch(), UIColor.peachHatch()]
        
        var colors : [UIColor]
        if isAccounts {
            colors = accountColors
        }else{
            colors = spendingColors
        }
        
        var xOffset: CGFloat = 0.0
        
        for (index, account) in enumerate(accounts) {
            let percent = account.balance.toDouble / accountTotal
            let colorIndex = index % colors.count
            let color = colors[colorIndex]
            
            let width = (barView.width * percent.toCGFloat)
            let accountView = UIView(frame: CGRectMake(xOffset, 0, width, barView.height))
            accountView.backgroundColor = color
            xOffset += width
            
            barView.addSubview(accountView)
        }
    }
    
    /**
    Adds the value of all the account balances in an array and returns the total
    
    :param: accounts An array of Accounts
    
    :returns: Total amount of the account balances
    */
    class func getAccountsTotal(accounts: [Account]) -> Double {
        var accountTotal : Double = 0.0
        
        for account in accounts {
            accountTotal += account.balance.toDouble
        }
        
        return accountTotal
    }
    
    /**
    Uses the time of day to determine which random greeting is presented to the user
    
    :returns: A greeting
    */
    class func getRandomGreeting() -> String {
        let anytimeGreetings = [NSLocalizedString("HEY", comment: ""), NSLocalizedString("YO", comment: ""), NSLocalizedString("HOWDY", comment: ""), NSLocalizedString("WHAT'S UP", comment: ""), NSLocalizedString("HI THERE", comment: ""), NSLocalizedString("HAPPY TO SEE YOU", comment: "")]
        let morningGreetings = [NSLocalizedString("GOOD MORNING", comment: ""), NSLocalizedString("RISE AND SHINE", comment: ""), NSLocalizedString("MORNIN’", comment: "")] + anytimeGreetings
        let afternoonGreetings = [NSLocalizedString("GOOD AFTERNOON", comment: "")]  + anytimeGreetings
        let eveningGreetings = [NSLocalizedString("GOOD EVENING", comment: "")] + anytimeGreetings
        
        var greetings : [String]
        
        var hour : Int = NSDate().hour()
        
        switch hour {
        case 5...11:
            greetings = morningGreetings
        case 12...17:
            greetings = afternoonGreetings
        case 18...23, 0...4:
            greetings = eveningGreetings
        default:
            greetings = anytimeGreetings
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(greetings.count)))
        
        return greetings[randomIndex]
    }
    
    /**
    Gets a UIImage of a view aka a screenshot
    
    :param: view UIView to capture
    
    :returns: UIImage of the view
    */
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img;
    }
}



