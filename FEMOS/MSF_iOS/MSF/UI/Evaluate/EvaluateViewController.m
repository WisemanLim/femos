//
//  EvaluateViewController.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "EvaluateViewController.h"
#import "EvaluateView.h"
#import "SmartFestivalScanner.h"

#define SCAN_RETRY_ALERT_VIEW_TAG           1
#define EVALUATE_CONFIRM_ALERT_VIEW_TAG     2
#define EVALUATE_SUCCESS_ALERT_VIEW_TAG     3

@interface EvaluateViewController() <SmartFestivalScannerDelegate, EvaluateViewDelegate,  EvaluateToolbarDelegate, UIAlertViewDelegate> {
@private
    BOOL isCompletedProcessReadQRCode;
    EvaluateView* evaluateView;
}

@end


@implementation EvaluateViewController

@synthesize currentHallInfo;

#pragma mark -
#pragma mark Life Cycle

- (void)loadView {
    [super loadView];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [self setTitle:@"만족도 평가"];
    [self.navigationController.navigationBar setOpaque:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 54, 28)];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
    evaluateView = [[EvaluateView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [evaluateView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [evaluateView setDelegate:self];
    [evaluateView.evaluateToolbar setDelegate:self];
    [self.view addSubview:evaluateView];
    
    [pool drain];
}

- (void)dealloc {
    [evaluateView release];
    [currentHallInfo release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isCompletedProcessReadQRCode == NO) {
        isCompletedProcessReadQRCode = YES;
        
        [evaluateView performSelectorOnMainThread:@selector(showNonInteractiveLoadingViewWithMsg:) withObject:@"QR코드 스캐너 구동 중..." waitUntilDone:NO];
        [DefaultSmartFestivalScanner setScannerDelegate:self];
        [DefaultSmartFestivalScanner launchQRCodeScannerInController:self];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark UI Event

- (void)didClickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [alertView dismissWithClickedButtonIndex:-1 animated:YES];
        
        if (alertView.tag == SCAN_RETRY_ALERT_VIEW_TAG ||
            alertView.tag == EVALUATE_SUCCESS_ALERT_VIEW_TAG)
            [self.navigationController popViewControllerAnimated:YES];       
    }
    else if (buttonIndex == 1) {
        if (alertView.tag == SCAN_RETRY_ALERT_VIEW_TAG) {
            [evaluateView performSelectorOnMainThread:@selector(showNonInteractiveLoadingViewWithMsg:) withObject:@"QR코드 스캐너 구동 중..." waitUntilDone:NO];            
            [DefaultSmartFestivalScanner setScannerDelegate:self];
            [DefaultSmartFestivalScanner launchQRCodeScannerInController:self];
        }
        else if (alertView.tag == EVALUATE_CONFIRM_ALERT_VIEW_TAG) {
            [evaluateView goUrl:[DefaultSmartFestivalScanner evaluateUrlWithHallInfo:currentHallInfo]];
        }
    }
}

#pragma mark -
#pragma mark EvaluateView Delegate

- (void)didStartToLoadPage:(EvaluateView *)aEvaluateView {
}

- (void)didFinishToLoadPage:(EvaluateView *)aEvaluateView {
    if (self.currentHallInfo != nil)
        return;
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    NSString* htmlString = [aEvaluateView.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML"];
    [self setCurrentHallInfo:[DefaultSmartFestivalScanner parseHallInfoWithHtmlString:htmlString]];
    
    if (self.currentHallInfo == nil) {
        [evaluateView setDelegate:nil];
        [self smartFestivalScannerDidFailToScan:DefaultSmartFestivalScanner];
    }
    
    [pool drain];
}

#pragma mark -
#pragma mark EvaluateToolbar Delegate

- (void)didClickEvaluateButtonWithType:(EvaluateType)evaluateType {
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [currentHallInfo setEvaluateType:evaluateType];
    
    NSMutableString* msg = [NSMutableString string];
    if (evaluateType == EvaluateTypeVeryComplaint) [msg setString:@"'매우불만'으로 평가하시겠습니까?"];
    else if (evaluateType == EvaluateTypeComplaint) [msg setString:@"'불만'으로 평가하시겠습니까?"];
    else if (evaluateType == EvaluateTypeNormal) [msg setString:@"'보통'으로 평가하시겠습니까?"];
    else if (evaluateType == EvaluateTypeSatisfaction) [msg setString:@"'만족'으로 평가하시겠습니까?"];
    else if (evaluateType == EvaluateTypeVerySatisfaction) [msg setString:@"'매우만족'으로 평가하시겠습니까?"];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:msg delegate:self cancelButtonTitle:@"아니오" otherButtonTitles:@"예", nil];
    [alertView setTag:EVALUATE_CONFIRM_ALERT_VIEW_TAG];
    [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    [alertView release];
    
    [pool drain];
}

#pragma mark -
#pragma mark SmartFestivalScanner Delegate

- (void)smartFestivalScannerDidStartToScan:(SmartFestivalScanner*)scanner {
    [evaluateView performSelectorOnMainThread:@selector(hideNonInteractiveLoadingView) withObject:nil waitUntilDone:NO];
}

- (void)smartFestivalScannerDidCancelToScan:(SmartFestivalScanner*)scanner {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)smartFestivalScannerDidFailToScan:(SmartFestivalScanner*)scanner {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"축제 QR코드가 아닙니다.\n다시 스캔하시겠습니까?" delegate:self cancelButtonTitle:@"아니오" otherButtonTitles:@"예", nil];
    [alertView setTag:SCAN_RETRY_ALERT_VIEW_TAG];
    [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    [alertView release];
}

- (void)smartFestivalScanner:(SmartFestivalScanner*)scanner didSuccessToScanWithUrl:(NSURL*)url {
    [evaluateView setDelegate:self];
    [evaluateView performSelectorOnMainThread:@selector(goUrl:) withObject:url waitUntilDone:NO];
}

@end

