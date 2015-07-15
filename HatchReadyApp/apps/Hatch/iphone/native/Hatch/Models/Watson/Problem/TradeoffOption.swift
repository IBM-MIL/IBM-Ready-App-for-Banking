/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/


/**
*  This class represents the option of a Watson Problem
*/
class TradeoffOption{
    /// Key of option
    var key : String
    
    /// Name of option
    var name : String
    
    /// values in form of dictionary of option
    var values : [String : Double]
    
    /// Description html of option
    var description_html : String?
    
    /// application data of option
    var app_data : [String : String]?
    
    /**
    Initializes a TradeoffOption from a key, name, and dictionary of values
    
    :param: key    key string
    :param: name   name string
    :param: values values dictionary
    
    :returns: <#return value description#>
    */
    init(key : String, name : String, values : [String : Double]) {
        self.key = key
        self.name = name
        self.values = values
    }
    
    /**
    This method will return a dictionary object of a TradeoffOption
    
    :returns: Dictionary object
    */
    func convertToDictionary() -> [NSObject : AnyObject] {
        return ["name" : self.name, "key" : self.key, "values" : self.values]
    }
}