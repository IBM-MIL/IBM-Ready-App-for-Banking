//  Copyright 2014 Applause. All rights reserved.

#import <Foundation/Foundation.h>

@protocol APLSetting <NSObject, NSCoding>

/**
 * This value you get from your application webpage.
 */
@property(nonatomic, strong) NSString *applicationId;

/**
 * Version name that is used by framework. It is using CFBundleShortVersionString by default.
 */
@property(nonatomic, strong) NSString *applicationVersionName;

/**
 * Version code that is used by framework. It is using CFBundleVersion by default.
 */
@property(nonatomic, strong) NSString *applicationVersionCode;

/**
 * This will set default user. With this set on there will be no login screen.
 */
@property(nonatomic, strong) NSString *defaultUser;

/**
 * This will enable/disable shake gesture to report a problem. It is enabled by default.
 */
@property(nonatomic, getter=isReportOnShakeEnabled) BOOL reportOnShakeEnabled;

/**
 * Enable this flag to alter framework screen capturing method. When set to True, framework will use system screenshots (stored in the device's gallery)
 * In order to report bugs in such a mode, system screenshot needs to be created first.
 * It is disabled by default.
 */
@property(nonatomic) BOOL screenShotsFromGallery;

/**
 * Trap fatal signals via a Mach exception server. By default framework is using BSD signal handler.
 * More at https://www.plcrashreporter.org/documentation/api/v1.2-beta1/mach_exceptions.html
 * It is disabled by default.
 *
 * @warning The Mach exception handler executes in-process, and will interfere with debuggers. It should not be used with debugging set on!
 */
@property(nonatomic, getter=isMathExceptionEnabled) BOOL machExceptionEnabled;

/**
 * URL address of the target Server.
 */
@property(nonatomic, strong) NSString *serverURL;

/**
 * Only for Market Mode!
 * Enable it when you want to send all NSLog (NSLogv also) calls to the server.
 *
 * @warning This function uses private API so it may not work on all system versions.
 */
@property(nonatomic) BOOL sendAllNSLogToServer;

@end
