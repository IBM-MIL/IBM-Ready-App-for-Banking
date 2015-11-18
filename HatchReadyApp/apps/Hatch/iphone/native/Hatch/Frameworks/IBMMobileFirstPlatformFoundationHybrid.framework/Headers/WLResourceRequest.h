/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */
 
//
//  WLResourceRequest.h
//  RESTful adapters
//
//  Created by Yulian Vurgaft on 20/11/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//
#import <Foundation/Foundation.h>

@class WLResponse;

/**
*
* This class encapsulates a resource request. 
* The resource may be an adapter on the MobileFirst server, or an external resource. 
* The class provides several 'send' methods, with different inputs for the body of a request.
*/
@interface WLResourceRequest : NSObject

typedef NS_ENUM(NSUInteger, WLAFHTTPClientParameterEncoding ) {
    WLFormURLParameterEncoding,
    WLJSONParameterEncoding,
    WLPropertyListParameterEncoding,
};



/**
 *
 * GET HTTP method constant
 *
 */
extern NSString * const WLHttpMethodGet;

/**
 *
 * POST HTTP method constant
 *
 */
extern NSString * const WLHttpMethodPost;

/**
 *
 * PUT HTTP method constant
 *
 */
extern NSString * const WLHttpMethodPut;

/**
 *
 * DELETE HTTP method constant
 *
 */
extern NSString * const WLHttpMethodDelete;

/**
 *
 * URL of the request
 *
 */
@property (readonly) NSURL* url;

/**
 *
 * HTTP method of the request
 *
 */
@property (readonly) NSString* httpMethod;

/**
 *
 * Dictionary of query parameters
 *
 */
@property (nonatomic) NSDictionary *queryParameters;

/**
 *
 * Array of request headers
 *
 */
@property (nonatomic) NSArray *headers;

/**
 *
 * Request timeout interval
 *
 */
@property NSTimeInterval timeoutInterval;

/**
 *
 * Request string encoding
 *
 */
@property (nonatomic, assign) NSStringEncoding stringEncoding;

/**
 *
 * Creates an instance of <code>WLresourceRequest</code> with the specified URL and method
 * @param url URL of the request (full or relative to MobileFirst Server)
 * @param method Method of the request (POST, GET,...)
 *
 */
+(WLResourceRequest*) requestWithURL:(NSURL*)url method:(NSString*)method;

/**
 *
 * Creates an instance of <code>WLresourceRequest</code> with the specified URL, method, and timeout
 * @param url URL of the request (full or relative to MobileFirst Server)
 * @param method Method of the request (POST, GET,...)
 * @param timeout Timeout of the request in seconds
 *
 */
+(WLResourceRequest*) requestWithURL:(NSURL*)url method:(NSString*)method timeout:(NSTimeInterval)timeout;

/**
 *
 * Sets query parameter value 
 * 
 * If the query parameter with the same name already exists, it is overridden.
 * @param parameterValue Parameter value
 * @param parameterName Parameter name
 *
 */
-(void)setQueryParameterValue:(NSString*)parameterValue forName:(NSString*)parameterName;

/**
 *
 * Returns header names as an array of strings
 *
 */
-(NSArray*)headerNames;

/**
 *
 * Returns header name as an array of strings
 * 
 * For a single header name, there can be several values separated by commas. 
 * If there is only one value, the method returns an array with one element.
 * @param name Header name
 *
 */
-(NSArray*)headersForName:(NSString*)name;

/**
 *
 * Returns first header with matching name
 * @param name name of the header
 *
 */
-(NSString*)headerForName:(NSString*)name;

/**
 *
 * Sets the header for the request 
 *
 * If a header with the same name already exists, it is overridden.
 * <p>
 * Note: The header name is case insensitive.
 * @param value Header value
 * @param name Header name
 *
 */
-(void)setHeaderValue:(NSObject*)value forName:(NSString*)name;

/**
 *
 * Adds the header to the request 
 *
 * If a header with the same name already exists, the values are concatenated and separated by commas.
 * <p>
 * Note: The header name is case insensitive.
 * @param value Header value
 * @param name Header name
 *
 */
-(void)addHeaderValue:(NSObject*)value forName:(NSString*)name;

/**
 *
 * Removes the header from the request
 * @param name Header name
 *
 */
