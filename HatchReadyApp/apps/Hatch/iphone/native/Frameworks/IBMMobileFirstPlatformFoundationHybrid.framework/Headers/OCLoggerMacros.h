/*
 *  Licensed Materials - Property of IBM
 *  5725-I43 (C) Copyright IBM Corp. 2011, 2013. All Rights Reserved.
 *  US Government Users Restricted Rights - Use, duplication or
 *  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

#import "OCLogger.h"
#import "OCLogger+Constants.h"

#define OCLoggerTrace(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } trace:s, ##__VA_ARGS__];

#define OCLoggerDebug(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } debug:s, ##__VA_ARGS__];

#define OCLoggerLog(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } log:s, ##__VA_ARGS__];

#define OCLoggerInfo(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } info:s, ##__VA_ARGS__];

#define OCLoggerWarn(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } warn:s, ##__VA_ARGS__];

#define OCLoggerError(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C, KEY_METADATA_STACKTRACE : [NSThread callStackSymbols] } error:s, ##__VA_ARGS__];

#define OCLoggerFatal(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } fatal:s, ##__VA_ARGS__];

#define OCLoggerAnalytics(s, ...) [[OCLogger getInstanceWithPackage:WORKLIGHT_PACKAGE] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } analytics:s, ##__VA_ARGS__];

// Log with package

#define OCLoggerTraceWithPackage(p, s, ...) [[OCLogger getInstanceWithPackage:p] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } trace:s, ##__VA_ARGS__];

#define OCLoggerDebugWithPackage(p, s, ...) [[OCLogger getInstanceWithPackage:p] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } debug:s, ##__VA_ARGS__];

#define OCLoggerLogWithPackage(p, s, ...) [[OCLogger getInstanceWithPackage:p] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } log:s, ##__VA_ARGS__];

#define OCLoggerInfoWithPackage(p, s, ...) [[OCLogger getInstanceWithPackage:p] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } info:s, ##__VA_ARGS__];

#define OCLoggerWarnWithPackage(p, s, ...) [[OCLogger getInstanceWithPackage:p] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } warn:s, ##__VA_ARGS__];

#define OCLoggerErrorWithPackage(p, s, ...) [[OCLogger getInstanceWithPackage:p] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } error:s, ##__VA_ARGS__];

#define OCLoggerFatalWithPackage(p, s, ...) [[OCLogger getInstanceWithPackage:p] metadata:@{KEY_METADATA_METHOD : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__], KEY_METADATA_LINE : @__LINE__, KEY_METADATA_FILE : [[NSString stringWithUTF8String:__FILE__] lastPathComponent], KEY_METADATA_SOURCE : SOURCE_OBJECTIVE_C } fatal:s, ##__VA_ARGS__];