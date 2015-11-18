/*
 *  Licensed Materials - Property of IBM
 *  5725-I43 (C) Copyright IBM Corp. 2011, 2013. All Rights Reserved.
 *  US Government Users Restricted Rights - Use, duplication or
 *  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */
//
//  IBMMobileFirstPlatformFoundationHybrid.h
//  IBMMobileFirstPlatformFoundationHybrid
//
//  Created by C A on 3/19/15.
//  Copyright (c) 2015 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for IBMMobileFirstPlatformFoundationHybrid.
FOUNDATION_EXPORT double IBMMobileFirstPlatformFoundationHybridVersionNumber;

//! Project version string for IBMMobileFirstPlatformFoundationHybrid.
FOUNDATION_EXPORT const unsigned char IBMMobileFirstPlatformFoundationHybridVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IBMMobileFirstPlatformFoundationHybrid/PublicHeader.h>


#import <IBMMobileFirstPlatformFoundationHybrid/WLUserCertAuth.h>
#import <IBMMobileFirstPlatformFoundationHybrid/MFPMainViewController.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLResourceRequest.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLAuthorizationManager.h>
#import <IBMMobileFirstPlatformFoundationHybrid/BaseProvisioningChallengeHandler.h>
#import <IBMMobileFirstPlatformFoundationHybrid/OCLoggerMacros.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLTrusteer.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLSimpleDataSharing.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLSecurityUtils.h>
#import <IBMMobileFirstPlatformFoundationHybrid/JSONStoreQueryOptions.h>
#import <IBMMobileFirstPlatformFoundationHybrid/JSONStoreQueryPart.h>
#import <IBMMobileFirstPlatformFoundationHybrid/JSONStoreAddOptions.h>
#import <IBMMobileFirstPlatformFoundationHybrid/JSONStoreCollection.h>
#import <IBMMobileFirstPlatformFoundationHybrid/JSONStoreOpenOptions.h>
#import <IBMMobileFirstPlatformFoundationHybrid/JSONStore.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWebFrameworkInitResult.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLAppDelegate.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WL.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLCallbackFactory.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractWifiAreaTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractWifiDwellTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractWifiFilterTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractGeoDwellTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractGeoAreaTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AcquisitionFailureCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AcquisitionCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractAcquisitionError.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractPosition.h>
#import <IBMMobileFirstPlatformFoundationHybrid/AbstractTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoDwellInsideTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoDwellOutsideTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoEnterTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoExitTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoPositionChangeTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLArea.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLCircle.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLCoordinate.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoAcquisitionPolicy.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoError.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoFailureCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoPosition.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLGeoUtils.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLPolygon.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiConnectTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiDisconnectTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiDwellInsideTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiDwellOutsideTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiEnterTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiExitTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiVisibleAccessPointsChangeTrigger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiAccessPoint.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiAccessPointFilter.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiAcquisitionCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiAcquisitionPolicy.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiConnectedCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiError.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiFailureCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLWifiLocation.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLAcquisitionFailureCallbacksConfiguration.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLAcquisitionPolicy.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLConfidenceLevel.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLDevice.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLDeviceContext.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLEventTransmissionPolicy.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLLocationServicesConfiguration.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLTriggerCallback.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLTriggersConfiguration.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLAnalytics.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLCookieExtractor.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLClient.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLFailResponse.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLDelegate.h>
#import <IBMMobileFirstPlatformFoundationHybrid/NativePage.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLCordovaAppDelegate.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLProcedureInvocationData.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLProcedureInvocationResult.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLResponse.h>
#import <IBMMobileFirstPlatformFoundationHybrid/OCLogger.h>
#import <IBMMobileFirstPlatformFoundationHybrid/BaseChallengeHandler.h>
#import <IBMMobileFirstPlatformFoundationHybrid/ChallengeHandler.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLActionReceiver.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLChallengeHandler.h>
#import <IBMMobileFirstPlatformFoundationHybrid/BaseDeviceAuthChallengeHandler.h>
#import <IBMMobileFirstPlatformFoundationHybrid/CDVAppDelegate.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLDeviceAuthManager.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLPush.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLPushOptions.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLResponseListener.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLEventSourceListener.h>
#import <IBMMobileFirstPlatformFoundationHybrid/WLOnReadyToSubscribeListener.h>