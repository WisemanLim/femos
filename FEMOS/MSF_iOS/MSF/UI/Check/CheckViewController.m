//
//  CheckViewController.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CheckViewController.h"
#import "SmartFestivalJoiner.h"

@interface CheckViewController () <CheckViewDelegate>
@end


@implementation CheckViewController

@synthesize checkView;

#pragma mark -
#pragma mark Life Cycle

- (void)loadView {
    [super loadView];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [self setTitle:@"방문객 체크"];
    [self.navigationController.navigationBar setOpaque:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 54, 28)];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
    checkView = [[CheckView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [checkView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [checkView setDelegate:self];
    [self.view addSubview:checkView];
    
    [pool drain];    
}

- (void)dealloc {
    [checkView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UI Event

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSURL* checkUrl = [DefaultSmartFestivalJoiner checkUrl];
    [checkView.webView loadRequest:[NSURLRequest requestWithURL:checkUrl]];
    
    [pool drain];
}

- (void)didClickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
