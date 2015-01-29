//
//  MainView.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainViewDelegate;

@interface MainView : UIImageView

@property (nonatomic, assign) id<MainViewDelegate> delegate;

@end


@protocol MainViewDelegate <NSObject>
@optional
- (void)didClickJoinButtonOfMainView:(MainView*)mainView;
- (void)didClickEvaluateButtonOfMainView:(MainView*)mainView;
- (void)didClickReportButtonOfMainView:(MainView*)mainView;
- (void)didClickCheckButtonOfMainView:(MainView*)mainView;
@end