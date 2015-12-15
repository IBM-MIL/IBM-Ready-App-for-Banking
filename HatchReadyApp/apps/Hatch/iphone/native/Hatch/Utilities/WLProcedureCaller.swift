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
    func onFailureError(error: NSError!)
}

/**
 *  Wrapper class for making a Worklight procedure call.
 */
class WLProcedureCaller: NSObject {
    private var dataDelegate : WLDataDelegate!
    private var adapterName : String!
    private var procedureName : String!
    private var externalResourceURL : String!
    private var headers : Dictionary<String, String>!
    private var logWLStartTime : NSDate!
    private let TIMEOUT_MILLIS = 10000
    
    /**
     Constructor to initialize the procedure caller for calling adapter procedures.
     
     - parameter adapterName:
     - parameter procedureName:
     
     - returns: WLProcedureCaller
     */
    init(adapterName : String, procedureName: String){
        self.adapterName = adapterName
        self.procedureName = procedureName
    }
    
    /**
     Constructor to initialize the procedure caller for calling external resources.
     
     - parameter externalResourceURL: Full URL to external resource to be called
     - parameter headers:             HTTP Header values
     
     - returns: WLProcedureCaller
     */
    init(externalResourceURL: String, headers: Dictionary<String, String>?) {
        self.externalResourceURL = externalResourceURL
        self.headers = headers
        
    }
    
    /**
     This function will execute the adapter procedure and invoke the appropriate functions of the
     WLDataDelegate that is passed in.
     
     - parameter dataDelegate:
     - parameter pathParam:   Parameter that is to be part of the REST path
     - parameter queryParams: Named parameters that are to be provided as query parameters to the REST service
     - parameter formParams:  Complex parameters that will be serialized to JSON and passed to the REST service as form parameters
     - parameter bodyText:    Simple string that will be sent as the post body
     */
    func invokeWithResponse(dataDelegate: WLDataDelegate, pathParam: String? = nil, queryParams: Dictionary<String, String>? = nil, formParams: Dictionary<String,AnyObject>? = nil, bodyText: String? = nil){
        self.dataDelegate = dataDelegate
        self.dataDelegate.onPreExecute()
        
        var url : String!
        
        // Construct base REST URL
        if let externalURL = externalResourceURL {
            // External resource
            url = externalURL
        } else {
            // Adapter call
            url = "/adapters/" + adapterName + "/" + procedureName
        }

        // Add path parameters, if they exist
        if let unwrappedPathParam = pathParam {
            url = url + "/" + unwrappedPathParam
        }
        
        // Check to see if there are form parameters or bodyText, which will be sent with a POST
        if let unwrappedFormParams = formParams {
            // Create a POST request
            let request = WLResourceRequest(URL: NSURL(string: url), method: WLHttpMethodPost)
            
            // Add query parameters, if they exist
            addQueryParamsToRequest(request, queryParams: queryParams)
            
            // Add header parameters, if they exist
            addHeaderParamsToRequest(request, headerParams: headers)
            
            // Json-ify the form parameters
            let jsonFormParams = jsonifyFormParams(unwrappedFormParams)
            
            request.sendWithFormParameters(jsonFormParams, completionHandler: { (WLResponse response, NSError error) -> Void in
                if (error == nil) {
                    self.dataDelegate.onSuccess(response)
                } else {
                    self.dataDelegate.onFailureError(error)
                }
            })
            
        } else if bodyText != nil {
            // Create a POST request
            let request = WLResourceRequest(URL: NSURL(string: url), method: WLHttpMethodPost)
            
            // Add query parameters, if they exist
            addQueryParamsToRequest(request, queryParams: queryParams)
            
            // Add header parameters, if they exist
            addHeaderParamsToRequest(request, headerParams: headers)
            
            request.sendWithBody(bodyText, completionHandler: { (WLResponse response, NSError error) -> Void in
                if (error == nil) {
                    self.dataDelegate.onSuccess(response)
                } else {
                    self.dataDelegate.onFailureError(error)
                }
            })
            
        } else {
            // Create a GET request
            let request = WLResourceRequest(URL: NSURL(string: url), method: WLHttpMethodGet)
            
            // Add query parameters, if they exist
            addQueryParamsToRequest(request, queryParams: queryParams)
            
            // Add header parameters, if they exist
            addHeaderParamsToRequest(request, headerParams: headers)
            
            request.sendWithCompletionHandler { (WLResponse response, NSError error) -> Void in
                if (error == nil) {
                    self.dataDelegate.onSuccess(response)
                } else {
                    self.dataDelegate.onFailureError(error)
                }
            }
        }
        
        
        //Timeout value in milliseconds
        let options = NSDictionary(object:TIMEOUT_MILLIS, forKey: "timeout")
        
        logWLStartTime = NSDate()
        
    }
    
    func addQueryParamsToRequest(request: WLResourceRequest, queryParams: Dictionary<String,String>?) {
        if let unwrappedQueryParams = queryParams {
            for (queryParam, queryValue) in unwrappedQueryParams {
                request.setQueryParameterValue(queryValue, forName: queryParam)
            }
        }
    }
    
    
    func addHeaderParamsToRequest(request: WLResourceRequest, headerParams: Dictionary<String,String>?) {
        if let unwrappedHeaderParams = headerParams {
            for (headerParam, headerValue) in unwrappedHeaderParams {
                request.setHeaderValue(headerValue, forName: headerParam)
            }
        }
        
    }
    
    func jsonifyFormParams(formParams: Dictionary<String, AnyObject>) -> Dictionary<String, String> {
        var tempParams : [String:String] = [:]
        // Convert each dictionary object into json
        for (formParam, formValue) in formParams {
            do {
                let formValueJson = try NSJSONSerialization.dataWithJSONObject(formValue, options:NSJSONWritingOptions(rawValue:0))
                tempParams[formParam]=String(data: formValueJson, encoding: NSUTF8StringEncoding)
            } catch {
                
            }
        }
        return tempParams
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
