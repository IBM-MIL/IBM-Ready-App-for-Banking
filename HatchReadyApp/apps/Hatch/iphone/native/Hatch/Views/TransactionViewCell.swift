/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  UITableViewCell for the individual transactions
*/
class TransactionViewCell: UITableViewCell {
    /// UILabel showing the amount of the transaction
    @IBOutlet weak var amountLabel: UILabel!
    /// UILabel showing the title of the transaction
    @IBOutlet weak var titleLabel: UILabel!

}
