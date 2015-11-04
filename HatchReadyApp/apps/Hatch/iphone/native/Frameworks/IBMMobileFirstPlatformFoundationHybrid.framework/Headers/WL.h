/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

//
//  WL.h
//  WorklightStaticLibProject
//
//

#import <Foundation/Foundation.h>
#import "WLWebFrameworkInitResult.h"
#import "WLActionReceiver.h"
#import "WLClient.h"

#pragma mark -
#pragma mark - WL public API
/**
 * @ingroup hybrid main
 *
 * The WLInitWebFrameworkDelegate protocol declares the method wlInitWebFrameworkDidCompleteWithResult.
 * This method provides information about the result of the IBM MobileFirst Platform web framework initialization.
 *
 */
@protocol WLInitWebFrameworkDelegate <NSObject>
@required
/**
 *
 * This method is called after the IBM MobileFirst Platform web framework initialization is complete and web resources are ready to be used.
 *
 *@param WLWebFrameworkInitResult: result The initialization result
 */
-(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result;
@end
/**
 * @ingroup hybrid main
 *
 * The WL singleton class provides a centralized point of control and coordination for IBM MobileFirst Platform hybrid apps.
 * A major role of this class is to handle the initialization of a IBM MobileFirst Platform hybrid application.
 *
 */
@interface WL : NSObject
/**
 * Get the singleton instance
 */
+ (id)sharedInstance;

/** Initialize the IBM MobileFirst Platform web framework
 
 @param delegate The delegate conforming to the WLInitWebFrameworkDelegate protocol
 */
-(void) initializeWebFrameworkWithDelegate :(id<WLInitWebFrameworkDelegate>)delegate;
/**
 * This method returns the path to the application main HTML file.
 @attention This API should be used after the successful callback of wlInitWebFrameworkDidCompleteWithResult. This is to ensure that the IBM MobileFirst Platform framework initialization is complete and the web resources are ready to be used.
 *
 * @Returns the URL of the main HTML file
 */
-(NSString *) mainHtmlFilePath;
/**
 * This method will show a splash screen on-top of the current window.
 * IBM MobileFirst Platform default application will show a splash screen during application start-up, and will hide it using the JavaScript API WL.App.hideSplashScreen(), once the main html page is loaded.
 * This is done to improve the user experience and allow smooth transition from the native application container to the WebView, hiding the underlying page loading activity.
 * This method will use the launch images supplied in the application XCode project.
 * This method is not related to the splash screen feature which is available through the Cordova framework. 
 
   @attention A root view controller must be defined before calling this method.
 */
-(void) showSplashScreen;
/**
 * Hides a shown splash screen.
 *
 */
-(void) hideSplashScreen;

/**
 * Sends action to JavaScript action receivers. 
 * 
 * Note: if there are no JavaScript action receivers registered, the action is queued until a JavaScript action receiver is registered. 
 * 
 * @param action custom string representing an action
*/
-(void)sendActionToJS:(NSString*)action;

/**
 * Sends action and optional data object to JavaScript action receivers.
 *
 * Note: if there are no JavaScript action receivers registered, the action is queued until a JavaScript action receiver is registered.
 * @param action custom string representing an action
 * @param data (optional) custom NSDictionary instance containing key-value pairs
 * <p>
 * Example:
 * </p>
 * <pre> <code>
 * [[WL sharedInstance] sendActionToJS:@"doSomething"];
 * NSMutableDictionary *data = [NSDictionary dictionaryWithObject:@"12345" forKey:@"customData"];
 * [[WL sharedInstance] sendActionToJS:@"doSomething" data:data];
 * </code></pre>
*/
-(void)sendActionToJS:(NSString *)action withData:(NSDictionary*)data;

/**
 * Registers a new native action receiver with the Worklight framework.
 *
 * @param actionReceiver object that implements the WLActionReceiver protocol
 * @since IBM Worklight V6.2.0
 *
 * <p>
 * Example:
 * </p>
 * <pre> <code>
 * MyReceiver *myReceiver = [MyReceiver new];
 * [[WL sharedInstance] addActionReceiver:myReceiver];
 * </code></pre>
 */
-(void)addActionReceiver:(id<WLActionReceiver>)wlActionreceiver;

/**
 * Unregisters a receiver from receiving actions.
 * After calling this API, the receiver will no longer receive actions.
 *
 * @param actionReceiver object that implements the WLActionReceiver protocol
 *
 * <p>
 * Example:
 * </p>
 * <pre> <code>
 * MyReceiver *myReceiver = [MyReceiver new];
 * [[WL sharedInstance] removeActionReceiver:myReceiver];
 * </code></pre>
*/
-(void)removeActionReceiver:(id<WLActionReceiver>)wlActionreceiver;

/**
 * Sets the IBM MobileFirst Platform server URL to the specified URL
 * <p>
 * Changes the IBM MobileFirst Platform server URL to the new URL and cleans the HTTP client context.
 * After calling this method, the application is not logged in to any server.
 * Notes:
 * <ul>
 * <li>The responsibility for checking the validity of the URL is on the developer.
 * <li>For hybrid applications: This call does not clean the HTTP client context saved in JavaScript.
 * For hybrid applications, it is recommended to set the server URL by using the following JavaScript function: <code>WL.App.setServerUrl</code>.
 * <li>If the app uses push notification, it is the developer's responsibility to unsubscribe from the previous server and subscribe to the new server.
 * For more information on push notification, see <code>WLPush</code>.
 * </ul>
 *
 * Example:
 * <code>[[WL sharedInstance] setServerUrl:[NSURL URLWithString:@"http://9.148.23.88:10080/context"]];</code>
 *
 * @param url - The URL of the new server, including protocol, IP, port, and context.
 *
 */
- (void) setServerUrl: (NSURL*) url;

/**
 * Returns the current IBM MobileFirst Platform server URL
 *
 * @return IBM MobileFirst Platform server URL
 */
- (NSURL*) serverUrl;

@end

