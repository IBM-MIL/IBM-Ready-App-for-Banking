/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
*  Model class for a Goal object
*/
class Goal: NSObject {
    /// owner's id
    var ownerId: String?
    /// goal id
    var title: String?
    /// start date
    var start: Double?
    /// end date
    var end: Double?
    /// goal amount
    var goalAmount: Double?
    /// amount saved
    var saved: Double?
    /// deposit amount
    var depositAmount: Double?
    /// deposit frequency
    var depositFrequency: String?
    /// how much progress has been made towards the goal
    var progress: Double?
    /// business id
    var businessID: String?
    /// feasibility for the goal
    var feasibility: Int?
    /// goal priority
    var priority: Int?
    /// notes about the goal
    var notes: String?
    ///  unique id for goal
    var _id: String?
    /// the type (should always be goal)
    var type: String?
    /// revision id (used by cloudant database)
    var _rev: String?
    /// weeksLeft until end date
    var weeksLeft: Int?
    /// monthsLeft until end date
    var monthsLeft: Int?
    
    /**
    Initialize a goal object with a JSON Dictionary representation
    
    :param: jsonDictionary the JSON representation
    
    :returns: Goal object
    */
    init(jsonDictionary: [String : AnyObject]) {
        ownerId = jsonDictionary["ownerID"] as? String
        title = jsonDictionary["title"] as? String
        start = jsonDictionary["start"] as? Double
        end = jsonDictionary["end"] as? Double
        goalAmount = jsonDictionary["goalAmount"] as? Double
        saved = jsonDictionary["saved"] as? Double
        depositAmount = jsonDictionary["depositAmount"] as? Double
        depositFrequency = jsonDictionary["depositFrequency"] as? String
        progress = jsonDictionary["progress"] as? Double
        businessID = jsonDictionary["businessID"] as? String
        feasibility = jsonDictionary["feasibility"] as? Int
        priority = jsonDictionary["priority"] as? Int
        notes = jsonDictionary["notes"] as? String
        _id = jsonDictionary["_id"] as? String
        type = jsonDictionary["type"] as? String
        _rev = jsonDictionary["_rev"] as? String
        weeksLeft = jsonDictionary["weeksLeft"] as? Int
        monthsLeft = jsonDictionary["monthsLeft"] as? Int
    }
    
    /**
    Converts the Goal object to a corresponding JSON Dictionary (serialization)
    
    :returns: A serialized JSON Dictionary of the Goal object
    */
    func convertToDictionary() -> [NSObject : AnyObject] {
        var goalDictionary: [NSObject : AnyObject] = [:]
        
        goalDictionary["ownerId"] = ownerId
        goalDictionary["title"] = title
        goalDictionary["start"] = start
        goalDictionary["end"] = end
        goalDictionary["goalAmount"] = goalAmount
        goalDictionary["saved"] = saved
        goalDictionary["depositAmount"] = depositAmount
        goalDictionary["depositFrequency"] = depositFrequency
        goalDictionary["progress"] = progress
        goalDictionary["businessID"] = businessID
        goalDictionary["feasibility"] = feasibility
        goalDictionary["priority"] = priority
        goalDictionary["notes"] = notes
        goalDictionary["_id"] = _id
        goalDictionary["type"] = type
        goalDictionary["_rev"] = _rev
        goalDictionary["weeksLeft"] = weeksLeft
        goalDictionary["monthsLeft"] = monthsLeft
        
        return goalDictionary
    }
    
    /**
    Utility method that takes a Dictionary which represents an Array of JSON Goal objects and converts it to an Array of Goal objects
    
    :param: responseJson The JSON response as a Dictionary
    
    :returns: deserialized array of Goal objects
    */
    class func parseJsonArray(responseJson: NSDictionary) -> [Goal] {
        let resultString = responseJson["result"] as! NSString
        let resultData = resultString.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonArray = NSJSONSerialization.JSONObjectWithData(resultData!, options: NSJSONReadingOptions(0), error: nil) as! NSArray
        
        var goals: [Goal] = []
        
        for jsonObject in jsonArray {
            let goal = Goal(jsonDictionary: jsonObject as! [String : AnyObject])
            goals.append(goal)
        }
        
        return goals
    }
    
    /**
    Utility method for converting (serializing) an array of Goals to a serialized JSON dictionary
    
    :param: goals array of Goal objects
    
    :returns: serialized JSON dictionary representation of the Goal array
    */
    class func convertGoalsArrayToDictionary(goals: [Goal]) -> [NSObject: AnyObject] {
        var goalsDictArr: [[NSObject : AnyObject]] = []
        
        for goal in goals {
            goalsDictArr.append(goal.convertToDictionary())
        }

        return ["goals" : goalsDictArr]
    }
    
}