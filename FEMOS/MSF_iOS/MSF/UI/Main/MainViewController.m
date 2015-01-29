//
//  MainViewController.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "MainViewController.h"

#import "SmartFestivalJoiner.h"
#import "JoinViewController.h"
#import "EvaluateViewController.h"
#import "ReportViewController.h"
#import "CheckViewController.h"

#define ALERT_VIEW_REJOIN_TAG   9614


@interface MainViewController() <MainViewDelegate, UIAlertViewDelegate>
@end


@implementation MainViewController

@synthesize mainView;

#pragma mark -
#pragma mark Life Cycle

- (void)loadView {
    [super loadView];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setOpaque:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
        
    mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [mainView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [mainView setDelegate:self];
    [self.view addSubview:mainView];
    
    [pool drain];
}

- (void)dealloc {
    [mainView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [DefaultSmartFestivalJoiner setIsRejoin:NO];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setOpaque:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Private Method

- (void)showNeedToJoinAlertView {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"먼저, 축제참여를 해주세요." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
    
    [alertView show];
    [alertView release];
}

- (void)showAlreadyJoinAlertView {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"이미 참여하셨습니다.\n다시 입력하시겠습니까?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"예", @"아니오", nil];
    [alertView setTag:ALERT_VIEW_REJOIN_TAG];
    
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == ALERT_VIEW_REJOIN_TAG) {
        if (buttonIndex == 0) {
            [DefaultSmartFestivalJoiner setIsRejoin:YES];
            [self performSelectorOnMainThread:@selector(didClickJoinButtonOfMainView:) withObject:mainView waitUntilDone:NO];
        }
    }
}

#pragma mark -
#pragma mark Base View Delegate

- (void)didClickJoinButtonOfMainView:(MainView*)aMainView {
    if ([DefaultSmartFestivalJoiner isJoined]) {
        [self showAlreadyJoinAlertView];
        return;
    }
    
    JoinViewController* viewController = [[JoinViewController alloc] init];

    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (void)didClickEvaluateButtonOfMainView:(MainView*)aMainView {
    if ([DefaultSmartFestivalJoiner isJoined] == NO) {
        [self showNeedToJoinAlertView];
        return;
    }
    
    EvaluateViewController* viewController = [[EvaluateViewController alloc] init];
        
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (void)didClickReportButtonOfMainView:(MainView*)aMainView {
    if ([DefaultSmartFestivalJoiner isJoined] == NO) {
        [self showNeedToJoinAlertView];
        return;
    }
    
    ReportViewController* viewController = [[ReportViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (void)didClickCheckButtonOfMainView:(MainView*)aMainView {
    if ([DefaultSmartFestivalJoiner isJoined] == NO) {
        [self showNeedToJoinAlertView];
        return;
    }
    
    CheckViewController* viewController = [[CheckViewController alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];  
}

@end
