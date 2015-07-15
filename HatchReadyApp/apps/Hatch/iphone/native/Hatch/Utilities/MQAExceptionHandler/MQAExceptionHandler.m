/*
 Licensed Materials - Property of IBM
 © Copyright IBM Corporation 2015. All Rights Reserved.
 */

#import <Foundation/Foundation.h>

void exceptionHandler(NSException* exception) {}
NSUncaughtExceptionHandler* exceptionHandlerPointer = &exceptionHandler;