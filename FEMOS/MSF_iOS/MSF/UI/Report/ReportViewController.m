//
//  ReportViewController.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ReportViewController.h"
#import "NonInteractiveLoadingView.h"
#import "SmartFestivalCapturer.h"
#import "SmartFestivalReporter.h"

#define INPUT_THE_MESSAGE_ALERT_VIEW_TAG    1
#define REPORT_SUCCESS_ALERT_VIEW_TAG       2


@interface ReportViewController() <SmartFestivalCapturerDelegate, SmartFestivalReporterDelegate, UIAlertViewDelegate> {
@private
    BOOL isCompletedProcessCapture;
    
    UIImageView* pictureView;
    UITextView* textView;
    UIButton* confirmButton;    
    NonInteractiveLoadingView* nonInteractiveLoadingView;    
}

@end


@implementation ReportViewController

#pragma mark -
#pragma mark Life Cycle

@synthesize currentPictureMessage;

- (void)loadView {
    [super loadView];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [self setTitle:@"불편 신고"];
    [self.navigationController.navigationBar setOpaque:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 54, 28)];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
    pictureView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [pictureView setBackgroundColor:[UIColor lightGrayColor]];
    [pictureView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [pictureView setClipsToBounds:YES];
    [pictureView.layer setCornerRadius:9.0f];
    
    textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [textView setFont:[UIFont systemFontOfSize:16.0]];
    [textView setClipsToBounds:YES];
    [textView.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [textView.layer setBorderColor:[UIColor grayColor].CGColor];
    [textView.layer setBorderWidth:1.2];
    [textView.layer setCornerRadius:9.0f];
    [textView.layer setMasksToBounds:YES];
    [textView.layer setShadowColor:[UIColor blackColor].CGColor];
    [textView.layer setShadowRadius:0.0f];
    [textView.layer setShadowOffset:CGSizeMake(0.0f, -1.4f)];
    [textView.layer setShadowOpacity:1.0f];
        
    confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [confirmButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    [confirmButton setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-60)];
    [confirmButton setImage:[UIImage imageNamed:@"write_confirm_btn.png"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(didClickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:confirmButton];
    
    nonInteractiveLoadingView = [[NonInteractiveLoadingView alloc] init];
    [nonInteractiveLoadingView setTitle:@"로딩 중..."];
    
    UIImageView* backView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    [backView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [backView setImage:[UIImage imageNamed:@"main_bg.png"]];
    [self.tableView setBackgroundView:backView];
    [self.tableView setUserInteractionEnabled:YES];
    
    [pool drain];    
}

- (void)dealloc {
    [currentPictureMessage release];
    [pictureView release];
    [textView release];
    [confirmButton release];
    [nonInteractiveLoadingView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isCompletedProcessCapture == NO) {
        isCompletedProcessCapture = YES;
        
        [nonInteractiveLoadingView setTitle:@"카메라 구동 중..."];
        [nonInteractiveLoadingView show];
        [DefaultSmartFestivalCapturer setCapturerDelegate:self];
        [DefaultSmartFestivalCapturer launchPictureCapturerInController:self];
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

- (void)didClickConfirmButton:(id)sender {
    [textView resignFirstResponder];
    
    if (textView.text.length == 0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"메시지를 작성해주세요." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
        [alertView setTag:INPUT_THE_MESSAGE_ALERT_VIEW_TAG];
        [alertView show];
        [alertView release];
        return;
    }
    
    [currentPictureMessage setMessage:textView.text];
    
    [DefaultSmartFestivalReporter setReporterDelegate:self];
    [DefaultSmartFestivalReporter reportPictureMessage:currentPictureMessage];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (alertView.tag == REPORT_SUCCESS_ALERT_VIEW_TAG) {
            [alertView dismissWithClickedButtonIndex:-1 animated:YES];
            [self.navigationController popViewControllerAnimated:YES];   
        }
    }
}

#pragma mark -
#pragma mark TableView delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 10;
    
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1)
        return 80.0;
    
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 230.0;
    else if (indexPath.section == 1)
        return 80.0;
    
    return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    	static NSString* CellIdentifier = @"CellIdentifier";
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell.textLabel setText:@""];
    for (id subview in cell.contentView.subviews)
        [subview removeFromSuperview];
    
    if (indexPath.section == 0) {
        [pictureView setFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
        [cell.contentView addSubview:pictureView];
    }
    else if (indexPath.section == 1) {
        [textView setFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
        [cell.contentView addSubview:textView];
    }
    
    return cell;
}

#pragma mark -
#pragma mark SmartFestivalCapturer Delegate

- (void)smartFestivalCapturerDidStartToCapture:(SmartFestivalCapturer*)capturer {
    [nonInteractiveLoadingView dismissWithClickedButtonIndex:-1 animated:YES];
}

- (void)smartFestivalCapturerDidCancelToCapture:(SmartFestivalCapturer*)capturer {
    [nonInteractiveLoadingView dismissWithClickedButtonIndex:-1 animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)smartFestivalCapturer:(SmartFestivalCapturer*)capturer didSuccessToCaptureWithPictureMessage:(PictureMessage*)pictureMessage {
    [self setCurrentPictureMessage:pictureMessage];
    [pictureView setImage:pictureMessage.picture];
    
    UIImageWriteToSavedPhotosAlbum(pictureMessage.picture, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [nonInteractiveLoadingView setTitle:@"이미지 저장 중..."];
    [nonInteractiveLoadingView show];
}

#pragma mark -
#pragma mark SmartFestivalReporter Delegate

- (void)smartFestivalReporterDidBeginToReport:(SmartFestivalReporter*)reporter withPictureMessage:(PictureMessage*)pictureMessage {
    [nonInteractiveLoadingView setTitle:@"전송 중..."];
    [nonInteractiveLoadingView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}

- (void)smartFestivalReporterDidEndToReport:(SmartFestivalReporter*)reporter withPictureMessage:(PictureMessage*)pictureMessage {
    [nonInteractiveLoadingView dismissWithClickedButtonIndex:-1 animated:YES];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"전송되었습니다." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
    [alertView setTag:REPORT_SUCCESS_ALERT_VIEW_TAG];
    [alertView show];
    [alertView release];
}

- (void)smartFestivalReporterDidFailToReport:(SmartFestivalReporter*)reporter withPictureMessage:(PictureMessage*)pictureMessage {
    [nonInteractiveLoadingView dismissWithClickedButtonIndex:-1 animated:YES];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"전송이 실패되었습니다.\n다시 시도해주세요." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark Image Saving Delegate

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [nonInteractiveLoadingView dismissWithClickedButtonIndex:-1 animated:YES];
}
     
@end



