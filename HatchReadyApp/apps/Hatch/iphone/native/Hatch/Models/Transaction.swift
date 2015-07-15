/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

enum TransactionType {
    case Deposit, Withdrawal
}

/**
*  Represents the individual transaction
*/
class Transaction: NSObject {
    /// The title of the transaction
    var title: String!
    /// The absolute value of the transaction
    var amount: Float!
    /// The type of transaction (Desposit/Withdrawl)
    var type: TransactionType?
    /// The date of the transaction
    var date: NSDate!
}