-(void)removeHeadersForName:(NSString*)name;

/**
 *
 * Sends a request and uses the <code>completionHandler</code> block to handle the response
 * @param completionHandler (void(^) (WLResponse* response, NSError* error)) Block that is triggered when a response has been received.
 *
 */
-(void)sendWithCompletionHandler:(void(^) (WLResponse* response, NSError* error))completionHandler;

/**
 *
 * Sends a request and uses a delegate to handle the response
 * @param delegate Delegate that conforms to both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols
 * Note: The delegate must implement both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols.
 *
 */
-(void)sendWithDelegate:(id)delegate;

/**
 *
 * Sends a request with the provided text as a request body and uses a <code>completionHandler</code> block to handle the response
 * @param body Request body 
 * @param completionHandler (void(^) (WLResponse* response, NSError* error)) Block that is triggered when a response has been received
 * Note: Using methods other than POST or PUT will omit the request body.
 *
 */
-(void)sendWithBody:(NSString*)body
         completionHandler:(void(^) (WLResponse* response, NSError* error))completionHandler;

/**
 *
 * Sends a request with the provided text as a request body and uses a delegate to handle the response
 * @param body Request body
 * @param delegate Delegate that conforms to both NSURLConnectionDataDelegate and NSURLConnectionDelegate protocols
 * Note: The delegate must implement both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols.
 * Note: Using methods other than POST or PUT will omit the request body.
 *
 */
-(void)sendWithBody:(NSString*)body delegate:(id)delegate;

/**
 *
 * Sends a request with form parameters as a request body and uses a <code>completionHandler</code> block to handle the response
 * @param bodyParameters Dictionary of form parameters
 * @param completionHandler (void(^) (WLResponse* response, NSError* error)) Block that is triggered when a response has been received
 * Note: Using methods other than POST or PUT will omit the request body.
 *
 */
-(void)sendWithFormParameters:(NSDictionary*)formParameters
        completionHandler:(void(^) (WLResponse* response, NSError* error))completionHandler;

/**
 *
 * Sends a request with form parameters as a request body and uses a delegate to handle the response
 * @param bodyParameters Dictionary of form parameters
 * @param delegate Delegate that conforms to both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols
 * Note: The delegate must implement both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols.
 * Note: Using methods other than POST or PUT will omit the request body.
 *
 */
-(void)sendWithFormParameters:(NSDictionary*)formParameters delegate:(id)delegate;

/**
 *
 * Sends a request with the provided JSON and uses a <code>completionHandler</code> block to handle the response
 * @param json JSON as a dictionary
 * @param completionHandler (void(^) (WLResponse* response, NSError* error)) Block that is triggered when a response has been received
 * Note: Using methods other than POST or PUT will omit the request body.
 *
 */
-(void)sendWithJSON:(NSDictionary*)json
  completionHandler:(void(^) (WLResponse* response, NSError* error))completionHandler;

/**
 *
 * Sends a request with the provided JSON and uses a delegate to handle the response
 * @param json JSON as a dictionary
 * @param delegate Delegate that conforms to both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols
 * Note: The delegate must implement both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols.
 * Note: Using methods other than POST or PUT will omit the request body.
 *
 */
-(void)sendWithJSON:(NSDictionary*)json delegate:(id)delegate;

/**
 *
 * Sends a request with the provided request data and uses <code>completionHandler</code> block to handle the response
 * @param data Request data
 * @param completionHandler (void(^) (WLResponse* response, NSError* error)) Block that is triggered when a response has been received
 * Note: Using methods other than POST or PUT will omit the request body.
 *
 */
-(void)sendWithData:(NSData*)data
  completionHandler:(void(^) (WLResponse* response, NSError* error))completionHandler;

/**
 *
 * Sends a request with the provided request data and uses a delegate to handle the response
 * @param data Request data
 * @param delegate Delegate that conforms to both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols
 * Note: The delegate must implement both <code>NSURLConnectionDataDelegate</code> and <code>NSURLConnectionDelegate</code> protocols.
 * Note: Using methods other than POST or PUT will omit the request body
 *
 */
-(void)sendWithData:(NSData*)data delegate:(id)delegate;

//-(void)abort;

@end
