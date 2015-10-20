/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

/**
*  This class represents a Watson Problem, including columns (TradeoffObjectiveDefinition), a subject (string), and options (TradeoffOption).
*/
class TradeoffProblem{
    /// Objectives array of TradeoffObjectiveDefinitions
    var columns : [TradeoffObjectiveDefinition]
    
    /// Subject of Problem
    var subject : String
    
    /// Options array of TradeoffOptions
    var options : [TradeoffOption]
    
    /**
    Initializes a TradeoffProblem object with TradeoffObjectiveDefinitions, a subject, and TradeoffOptions
    
    - parameter columns: TradeoffObjectiveDefinitions passed in
    - parameter subject: subject string
    - parameter options: TradeoffOptions passed in
    
    - returns: TradeoffProblem object
    */
    init(columns : [TradeoffObjectiveDefinition], subject : String, options : [TradeoffOption]) {
        self.columns = columns
        self.subject = subject
        self.options = options
    }
    
    /**
    This method will return a dictionary object of a TradeoffProblem
    
    - returns: Dictionary object
    */
    func convertToDictionary() -> [NSObject : AnyObject] {
        var columnsDictArr : [[NSObject : AnyObject]] = []
        for column in self.columns {
            columnsDictArr.append(column.convertToDictionary())
        }
        
        var optionsDictArr : [[NSObject : AnyObject]] = []
        for option in self.options {
            optionsDictArr.append(option.convertToDictionary())
        }
        return ["columns" : columnsDictArr, "subject" : self.subject, "options" : optionsDictArr]
    }
    
    
}
