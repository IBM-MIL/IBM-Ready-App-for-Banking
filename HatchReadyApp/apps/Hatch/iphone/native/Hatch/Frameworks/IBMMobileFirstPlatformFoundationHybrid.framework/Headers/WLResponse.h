/*
* Licensed Materials - Property of IBM
* 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/

//
//  WLResponse.h
//  Worklight SDK
//
//  Created by Benjamin Weingarten on 3/7/10.
//  Copyright (C) Worklight Ltd. 2006-2012.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLProcedureInvocationResult.h"

/**
 * @ingroup main
 *
 * This class contains the result of a procedure invocation. IBM MobileFirst Platform passes this class as an argument to the
 * delegate methods of <code>WLClient</code> <code>invokeProcedure</code> methods.
 */
@interface WLResponse : NSObject {
	NSInteger status;
	WLProcedureInvocationResult *invocationResult;
	NSObject *invocationContext;
	NSString *responseText;
}

/**
 * Retrieves the HTTP status from the response.
 */
@property (nonatomic) int status;

/**
 * Response data from the server.
 */
@property (nonatomic, strong) WLProcedureInvocationResult *invocationResult;

/**
 * Invocation context object passed when calling <code>invokeProcedure</code>.
 */
@property (nonatomic, strong) NSObject *invocationContext;

/**
 * Original response text from the server.
 */
@property (nonatomic, strong) NSString *responseText;

/**
 *  Retrieves the headers from the response.
 */
@property (nonatomic, strong) NSDictionary* headers;

/**
 * Original response data from the server.
 */
@property (readonly) NSData* responseData;

/**
 * Returns the value <code>NSDictionary</code> in case the response is a JSON response, otherwise it returns the value nil.
 */
@property (readonly) NSDictionary * responseJSON;

/**
 * Returns the value <code>NSDictionary</code> in case the response is a JSON response, otherwise it returns the value nil. 
 *
 * @param NSDictionary Root of the JSON object
 *
 * @deprecated This method is deprecated. Use the {@link responseJson} property instead.
 *
 **/
-(NSDictionary *)getResponseJson;

@end
