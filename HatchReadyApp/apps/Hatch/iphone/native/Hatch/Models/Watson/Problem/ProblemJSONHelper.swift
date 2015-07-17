/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import Foundation

/**
*  This class assembles the Watson Problem Dictionary (Objectives + Options) required to be sent to MobileFirst Platform in order to receive a Watson Tradeoff Solution.
*/
class ProblemJSONHelper {
    
    /**
    This class method assembles the TradeoffObjectiveDefinition array and the TradeoffOption array to create a TradeoffProblem object. This returns a problem object in dictionary form so it is ready to be sent back again.
    
    :param: offers   Desired offers to be in the problem
    :param: response User's response for the 3 questions. ie [0,1,0] for answer 0, answer 1, and answer 0 on each page
    
    :returns: Dictionary of the problem object
    */
    class func formatProblemJSON(offers : [Offer], response : [Int]) -> [NSObject: AnyObject] {
        let objectives : [TradeoffObjectiveDefinition] = ProblemJSONHelper.createObjectives(response)
        let options : [TradeoffOption] = ProblemJSONHelper.createOptions(offers, response: response)
        var problem : TradeoffProblem = TradeoffProblem(columns: objectives, subject: "Offers", options: options)
        return problem.convertToDictionary()
    }
    
    /**
    This method assembles an array of TradeoffObjectiveDefinition objects based on the user's response on the 3 Watson questions. This represents the objective of the problem.
    
    :param: response User's response for the 3 questions. ie [0,1,0] for answer 0, answer 1, and answer 0 on each page
    
    :returns: array of TradeoffObjectiveDefinition objects
    */
    class func createObjectives(response : [Int]) -> [TradeoffObjectiveDefinition] {
        var withdrawalsObjective : TradeoffObjectiveDefinition?
        var apyObjective : TradeoffObjectiveDefinition?
        var liquidityObjective : TradeoffObjectiveDefinition?
        var overdraftObjective : TradeoffObjectiveDefinition?
        var objectives : [TradeoffObjectiveDefinition] = []
        
        //Watson question 1
        
        if (response[0] == 0) { //user anticipates withdrawing once or twice
            withdrawalsObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MIN, key: "withdrawals", type: TradeoffType.NUMERIC, objective : true)
        }
        if (response[0] == 1) { //user anticipates withdrawing as often as he or she can
            withdrawalsObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MAX, key: "withdrawals", type: TradeoffType.NUMERIC, objective : true)
        }
        if (response[0] == 2) { //user anticipates withdrawing an unknown number of times per month
            //don't send anything
        }
        
        if let withdrawalAssigned = withdrawalsObjective {
            objectives.append(withdrawalAssigned)
        }
        
        
        //Watson question 2
        
        if (response[1] == 0) { //user values high interest rate as most important
            apyObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MAX, key: "apy", type: TradeoffType.NUMERIC, objective : true)
        }
        if (response[1] == 1) { //user values liquidity as most important
            liquidityObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MAX, key: "liquidity", type: TradeoffType.NUMERIC, objective : true)
        }
        if (response[1] == 2) { //user values BOTH apy and liquidity as most important
            apyObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MAX, key: "liquidity", type: TradeoffType.NUMERIC, objective : true)
            liquidityObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MAX, key: "apy", type: TradeoffType.NUMERIC, objective : true)
        }
        
        if let apyAssigned = apyObjective {
            objectives.append(apyAssigned)
        }
        
        if let liquidityAssigned = liquidityObjective {
            objectives.append(liquidityAssigned)
        }
        
        
        //Watson question 3
        
        if (response[2] == 0) { //user wants a plan with overdraft protection
            overdraftObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MAX, key: "overdraft", type: TradeoffType.NUMERIC, objective : true)
        }
        if (response[2] == 1) { //user wants a plan without overdraft protection
            overdraftObjective = TradeoffObjectiveDefinition(goal: TradeoffGoal.MIN, key: "overdraft", type: TradeoffType.NUMERIC, objective : true)
        }
        
        if let overdraftAssigned = overdraftObjective {
            objectives.append(overdraftObjective!)
        }
        
        
        
        MQALogger.log("Watson user choices: \(response)")

        
        return objectives
    }
    
    
    /**
    This method assembles an array of TradeoffOption objects given the desired offers and user's response. This represents the options associated with each offer in the problem.
    
    :param: offers   Array of offer objects
    :param: response User's response for the 3 questions. ie [0,1,0] for answer 0, answer 1, and answer 0 on each page
    
    :returns: Array of TradeoffOption objects
    */
    class func createOptions(offers : [Offer], response : [Int]) -> [TradeoffOption] {
        var options : [TradeoffOption] = []
        var index : Int = 0
        var objectives : [NSString] = []
        
        //question 1
        if (response[0] == 0 || response[0] == 1) {
            objectives.append("withdrawals") //only withdrawals if 1st or 2nd response
        }
        
        //question 2
        if (response[1] == 0) {
            objectives.append("apy")
        }
        if (response[1] == 1) {
            objectives.append("liquidity")
        }
        if (response[1] == 2) {
            objectives.append("apy")
            objectives.append("liquidity")
        }
        
        //question 3
        objectives.append("overdraft") //always overdraft
        
        for offer in offers {
            let key = "offer\(index)"
            index += 1
            var values = [String : Double]()
            
            // only set values for desired objectives
            for objective in objectives {
                if (objective == "withdrawals") {
                    values["withdrawals"] = Double(offer.withdrawals)
                }
                if (objective == "apy") {
                    values["apy"] = Double(offer.apy)
                }
                if (objective == "liquidity") {
                    values["liquidity"] = Double(offer.liquidity)
                }
                if (objective == "overdraft") {
                    values["overdraft"] = Double(offer.overdraft)
                }
                
            }
            let option = TradeoffOption(key: key, name: offer.name as String, values: values)
            options.append(option)
        }
        
        return options
    }
}