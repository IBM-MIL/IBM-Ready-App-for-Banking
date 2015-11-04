/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */
//
//  WLWebFrameworkInitResult.h
//  WorklightStaticLibProject
//
//

#import <Foundation/Foundation.h>

/**
 @ingroup hybrid main
 An enumeration of IBM MobileFirst Platform web framework initalization status codes.
 */
typedef enum {
    WLWebFrameworkInitResultSuccess, /** Successful initialization. Web resources are ready to be used */
    WLWebFrameworkInitResultFailureCheksum, /** Initialization failed because the checksum check was unsuccessful. */
    WLWebFrameworkInitResultFailureUnzip, /** Initialization failed because web resources extraction was unsuccessful. */
    WLWebFrameworkInitResultFailureNotEnoughSpace, /** Initialization failed because there is not enough space on the device. */
    WLWebFrameworkInitResultFailureInternal /** Initialization failed due to an internal error. */
} StatusCode;

/**
 * @ingroup hybrid main
 *
 * The result object containing information about the IBM MobileFirst Platform web framework initialization status.
 *.
 */
@interface WLWebFrameworkInitResult : NSObject

- (id)initWithStatusCode:(StatusCode)statusCode message:(NSString *)message data:(NSDictionary*) data;


//properties
/**
 @property statusCode The IBM MobileFirst Platform web framework initalization status code.
 
 */
@property (nonatomic, assign, readonly) StatusCode statusCode;

/** @property message
 *  The IBM MobileFirst Platform web framework initalization message.
 **/
@property (nonatomic, copy, readonly)   NSString* message;

/** @property data
 *  Additional web framework initialization data, e.g. the amount of required space on the device.
 *  When the StatusCode WLWebFrameworkInitResultFailureNotEnoughSpace is returned, accessing the data dictionary with the string "spaceRequired" as key returns the amount of required space, in bytes.
 */
@property (nonatomic, strong, readonly) NSDictionary* data;

@end
