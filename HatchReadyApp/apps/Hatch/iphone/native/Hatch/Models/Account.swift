/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

enum AccountType{
    case Account, Spending
}

/**
*  Model representing an account
*/
class Account: NSObject {
    /// id of account
    var id : String!
    /// Name of account
    var accountName : String!
    /// Type of account
    var accountType : AccountType!
    /// Balance of account
    var balance : Float!
    /// Bool of whether or not the account has Transactions
    var hasTransactions = false
}