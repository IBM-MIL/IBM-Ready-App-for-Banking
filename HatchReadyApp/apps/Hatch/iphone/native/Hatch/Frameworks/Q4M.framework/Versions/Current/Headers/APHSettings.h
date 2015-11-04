//  Copyright 2014 Applause. All rights reserved.

#import "APLSetting.h"

typedef NS_ENUM(NSInteger, APHSettingsMode)
{
    APHSettingsModeQA DEPRECATED_ATTRIBUTE,
    APHSettingsModeSilent DEPRECATED_ATTRIBUTE,
    APHSettingsModeMarket DEPRECATED_ATTRIBUTE
} DEPRECATED_ATTRIBUTE;

/**
* Anonymous login name - you can set it as defaultUser parameter.
*/
FOUNDATION_EXPORT NSString *const APHAnonymousUser DEPRECATED_ATTRIBUTE;

DEPRECATED_MSG_ATTRIBUTE("Use MQASettings class instead.")
@interface APHSettings : NSObject <APLSetting>

@property(nonatomic) BOOL withUTest DEPRECATED_ATTRIBUTE;

@property(nonatomic) APHSettingsMode apphanceMode DEPRECATED_MSG_ATTRIBUTE("Use MQASettings \"mode\" property.");

@property(nonatomic, getter=isReportOnDoubleSlideEnabled) BOOL reportOnDoubleSlideEnabled DEPRECATED_ATTRIBUTE;

@end
