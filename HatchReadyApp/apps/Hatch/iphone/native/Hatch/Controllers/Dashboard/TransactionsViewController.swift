/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Displays the transactions for a select account
*/
class TransactionsViewController: HatchUIViewController {
    
    /// Transaction UITableView
    @IBOutlet weak var transactionTableView: UITableView!
    /// The label for the account title
    @IBOutlet weak var accountTitleLabel: UILabel!
    /// The label for the total balance of the account
    @IBOutlet weak var balanceLabel: UILabel!
    /// The menu button
    @IBOutlet weak var menuButton: UIButton!
    /// The back button to return to the dashboard
    @IBOutlet weak var backButton: UIButton!
    /// The account whose transactions the user is viewing
    var account : Account!
    /// The group of groups of transactions grouped by day
    var transactionDays: [TransactionDay]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MILLoadViewManager.sharedInstance.show()
        menuButton.addTarget(self.navigationController, action: "menuButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        backButton.addTarget(self.navigationController, action: "backButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        accountTitleLabel.text = account.accountName
        Utils.setUpViewKern(self.view)
        
        balanceLabel.attributedText = Utils.getPriceAttributedString(LocalizationUtils.localizeCurrency(account.balance.toDouble), dollarSize: 40, centSize: 23, color: balanceLabel.textColor)
        
        TransactionsDataManager.sharedInstance.getTransactions(account.id, callback: transactionCallback)
    }
    
    /**
    Callback method from MobileFirst Platform
    
    - parameter success: If the call succeeded or not
    */
    func transactionCallback(success: Bool, transactionDays: [TransactionDay]!){
        if (success){
            
            MQALogger.log("Transaction data success")
            
            self.transactionDays = transactionDays
            self.transactionTableView.reloadData()
            
            MILLoadViewManager.sharedInstance.hide()
        } else {
            MQALogger.log("Transaction data failure")
        }
    }
    
    
}

extension TransactionsViewController: UITableViewDataSource {
    /**
    Delegate method to set the number of rows for the UITableView.
    
    - parameter tableView:
    - parameter section:
    
    - returns:
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactionDays[section].transactions.count
    }
    
    
    /**
    Delegate method to create the cell for the UITableView.
    
    - parameter tableView:
    - parameter indexPath:
    
    - returns: <#return value description#>
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("transactionCell") as! TransactionViewCell
        var overallIndex = indexPath.row
        
        for var i = indexPath.section - 1; i >= 0; i-- {
                overallIndex += transactionDays[i].transactions.count
        }
        
        if overallIndex.isEven {
            cell.backgroundColor = UIColor.lightGrayUIHatch()
        }else{
            cell.backgroundColor = UIColor.whiteColor()
        }
        let transaction = transactionDays[indexPath.section].transactions[indexPath.row]
        cell.titleLabel.text = transaction.title.uppercaseString
        var amountText = LocalizationUtils.localizeCurrency(transaction.amount.toDouble)
        
        if transaction.type == .Deposit{
            amountText = "+ " + amountText
            cell.amountLabel.textColor = UIColor.greenHatch()
        }else{
            amountText = "- " + amountText
            cell.amountLabel.textColor = UIColor.orangeHatch()
        }
        
        cell.amountLabel.text = amountText
        
        Utils.setUpViewKern(cell, kernValue: 2)
        
        return cell
    }
    
    /**
    Delegate method to set the number of sections in the UITableView (The number of groups of transaction days)
    
    - parameter tableView:
    
    - returns: The number of sections in the UITableView
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return transactionDays.count
    }
    
}

extension TransactionsViewController: UITableViewDelegate {
    
    /**
    Delegate method to override the view for the table header
    
    - parameter tableView:
    - parameter section:
    
    - returns: The custom view
    */
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("transactionHeaderCell") as! TransactionHeaderViewCell
        
        headerCell.dateLabel.text = transactionDays[section].date.uppercaseString
        Utils.setUpViewKern(headerCell)
        return headerCell
    }
    
    /**
    Delegate method to override the size of the header of the table
    
    - parameter tableView:
    - parameter section:
    
    - returns: Height of the header
    */
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("transactionHeaderCell") as! TransactionHeaderViewCell
        return 40
    }
}
