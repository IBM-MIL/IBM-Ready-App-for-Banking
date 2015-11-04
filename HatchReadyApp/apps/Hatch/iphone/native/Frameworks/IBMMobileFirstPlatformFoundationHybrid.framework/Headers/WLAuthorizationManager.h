/*
 * Licensed Materials - Property of IBM
 * 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */


#import <Foundation/Foundation.h>
#import "WLResponse.h"


 
typedef NS_ENUM(NSInteger, WLAuthorizationPerisistencePolicy) {
    WLAuthorizationPerisistencePolicyAlways = 0,
    WLAuthorizationPerisistencePolicyNever = 1
};

extern NSString * const ERROR_OAUTH_PREVENT_REDIRECT;
extern NSString * const ERROR_OAUTH_CANCELED;

/**
 * @ingroup main
 * This class manages the entire OAuth flow, from client registration to token generation.
 */
@interface WLAuthorizationManager : NSObject 
/**
 *  Gets the cached authorization header from the keychain.
 */
@property (nonatomic, readonly) NSString *cachedAuthorizationHeader;

/**
 *  User identity dictionary
 *  Keys: <code>id</code>, <code>authBy</code>, <code>displayName</code>
 */
@property (nonatomic, readonly) NSDictionary *userIdentity;

/**
 *  Device identity dictionary
 *  Keys: <code>id</code>, <code>model</code>, <code>osVersion</code>, <code>platform</code>
 */
@property (nonatomic, readonly) NSDictionary *deviceIdentity;

/**
 *  App identity dictionary
 *  Keys: <code>id</code>, <code>version</code>, <code>environment</code>
 */
@property (nonatomic, readonly) NSDictionary *appIdentity;

/**
 *  Gets the <code>WLAuthorizationManager</code> shared instance
 *
 *  @return <code>WLAuthorizationManager</code> shared instance
 */
+ (WLAuthorizationManager *) sharedInstance;
 
/**
 *  Explicit call to obtain the access token.
 *
 *  @param completionHandler Completion handler with response containing the authorization header value.
 *
 *  @param scope OAuth scope that the resource requires.
 */
- (void) obtainAuthorizationHeaderForScope:(NSString*)scope completionHandler:(void(^) (WLResponse* response, NSError* error))completionHandler;

/**
 *  Adds the authorization header value to any <code>NSURLRequest</code> request
 *
 *  @param request Request
 */
- (void) addCachedAuthorizationHeaderToRequest:(NSMutableURLRequest*)request;

/**
 *  Sets the authorization policy that defines the way the application handles storing of authorization access tokens.
 *
 *  @deprecated In MobileFirst Platform 7.1, persisting authorization headers on the client side has no effect, since the MobileFirst server persists the security data across sessions.
 *  @param policy Persistence policy.
 *  The policy can be one of the following:
 *	<ul>
 *  <li><code>__WLAuthorizationPerisistencePolicyAlways__</code>:
 *  Always store access token on the device (least secure option).
 *	The access tokens are persisted, regardless of whether Touch ID is present, supported, or enabled. 
 *  Touch ID and device passcode authentication are never required.</li>
 *  <li><code>__WLAuthorizationPerisistencePolicyNever__</code>:
 *  Never store access token on the device (most secure option).
 *	The access tokens are never persisted, meaning that an access token is valid for a single app session only.</li>
 *  </ul>
 *  The default policy is <code>__WLAuthorizationPerisistencePolicyAlways__</code>.
 *  <p>
 *  Examples of use:
 *  
 *  Set <code>__WLAuthorizationPerisistencePolicyAlways__</code> policy:<br />
 *          <pre><code>WLAuthorizationManager* manager = [WLAuthorizationManager sharedInstance];
 *          [manager setAuthorizationPersistencePolicy: WLAuthorizationPerisistencePolicyAlways];</code></pre>
 *  <p>
 *  Set <code>__WLAuthorizationPerisistencePolicyNever__</code> policy:<br />
 *          <pre><code>WLAuthorizationManager* manager = [WLAuthorizationManager sharedInstance];
 *          [manager setAuthorizationPersistencePolicy: WLAuthorizationPerisistencePolicyNever];</code></pre>
 */
- (void) setAuthorizationPersistencePolicy: (WLAuthorizationPerisistencePolicy) policy;

/**
 *  Checks whether the response is a MobileFirst OAuth error.
 *
 *  @param NSURLResponse response
 *
 *  @return true if the response is a MobileFirst OAuth error, or false otherwise.
 */
- (BOOL) isAuthorizationRequiredForResponse:(NSURLResponse *)response;

/**
 * Checks whether the response is a MobileFirst OAuth error.
 *
 * @param status HTTP status
 *
 * @param headers <code>NSDictionary</code> of response headers
 
 * @return true if the response is a MobileFirst OAuth error, or false otherwise.
 */

- (BOOL) isAuthorizationRequiredForResponseWithStatus:(NSInteger)status authorizationHeader:(NSString *) authorizationHeader;

/**
 *  Gets the scope of the response from a protected resource
 *
 *  @param response Response returned from protected resource
 *
 *  @return Scope that is returned in the <code>WWW-Authenticate</code> header
 */
- (NSString *) authorizationScopeForResponse : (NSURLResponse *) response;


/**
 *  Gets the scope of the response from a protected resource
 *
 *  @param NSDictionary Response headers
 *
 *  @return Scope that is returned in the <code>WWW-Authenticate</code> header
 */
- (NSString*) authorizationScopeForResponseWithAuthorizationHeader:(NSString *) authorizationHeader;
@end
