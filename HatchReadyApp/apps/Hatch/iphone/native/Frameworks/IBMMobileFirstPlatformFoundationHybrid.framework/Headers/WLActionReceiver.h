/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

//
//  WLActionReceiver.h
//  WorklightStaticLibProject
//
//  Created by Anton Aleksandrov on 16/03/14.
//

#import <Foundation/Foundation.h>

/**
 * @ingroup hybrid main
 * The WLActionReceiver protocol allows every implementing object to receive actions and data from the IBM MobileFirst Platform Framework
 */
@protocol WLActionReceiver <NSObject>

/**
 * Any object can receive actions. To do so, it must implement the following protocol. 
 *
 * Actions will always be delivered on a background thread. 
 * If you want to update the application user interface from the received action, you must do so on a main user interface thread, 
 * for example by using the performSelectorOnMainThread API.
*/ 
-(void)onActionReceived:(NSString *)action withData:(NSDictionary*) data;

@end
