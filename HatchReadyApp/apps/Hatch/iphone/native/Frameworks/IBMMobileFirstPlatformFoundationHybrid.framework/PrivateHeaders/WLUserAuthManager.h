/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

//
//  WLUserAuthManager.h
//  WorklightStaticLibProject
//

#import <Foundation/Foundation.h>

@interface WLUserAuthManager : NSObject

/**
 * Get the alias used for client user x509 certificate.
 */
+ (NSString *) getAlias;

/**
 * Get certififacte Label as used when saved in keychain.
 */
+ (NSData *) getCertificateIdentifier;

/**
 * Get private/public key Label as used when saved in keychain.
 */
+ (NSData *) getKeyIdentifier:(BOOL)isPublic;

/**
 * Checks to see if a user auth certificate exists in the keychain and that it is a valid certificate.
 */
+(BOOL) doesValidCertificateExist;

/**
 * Cleans User Cert Credential from KeyChain
 */
+ (BOOL) clearUserCertCredentialsFromKeyChain;

@end

