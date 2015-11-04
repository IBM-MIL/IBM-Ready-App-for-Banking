/*
* Licensed Materials - Property of IBM
* 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/

//
//  DirectUpdateProgressView.h
//
//  Created by Arik Shifer on 4/13/14.
//
//

#import <UIKit/UIKit.h>

@interface WLProgressView : UIView
/**
 The ratio to resize the WLProgressView relative to its super view.
 */
@property(nonatomic, assign) CGSize progressViewResizeRatio;
/**
 The vertical offset factor to position the WLProgressView relative to its superview. The default value is 0 meaning that the WLProgressView is centered relative to its superview.
 */
@property(nonatomic, assign) CGFloat progressViewVerticalPositionOffsetFactor;

/**
 The ratio to resize the progress-bar relative to its superview.
 */
@property(nonatomic, assign) CGSize progressBarResizeRatio;
/**
 The vertical offset to position the status label relative to its superview.
 */
@property(nonatomic, assign) CGFloat statusLabelVerticalPositionOffset;
/**
 The progress bar
 */
@property(nonatomic, strong) UIProgressView* progressBar;
/**
 The status label
 */
@property(nonatomic, strong) UILabel* statusLabel;

/**
 Initializes and returns a newly allocated WLProgressView object as child view of the specified view.
 @param view the parent view
 */
- (id)initWithParentView:(UIView*) view;

/**
 Remove the WLProgressView and releases its resources
 */
- (void)hide;
@end
