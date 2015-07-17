/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Represents the group of transactions for a single day
*/
class TransactionDay: NSObject {
    
    /// The day of the group of transactions
    var date: String!
    /// The group of transactions
    var transactions: [Transaction]!
   
}
