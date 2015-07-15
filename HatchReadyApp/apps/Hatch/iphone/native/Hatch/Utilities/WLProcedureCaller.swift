/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2014, 2015. All Rights Reserved.
*/

import Foundation

/**
*  An extension to the WLDelegate protocol that additionally declares an onPreExecute() and onPostExecute() method.
*/
protocol WLDataDelegate : WLDelegate {
    func onPreExecute()
    func onPostExecute()
}

/**
*  Wrapper class for making a Worklight procedure call.
*/
class WLProcedureCaller: NSObject {
    private var dataDelegate : WLDataDelegate!
    private var adapterName : String!
    private var procedureName : String!
    private var logWLStartTime : NSDate!
    private let TIMEOUT_MILLIS = 10000
    
    /**
    Constructor to initialize the procedure caller with both the adapter name and procedure name.
    
    :param: adapterName
    :param: procedureName
    
    :returns: WLProcedureCaller
    */
    init(adapterName : String, procedureName: String){
        self.adapterName = adapterName
        self.procedureName = procedureName
    }
    
    /**
    This function will execute the adapter procedure and invoke the appropriate functions of the
    WLDataDelegate that is passed in.
    
    :param: dataDelegate
    :param: params   Procedure parameters
    */
    func invokeWithResponse(dataDelegate: WLDataDelegate, params: Array<AnyObject>?){
        self.dataDelegate = dataDelegate
        self.dataDelegate.onPreExecute()
        
        let invocationData = WLProcedureInvocationData(adapterName: adapterName, procedureName: procedureName)
        invocationData.parameters = params
        
        //Timeout value in milliseconds
        let options = NSDictionary(object:TIMEOUT_MILLIS, forKey: "timeout")
        
        logWLStartTime = NSDate()
        
        WLClient.sharedInstance().invokeProcedure(invocationData, withDelegate: self, options:options as [NSObject : AnyObject])
    }
}

extension WLProcedureCaller: WLDelegate {
    func onSuccess(response: WLResponse!) {
        let elapsedTime = NSDate().timeIntervalSinceDate(logWLStartTime)
        dataDelegate.onSuccess(response)
        dataDelegate.onPostExecute()
    }
    
    func onFailure(response: WLFailResponse!) {
        var resultText : String = "Invocation Failure"
        if(response.responseText != nil) {
            resultText = "\(resultText): \(response.responseText)"
            MQALogger.log("Result text: \(resultText)")
        }
        dataDelegate.onFailure(response)
        dataDelegate.onPostExecute()
    }
}
