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
        let resultString = jsonDict["result"] as! String
        
        // convert String to NSData
        var data: NSData = resultString.dataUsingEncoding(NSUTF8StringEncoding)!
        
        // convert NSData to 'AnyObject'
        let resultDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0),
            error: nil) as! [NSObject: AnyObject]
        
        let resolutionDict = resultDict["resolution"] as! [NSObject: AnyObject]
        let solutionsArray = resolutionDict["solutions"] as! [[NSObject: AnyObject]]
        
        for dict in solutionsArray {
            var solution = Solution(jsonDict: dict)
            self.solutions.append(solution)
        }
    }
}
