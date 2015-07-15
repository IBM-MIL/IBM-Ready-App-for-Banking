/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
*  This class is the Offer object to hold Offers received from MobileFirst Platform
*/
class Offer: NSObject {
    /// Name of offer
    var name: NSString
    
    /// Apy of account offer
    var apy: NSNumber
    
    /// Fee associated with offer
    var fee: NSString
    
    /// Number of monthly withdrawals allowed
    var withdrawals: NSInteger
    
    /// Overdraft protection - 1 : Yes, 0 : No
    var overdraft: NSInteger
    
    /// Liquidity of offer from 0, 1, or 2 (least to most liquid)
    var liquidity: NSInteger
    
    /// ID associated with offer
    var _id: NSString
    
    
    /**
    Initializes Offer object given a JSON dictionary
    
    :param: json json dictionary passed in
    
    :returns: Offer object
    */
    init(json: NSDictionary) {
        name = json["name"] as! NSString
        apy = json["apy"] as! NSNumber
        fee = json["fee"] as! NSString
        withdrawals = json["withdrawals"] as! NSInteger
        liquidity = json["liquidity"] as! NSInteger
        overdraft = json["overdraft"] as! NSInteger
        _id = json["_id"] as! NSString

    }
    
    /**
    This method will parse the JSON Dictionary provided and return an array of native Offer objects
    
    :param: responseJson JSON to be parsed
    
    :returns: Array of Offer objects
    */
    class func parseJsonArray(responseJson: NSDictionary) -> [Offer] {
        let resultString = responseJson["result"] as! NSString
        let resultData = resultString.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonArray = NSJSONSerialization.JSONObjectWithData(resultData!, options: NSJSONReadingOptions(0), error: nil) as! NSArray
        
        var offers: [Offer] = []
        
        for jsonObject in jsonArray {
            let offer = Offer(json: jsonObject as! NSDictionary)
            offers.append(offer)
        }
        
        return offers
    }
}
