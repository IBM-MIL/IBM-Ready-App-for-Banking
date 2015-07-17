/*
 Licensed Materials - Property of IBM
 © Copyright IBM Corporation 2015. All Rights Reserved.
 */
#import "MQALogger+MQASwiftSupport.h"

@implementation MQALogger (MQASwiftSupport)
+ (void)log:(NSString*)message
{
    [self log:message withLevel:MQALogLevelInfo];
}
+ (void)log:(NSString*)message withLevel:(MQALogLevel)level
{
    [MQALogger logWithLevel:level tag:nil line:nil fileName:nil method:nil stacktrace:nil format:message];
}
+ (void)mqa_sendFeedback:(NSString*)feedback
{
    //[MQALogger sendFeedback:feedback];
}
+ (void)mqa_feedback:(NSString*)title
{
    //[MQALogger feedback:title];
}
+ (void)mqa_feedback:(NSString*)title placeholder:(NSString*)placeholder
{
    //[MQALogger feedback:title placeholder:placeholder];
}
@end