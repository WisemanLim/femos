//
//  CheckView.h
//  MSF
//
//  Created by delta829 on 12. 9. 29..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractiveLoadingView.h"

@protocol CheckViewDelegate;


@interface CheckView : UIImageView

@property (nonatomic, assign) id<CheckViewDelegate> delegate;
@property (nonatomic, retain) UIWebView* webView;
@property (nonatomic, retain) InteractiveLoadingView* interactiveLoadingView;

@end


@protocol CheckViewDelegate <NSObject>
@optional
- (void)didStartToLoadPage:(CheckView*)checkView;
- (void)didFinishToLoadPage:(CheckView*)checkView;
@end
