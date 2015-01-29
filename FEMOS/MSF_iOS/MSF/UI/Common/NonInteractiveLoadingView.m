//
//  NonInteractiveLoadingView.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NonInteractiveLoadingView.h"

#define SIDE_MARGIN 60

@interface NonInteractiveLoadingView() {
@private
	UIImageView* loadingView;
	UIActivityIndicatorView* loadingIndicator;
	UILabel* loadingText;
	
	NSInteger leftMargin;
	NSInteger rightMargin;
}

@end


@implementation NonInteractiveLoadingView

@synthesize leftMargin;
@synthesize rightMargin;

#pragma mark -
#pragma mark View lifecycle

- (id)init {
    self = [super init];
    if (self) {
		NSAutoreleasePool* pool = [NSAutoreleasePool new];
		
		[self setAlpha:1.0f];
		
		loadingView = [[UIImageView alloc] init];
		[loadingView setBackgroundColor:[UIColor blackColor]];
		[loadingView setAlpha:0.8];
		[loadingView.layer setCornerRadius:10.0];
		[self addSubview:loadingView];
		
		loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		[loadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
		[loadingIndicator setHidesWhenStopped:NO];
		[loadingIndicator startAnimating];
		[self addSubview:loadingIndicator];
		
		loadingText = [[UILabel alloc] init];
		[loadingText setBackgroundColor:[UIColor clearColor]];
		[loadingText setTextColor:[UIColor whiteColor]];
		[loadingText setAdjustsFontSizeToFitWidth:YES];
		[loadingText setText:@""];
		[loadingText setTextAlignment:UITextAlignmentCenter];
        [loadingText setFont:[UIFont boldSystemFontOfSize:18.0]];
		[self addSubview:loadingText];
		
		[pool drain];
		
		leftMargin = SIDE_MARGIN/2;
		rightMargin = SIDE_MARGIN/2;
    }
    return self;
}

- (void)dealloc {
	[loadingView release];
	[loadingIndicator release];
	[loadingText release];
    [super dealloc];
}

- (void)setFrame:(CGRect)f {
	[super setFrame:CGRectMake(f.origin.x, f.origin.y, 0, 0)];
    
	[self resetSize];
}

- (void)resetSize {
	CGSize strSize = [loadingText.text sizeWithFont:loadingText.font];
	[loadingView setFrame:CGRectMake(-(strSize.width + leftMargin + rightMargin)/2, -45, strSize.width + leftMargin + rightMargin, 80)];
	
	if (loadingIndicator.hidden) {
		[loadingText setFrame:CGRectMake(0, 0, strSize.width, strSize.height)];
		[loadingText setCenter:CGPointMake(loadingView.frame.origin.x + loadingView.frame.size.width/2, loadingView.frame.origin.y + loadingView.frame.size.height/2)];
	}
	else if (loadingText.hidden) {
		[loadingIndicator setCenter:CGPointMake(loadingView.frame.origin.x + loadingView.frame.size.width/2, loadingView.frame.origin.y + loadingView.frame.size.height/2)];
	}
	else {
		[loadingIndicator setCenter:CGPointMake(loadingView.frame.origin.x + loadingView.frame.size.width/2, loadingView.frame.origin.y + loadingView.frame.size.height/2 - 15)];
		[loadingText setFrame:CGRectMake(0, 0, strSize.width, strSize.height)];
		[loadingText setCenter:CGPointMake(loadingView.frame.origin.x + loadingView.frame.size.width/2, loadingView.frame.origin.y + loadingView.frame.size.height/2 + 20)];
	}
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

- (void)setLeftMargin:(NSInteger)margin {
	leftMargin = margin;
}

- (void)setRightMargin:(NSInteger)margin {
	rightMargin = margin;
}

@end
