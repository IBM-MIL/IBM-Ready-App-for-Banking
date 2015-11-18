/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

//
//  PersistentCookieManagerPrivate.h
//  WorklightStaticLibProject
//
//  Created by Lizet Ernand on 3/12/14.
//  Copyright (c) 2014 odedr@worklight.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLPersistentCookieManager ()

 + (NSHTTPCookie*)retrieveCookie:(NSString*)cookieName;
 + (BOOL)storeCookie:(NSHTTPCookie*)cookie;
 + (BOOL)deleteCookie:(NSString*)cookieName;


@end


