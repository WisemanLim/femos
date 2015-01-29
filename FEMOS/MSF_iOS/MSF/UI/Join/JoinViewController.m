//
//  JoinViewController.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "JoinViewController.h"
#import "SmartFestivalJoiner.h"

@interface JoinViewController() <JoinViewDelegate>
@end


@implementation JoinViewController

@synthesize joinView;

#pragma mark -
#pragma mark Life Cycle

- (void)loadView {
    [super loadView];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [self setTitle:@"축제 참여"];
    [self.navigationController.navigationBar setOpaque:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 54, 28)];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
    joinView = [[JoinView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [joinView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [joinView setDelegate:self];
    [self.view addSubview:joinView];
    
    [pool drain];    
}

- (void)dealloc {
    [joinView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSURL* joinUrl = [DefaultSmartFestivalJoiner joinUrl];
    [joinView.webView loadRequest:[NSURLRequest requestWithURL:joinUrl]];
    
    [pool drain];
}

#pragma mark -
#pragma mark UI Event

- (void)didClickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark JoinViewDelegate

- (void)didStartToLoadPage:(JoinView *)aJoinView {
}

- (void)didFinishToLoadPage:(JoinView *)aJoinView {
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    NSString* htmlString = [aJoinView.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML"];
    [DefaultSmartFestivalJoiner parseJoinInfoWithHtmlString:htmlString];
    
    [pool drain];
}

@end
