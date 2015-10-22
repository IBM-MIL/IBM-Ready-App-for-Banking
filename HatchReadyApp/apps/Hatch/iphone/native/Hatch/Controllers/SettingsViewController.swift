/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


import UIKit

/**
*  Custom UIViewController for Settings page.
*/
class SettingsViewController: HatchUIViewController{
    
    /// Table view that contains all cells for Settings page
    @IBOutlet weak var tableView: UITableView!
    /// Button that opens the menu
    @IBOutlet weak var menuButton: UIButton!
    /// Label displaying the title of the Settings page
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellTitles: [String] = [NSLocalizedString("ACCOUNTS", comment: ""),
                                NSLocalizedString("TOUCH ID", comment: ""),
                                NSLocalizedString("NOTIFICATIONS", comment: ""),
                                NSLocalizedString("PROFILE PICTURE", comment: "")]
    
    /**
    Method that sets up the UI style and sets up button action receivers.
    */
    override func viewDidLoad() {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.menuButton.addTarget(self.navigationController,
            action: "menuButtonTapped:",
            forControlEvents: .TouchUpInside)

        self.titleLabel.setKernAttribute(4.0)
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate{
    /**
    Delegate method to create individual settings cells
    
    - parameter tableView:
    - parameter indexPath:
    
    - returns:
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Disclosure Indicator Cell
        if (indexPath.row == 0 || indexPath.row == 3){
            var disclosureCell = self.tableView.dequeueReusableCellWithIdentifier("disclosureCell", forIndexPath: indexPath) as? SettingsDisclosureIndicatorCell
            
            if disclosureCell == nil {
                disclosureCell = SettingsDisclosureIndicatorCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "disclosureCell")
            }
            
            disclosureCell?.configCell(cellTitles[indexPath.row])
            
            return disclosureCell!
        } else {
            
            // UISwitch Cell
            var switchCell = self.tableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as? SettingsUISwitchCell
            
            if switchCell == nil {
                switchCell = SettingsUISwitchCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "switchCell")
            }
            
            switchCell?.configCell(indexPath.row, title: cellTitles[indexPath.row])
            
            return switchCell!
        }
    }
    
    /**
    Delegate method that returns the height for rows in the tableview.
    
    - parameter tableView:
    - parameter indexPath:
    
    - returns: Height for specified row.
    */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    /**
    Delegate method that returns the number of rows in a specified section
    
    - parameter tableView:
    - parameter section:
    
    - returns:
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.cellTitles.count
    }
    
    /**
    Delegate method to handle event of cell being tapped
    
    - parameter tableView:
    - parameter indexPath:
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 0 || indexPath.row == 3){
            
            // Animates title label as if it were button to give user feedback
            let disclosureCell = self.tableView.cellForRowAtIndexPath(indexPath) as! SettingsDisclosureIndicatorCell
            disclosureCell.animateLabelColorChange()
            
        }
        
    }
}
