/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
*  This class represents the Solution from Watson Tradeoff
*/
class Solution: NSObject {
    
    /// The status of the solution
    var status : String!
    
    /// The solution reference
    var solutionRef : String!
    
    init(jsonDict : [NSObject: AnyObject]) {
        status = jsonDict["status"] as! String
        solutionRef = jsonDict["solution_ref"] as! String
    }

}
