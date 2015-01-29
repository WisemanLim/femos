//
//  EvaluateView.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluateToolbar.h"

@protocol EvaluateViewDelegate;

@interface EvaluateView : UIImageView

@property (nonatomic, assign) id<EvaluateViewDelegate> delegate;
@property (nonatomic, readonly) UIWebView* webView;
@property (nonatomic, readonly) EvaluateToolbar* evaluateToolbar;

- (void)goUrl:(NSURL*)url;

- (void)showNonInteractiveLoadingViewWithMsg:(NSString*)msg;
- (void)hideNonInteractiveLoadingView;

@end


@protocol EvaluateViewDelegate <NSObject>
@optional
- (void)didStartToLoadPage:(EvaluateView*)evaluateView;
- (void)didFinishToLoadPage:(EvaluateView*)evaluateView;
@end
