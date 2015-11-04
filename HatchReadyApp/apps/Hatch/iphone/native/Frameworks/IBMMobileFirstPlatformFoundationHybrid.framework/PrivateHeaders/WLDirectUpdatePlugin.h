/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

//
//  WLDirectUpdatePlugin.h
//  WorklightStaticLibProject
//
//  Created by Yulian Vurgaft on 3/27/14.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "WLDirectUpdateManager.h"
#import "WLDirectUpdatePluginCallbackDelegate.h"
#import "WLProgressView.h"

@interface WLDirectUpdatePlugin : CDVPlugin <WLDirectUpdatePluginCallbackDelegate>{
}

@property (nonatomic, strong) WLProgressView* progressView;

- (void)start:(CDVInvokedUrlCommand *)command;

- (void)stop:(CDVInvokedUrlCommand *)command;

- (void)showProgressDialog:(CDVInvokedUrlCommand *)command;

- (void)hideProgressDialog:(CDVInvokedUrlCommand *)command;

- (void)updateProgressDialog:(CDVInvokedUrlCommand *)command;

@end
