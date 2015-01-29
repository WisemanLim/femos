//
//  JoinView.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractiveLoadingView.h"

@protocol JoinViewDelegate;

@interface JoinView : UIImageView

@property (nonatomic, assign) id<JoinViewDelegate> delegate;
@property (nonatomic, retain) UIWebView* webView;
@property (nonatomic, retain) InteractiveLoadingView* interactiveLoadingView;

@end


@protocol JoinViewDelegate <NSObject>
@optional
- (void)didStartToLoadPage:(JoinView*)joinView;
- (void)didFinishToLoadPage:(JoinView*)joinView;
@end
