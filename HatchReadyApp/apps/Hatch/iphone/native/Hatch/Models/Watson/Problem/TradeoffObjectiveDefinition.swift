/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

public enum TradeoffType: String {
    case NUMERIC = "NUMERIC"
    case TEXT = "TEXT"
}

public enum TradeoffGoal: String {
    case MIN = "MIN"
    case MAX = "MAX"
}

struct TradeoffValueRange {
    var low : Int = 0
    var hi : Int = 0
}


/**
This class represents objective of a Watson Problem
*/
class TradeoffObjectiveDefinition {
    
    /// TradeoffGoal - either MIN or MAX
    var goal : TradeoffGoal
    
    /// Whether it is objective
    var objective : Bool
    
    /// Insignificant loss
    var insignificant_loss : Int?
    
    /// Significant gain
    var significant_gain : Int?
    
    /// Significant loss
    var significant_loss : Int?
    
    /// Key for objective
    var key : String
    
    /// Type of objective : NUMERIC or TEXT
    var type : TradeoffType
    
    /// Range of tradeoffvalue
    var range : TradeoffValueRange?
    
    /// Enum values
    var enum_vals : [String]?
    
    /// Format of objective
    var format : String?
    
    /// Full name of Objective
    var full_name : String?
    
    /// Description of Objective
    var description : String?
    
    /**
    Initializes TradeoffObjectiveDefinition with TradeoffGoal, key, TradeoffType, and objective value (whether it is objective or not)
    
    :param: goal      TradeoffGoal object
    :param: key       key string
    :param: type      TradeoffType object
    :param: objective whether goal is objective or not (true or false)
    
    :returns: <#return value description#>
    */
    init(goal : TradeoffGoal, key : String, type : TradeoffType, objective : Bool) {
        self.goal = goal
        self.key = key
        self.type = type
        self.objective = objective
    }
    
    
    /**
    This method will return a dictionary object of a TradeoffObjectiveDefinition
    
    :returns: Dictionary object
    */
    func convertToDictionary() -> [NSObject : AnyObject] {
        return ["goal" : self.goal.rawValue as String, "key" : self.key, "type" : self.type.rawValue as String, "is_objective" : self.objective]
    }
    
    
    
}