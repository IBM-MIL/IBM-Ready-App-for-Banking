/*
* Licensed Materials - Property of IBM
* 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/

//
//  WLCordovaAppDelegate.h
//  Worklight SDK
//

#import <UIKit/UIKit.h>
#import "WLAppDelegate.h"
#import "WL.h"
#import <Cordova/CDVViewController.h>

/**
 WLCordovaAppDelegate is the base IBM MobileFirst Platform hybrid application class implementing the UIApplicationDelegate protocol.
 When developing an IBM MobileFirst Platform hybrid application you should extend the WLCordovaAppDelegate class to utilize the IBM MobileFirst Platform framework API.
 
 @deprecated in Worklight version 6.2. To simplify usage of native code in app startup and runtime, replace deprecated class WLCordovaAppDelegate with class WLAppDelegate according to the product documentation describing how to migrate your application.
 */
__attribute__((deprecated))
@interface WLCordovaAppDelegate : WLAppDelegate < WLInitWebFrameworkDelegate, UIAlertViewDelegate > {
}

/** This method can be used instead of application:didLaunchingWithOptions for application
 initialization IF some other delegate superclass is receiving the application:didLaunchingWithOptions
 message to do some pre-requisite initialization (such as a secure container authorization).
 The superclass will return to iOS, and then at some later point (such as when secure container
 authorization is successful) should invoke this method.
 @deprecated in Worklight version 6.2. To simplify usage of native code in app startup and runtime, replace deprecated class WLCordovaAppDelegate with class WLAppDelegate according to the product documentation describing how to migrate your application.*/
- (BOOL)appStart:(UIApplication *)application withOptions:(NSDictionary *)launchOptions __attribute__((deprecated));

/**
 The CDVViewController property is maintained for backward compatibility.
 @property viewController The Cordova view controller.
 */
@property (nonatomic, strong) IBOutlet CDVViewController* viewController;

@end

