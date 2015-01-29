//
//  EvaluateView.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "EvaluateView.h"
#import "NonInteractiveLoadingView.h"
#import "InteractiveLoadingView.h"

@interface EvaluateView() <UIWebViewDelegate> {
@private
    UIWebView* webView;
    
    NonInteractiveLoadingView* nonInteractiveLoadingView;
    InteractiveLoadingView* interactiveLoadingView;
}

@end


@implementation EvaluateView

@synthesize delegate;
@synthesize webView;
@synthesize evaluateToolbar;

#pragma mark -
#pragma mark Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSAutoreleasePool* pool = [NSAutoreleasePool new];
        
        [self setUserInteractionEnabled:YES];
        [self setImage:[UIImage imageNamed:@"main_bg.png"]];
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-76)];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [webView setHidden:YES];
        [self addSubview:webView];
        
        evaluateToolbar = [[EvaluateToolbar alloc] initWithFrame:CGRectMake(0, frame.size.height-76, frame.size.width, 76)];
        [evaluateToolbar setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth];
        [self addSubview:evaluateToolbar];
        
        nonInteractiveLoadingView = [[NonInteractiveLoadingView alloc] init];
        [nonInteractiveLoadingView setTitle:@"로딩 중..."];
        
        interactiveLoadingView = [[InteractiveLoadingView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-76)];
		[interactiveLoadingView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[interactiveLoadingView setTitle:@"로딩 중..."];
		[self addSubview:interactiveLoadingView];
        
        [pool drain];
    }
    
    return self;
}

- (void)dealloc {
    [webView release];
    [evaluateToolbar release];
    [nonInteractiveLoadingView release];
    [interactiveLoadingView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Instance Methods

- (void)goUrl:(NSURL*)url {
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView setDelegate:self];
    [webView loadRequest:request];
        
    [pool drain];
}

- (void)showNonInteractiveLoadingViewWithMsg:(NSString*)msg {
    [nonInteractiveLoadingView setTitle:msg];
    [nonInteractiveLoadingView show];
}

- (void)hideNonInteractiveLoadingView {
    [nonInteractiveLoadingView dismissWithClickedButtonIndex:-1 animated:YES];
}

#pragma mark -
#pragma mark UIWebview Delegate

- (void)webViewDidStartLoad:(UIWebView *)aWebView {
    [interactiveLoadingView startLoading];
    [evaluateToolbar setUserInteractionEnabled:NO];
    [webView setHidden:YES];
    
    if ([delegate respondsToSelector:@selector(didStartToLoadPage:)])
        [delegate performSelector:@selector(didStartToLoadPage:) withObject:self];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    [interactiveLoadingView stopLoading];
    [evaluateToolbar setUserInteractionEnabled:YES];
    [webView setHidden:NO];
    
    if ([delegate respondsToSelector:@selector(didFinishToLoadPage:)])
        [delegate performSelector:@selector(didFinishToLoadPage:) withObject:self];
}

@end
