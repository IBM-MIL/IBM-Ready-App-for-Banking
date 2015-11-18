/*
 *  Licensed Materials - Property of IBM
 *  5725-I43 (C) Copyright IBM Corp. 2011, 2013. All Rights Reserved.
 *  US Government Users Restricted Rights - Use, duplication or
 *  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

//
//  WLUserCertAuth.h
//  WorklightStaticLibProject
//
//  Created by Lizet Ernand on 10/1/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//


/**
 * This class provides some methods that can be used for the configuration of the
 * X509 User Certificate Enrollment and Authentication feature.
 */
@interface WLUserCertAuth : NSObject

/**
 * Cleans User Certificate Credentials from KeyChain
 *
 *  @return return the true if successfully removed User Certificate credentials from the keyChain
 */
+ (BOOL) deleteUserCertificateCredentials;

@end
