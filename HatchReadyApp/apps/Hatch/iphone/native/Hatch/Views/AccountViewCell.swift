/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Custom UITableVewCell class used to represent an Account
*/
class AccountViewCell: UITableViewCell {

    /// UILabel that shows the name of the account
    @IBOutlet weak var nameLabel: UILabel!
    /// UILabel that shows the amount of the account
    @IBOutlet weak var amountLabel: UILabel!

}
