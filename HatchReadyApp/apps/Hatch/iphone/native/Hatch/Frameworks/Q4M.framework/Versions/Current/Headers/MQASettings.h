//  Copyright 2014 Applause. All rights reserved.

#import "APLSetting.h"


typedef NS_ENUM(NSInteger, MQAMode)
{
    MQAModeQA,
    MQAModeSilent DEPRECATED_MSG_ATTRIBUTE("Silent Mode is equal to Market Mode"),
    MQAModeMarket
};

/**
* Anonymous login name - you can set it as defaultUser parameter.
*/
FOUNDATION_EXPORT NSString *const MQAAnonymousUser;

@interface MQASettings : NSObject <APLSetting>

@property(nonatomic) MQAMode mode;

@end
