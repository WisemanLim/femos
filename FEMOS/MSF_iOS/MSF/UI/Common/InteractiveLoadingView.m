//
//  InteractiveLoadingView.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "InteractiveLoadingView.h"


@interface InteractiveLoadingView() {
@private
	UIImageView* loadingView;
	UIActivityIndicatorView* loadingIndicator;
	UILabel* loadingText;
}

@end


@implementation InteractiveLoadingView

#pragma mark -
#pragma mark View lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		NSAutoreleasePool* pool = [NSAutoreleasePool new];
		
		[self setBackgroundColor:[UIColor clearColor]];
		[self setUserInteractionEnabled:NO];
		[self setHidden:YES];
		
		loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 80)];
		[loadingView setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
		[loadingView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
         UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
		[loadingView setBackgroundColor:[UIColor blackColor]];
		[loadingView setAlpha:0.8];
		[loadingView.layer setCornerRadius:10.0];
		[self addSubview:loadingView];
		
		loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		[loadingIndicator setCenter:CGPointMake(loadingView.frame.size.width/2, loadingView.frame.size.height/2-15)];
		[loadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
		[loadingIndicator setHidesWhenStopped:NO];
		[loadingIndicator stopAnimating];
		[loadingView addSubview:loadingIndicator];
		
		loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0, loadingView.frame.size.height/2+10, loadingView.frame.size.width, 20)];
		[loadingText setBackgroundColor:[UIColor clearColor]];
		[loadingText setTextColor:[UIColor whiteColor]];
		[loadingText setTextAlignment:UITextAlignmentCenter];
		[loadingText setFont:[UIFont boldSystemFontOfSize:18.0f]];
		[loadingText setText:@""];
		[loadingView addSubview:loadingText];
		
		[pool drain];
    }
	
    return self;
}

- (void)dealloc {
	[loadingView release];
	[loadingIndicator release];
	[loadingText release];
    [super dealloc];
}

#pragma mark -
#pragma mark Instance Method

- (void)setTitle:(NSString *)title {
	[loadingText setText:title];
}

- (void)setTitleSize:(CGFloat)size {
	[loadingText setFont:[loadingText.font fontWithSize:size]];
}

- (void)setTitleFont:(UIFont *)font {
	[loadingText setFont:font];
}

- (void)showIndicator:(BOOL)show {
	[loadingIndicator setHidden:!show];
}

- (void)showTitle:(BOOL)show {
	[loadingText setHidden:!show];
}

- (void)startLoading {
	[self setHidden:NO];
	[loadingIndicator startAnimating];
}

- (void)stopLoading {
	[self setHidden:YES];
	[loadingIndicator stopAnimating];
}

@end
