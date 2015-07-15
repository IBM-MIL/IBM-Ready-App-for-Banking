/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UITableViewCell for Settings page that contains a Disclosure Indicator. 
*/
class SettingsDisclosureIndicatorCell : UITableViewCell{
    /// Label that displays the title of the cell.
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Timer that is used for the custom animation that simulates a button press.
    var timer: NSTimer!
    
    func configCell(title: String)->SettingsDisclosureIndicatorCell{
        self.titleLabel.text = title
        self.titleLabel.setKernAttribute(2.0)
        
        self.selectionStyle = .None
    
        return self
    }
    
    /**
    Function that animates a label color change to simulate a button press. This functionality was added to give feedback to a user as requested by design.
    */
    func animateLabelColorChange(){
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.075,
            target: self,
            selector: "changeLabelColor:",
            userInfo: nil,
            repeats: false)
        self.titleLabel.textColor = UIColor.lightGrayTextHatch()
        
    }
    
    /**
    Method changes the color of the title label. Used in conjunction with the animateLabelColorChange as its selector.
    
    :param: sender SettingsDisclosureIndicatorCell
    */
    @IBAction func changeLabelColor(sender: SettingsDisclosureIndicatorCell){
        
        self.titleLabel.textColor = UIColor.darkGrayTextHatch()
        self.timer.invalidate()
    }
}
