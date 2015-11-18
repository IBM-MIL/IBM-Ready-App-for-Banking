/*
* Licensed Materials - Property of IBM
* 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/

//
//  NativePage.h
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface NativePage : CDVPlugin
{
	@private
    NSMutableDictionary* controllerObjects;
    @private
    id showWebViewObserver;
}

@property (nonatomic, strong) NSMutableDictionary *controllerObjects;

/**
 Returning control to the web view from an Objective-C page
 
 To switch back to the web view, follow these instructions.
 
 Before you begin
 The native page must be implemented as an Objective-C class that inherits from UIViewController. This UIViewController class must be able to initialize through the init method alone. The initWithNibName:bundle: method is never called on this class instance.
 Procedure
 In the native page, call the [NativePage showWebView:] method and pass it an NSDictionary object (the object can be empty). This NSDictionary can be structured with any hierarchy. The IBM® Worklight® runtime framework encodes it in JSON format, and then sends it as the first argument to the JavaScript callback function.
 
 @param data The data to pass from the native page back to the web view
 */
+(void)showWebView:(NSDictionary *)data;
@end
