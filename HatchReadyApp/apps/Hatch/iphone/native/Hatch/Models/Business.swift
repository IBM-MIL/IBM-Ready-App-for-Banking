/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit

/**
*  Model representing a business
*/
class Business: NSObject {
    /// The name of the business
    var name: String! = ""
    /// The array of accounts for a business
    var accounts: [Account]! = []
    /// The array of the spendings for a business
    var spendings: [Account]! = []
    /// The name of the file for the business's logo image (Currently stored on the app)
    var imageName: String! = ""

}
