/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UITableViewCell for Settings page that includes a UISwitch.
*/
class SettingsUISwitchCell: UITableViewCell {

    /// Switch that determines if the property is true or false.
    @IBOutlet weak var settingsSwitch: UISwitch!
    /// Label that displays title of the cell.
    @IBOutlet weak var titleLabel: UILabel!
    
    /**
    Method that configures the SettingsUISwitchCell.
    
    - parameter indexPathRow:
    - parameter title:
    
    - returns:
    */
    func configCell(indexPathRow: Int, title: String)->SettingsUISwitchCell {

        self.titleLabel.text = title
        self.titleLabel.setKernAttribute(2.0)
        self.selectionStyle = .None
        self.settingsSwitch.tag = indexPathRow
        self.settingsSwitch.addTarget(self, action: "settingsSwitchFlipped:", forControlEvents: .ValueChanged)

        // Set switches at correct position to reflect user defaults
        if (indexPathRow == 1){
            // Touch ID
            let configManager = ConfigManager.sharedInstance
            if (configManager.deviceHasTouchIDAbility()){
                self.settingsSwitch.on = configManager.useTouchID()
            }
            // Disable TouchID functionality on devices that cannot use it
            else {
                self.settingsSwitch.on = false
                self.settingsSwitch.userInteractionEnabled = false
            }
            
        }
        
        return self
    }
    
    /**
    Method that handles the ValueChanged event from the UISwitch in SettingsUISwitchCell.
    
    - parameter sender: UISwitch that triggered the event.
    */
    func settingsSwitchFlipped(sender: UISwitch){
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        switch (sender.tag){
            //Touch ID
        case 1:
            MQALogger.log("touch id")
            userDefaults.setBool(sender.on, forKey: ConfigManager.sharedInstance.touchIDKey)
            userDefaults.synchronize()
            
            break
            
            // Notifications
        case 2:
            MQALogger.log("notifications")
            break
            
        default:
            break
        }
    }
}