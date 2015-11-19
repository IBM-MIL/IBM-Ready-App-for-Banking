/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

/**
*  This class represents the Resolution of a Watson Tradeoff Solution
*/
class Resolution {
    /// The array of Solutions provided by Watson
    var solutions : [Solution] = []
    
    init(jsonDict : [NSObject: AnyObject]) {

        let resolutionDict = jsonDict["resolution"] as! [NSObject: AnyObject]
        let solutionsArray = resolutionDict["solutions"] as! [[NSObject: AnyObject]]
        
        for dict in solutionsArray {
            let solution = Solution(jsonDict: dict)
            self.solutions.append(solution)
        }
    }
}
