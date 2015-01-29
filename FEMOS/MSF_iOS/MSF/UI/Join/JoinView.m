//
//  JoinView.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "JoinView.h"

@interface JoinView() <UIWebViewDelegate>
@end


@implementation JoinView

#pragma mark -
#pragma mark Properties

@synthesize delegate;
@synthesize webView;
@synthesize interactiveLoadingView;

#pragma mark -
#pragma mark Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSAutoreleasePool* pool = [NSAutoreleasePool new];
        
        [self setUserInteractionEnabled:YES];
        [self setImage:[UIImage imageNamed:@"main_bg.png"]];
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [webView setHidden:YES];
        [webView setDelegate:self];
        [self addSubview:webView];
        
        interactiveLoadingView = [[InteractiveLoadingView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[interactiveLoadingView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[interactiveLoadingView setTitle:@"로딩 중..."];
		[self addSubview:interactiveLoadingView];
        
        [pool drain];
    }
    
    return self;
}

- (void)dealloc {
    [webView release];
    [interactiveLoadingView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIWebview Delegate

- (void)webViewDidStartLoad:(UIWebView *)aWebView {
    [interactiveLoadingView startLoading];
    [webView setHidden:YES];
    
    if ([delegate respondsToSelector:@selector(didStartToLoadPage:)])
        [delegate performSelector:@selector(didStartToLoadPage:) withObject:self];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    [interactiveLoadingView stopLoading];
    [webView setHidden:NO];
    
    if ([delegate respondsToSelector:@selector(didFinishToLoadPage:)])
        [delegate performSelector:@selector(didFinishToLoadPage:) withObject:self];
}

@end
