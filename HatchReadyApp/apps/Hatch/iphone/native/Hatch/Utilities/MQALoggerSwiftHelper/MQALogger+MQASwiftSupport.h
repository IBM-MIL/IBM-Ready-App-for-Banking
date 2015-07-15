/*
 Licensed Materials - Property of IBM
 © Copyright IBM Corporation 2015. All Rights Reserved.
 */

@interface MQALogger (MQASwiftSupport)
+ (void)log:(NSString*)message;
+ (void)log:(NSString*)message withLevel:(MQALogLevel)level;
+ (void)mqa_sendFeedback:(NSString*)feedback;
+ (void)mqa_feedback:(NSString*)title;
+ (void)mqa_feedback:(NSString*)title placeholder:(NSString*)placeholder;
@end
