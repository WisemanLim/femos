//
//  MainView.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "MainView.h"

@interface MainView() {
@private
    UIButton* joinButton;
    UIButton* evaluateButton;
    UIButton* reportButton;
    UIButton* checkButton;
}

@end


@implementation MainView

@synthesize delegate;

#pragma mark -
#pragma mark Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSAutoreleasePool* pool = [NSAutoreleasePool new];
        
        [self setUserInteractionEnabled:YES];
        [self setImage:[UIImage imageNamed:@"index_bg.png"]];
        
        UIView* buttonsView = [[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height/2.35, frame.size.width*0.72, frame.size.height/2.0)] autorelease];
        [buttonsView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [buttonsView setCenter:CGPointMake(frame.size.width/2, buttonsView.center.y)];
        [buttonsView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:buttonsView];
                
        CGFloat eachButtonInterval = 10.0;
        CGFloat eachButtonWidth = (buttonsView.frame.size.width-eachButtonInterval*3.0)/2.0;
        CGFloat eachButtonHeight = (buttonsView.frame.size.height-eachButtonInterval*3.0)/2.0;
        
        joinButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [joinButton setFrame:CGRectMake(eachButtonInterval, eachButtonInterval, eachButtonWidth, eachButtonHeight)];
        [joinButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
        [joinButton setImage:[UIImage imageNamed:@"main_btn_01.png"] forState:UIControlStateNormal];
        [joinButton addTarget:self action:@selector(didClickJoinButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsView addSubview:joinButton];
        
        evaluateButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [evaluateButton setFrame:CGRectMake(joinButton.frame.origin.x+joinButton.frame.size.width+eachButtonInterval, eachButtonInterval, eachButtonWidth, eachButtonHeight)];
        [evaluateButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [evaluateButton setImage:[UIImage imageNamed:@"main_btn_02.png"] forState:UIControlStateNormal];
        [evaluateButton addTarget:self action:@selector(didClickEvaluateButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsView addSubview:evaluateButton];
        
        reportButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [reportButton setFrame:CGRectMake(eachButtonInterval, joinButton.frame.origin.y+joinButton.frame.size.height+eachButtonInterval, eachButtonWidth, eachButtonHeight)];
        [reportButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [reportButton setImage:[UIImage imageNamed:@"main_btn_03.png"] forState:UIControlStateNormal];
        [reportButton addTarget:self action:@selector(didClickReportButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsView addSubview:reportButton];
        
        checkButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [checkButton setFrame:CGRectMake(reportButton.frame.origin.x+reportButton.frame.size.width+eachButtonInterval, joinButton.frame.origin.y+joinButton.frame.size.height+eachButtonInterval, eachButtonWidth, eachButtonHeight)];
        [checkButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [checkButton setImage:[UIImage imageNamed:@"main_btn_04.png"] forState:UIControlStateNormal];
        [checkButton addTarget:self action:@selector(didClickCheckButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsView addSubview:checkButton];
    
        [pool drain];
    }
    
    return self;
}

- (void)dealloc {
    [joinButton release];
    [evaluateButton release];
    [reportButton release];
    [checkButton release];
    [super dealloc];
}

#pragma mark -
#pragma mark UI Event

- (void)didClickJoinButton:(id)sender {
    if (delegate == nil)
        return;
    
    [delegate performSelector:@selector(didClickJoinButtonOfMainView:) withObject:self];
}

- (void)didClickEvaluateButton:(id)sender {
    if (delegate == nil)
        return;
    
    [delegate performSelector:@selector(didClickEvaluateButtonOfMainView:) withObject:self];
}

- (void)didClickReportButton:(id)sender {
    if (delegate == nil)
        return;
    
    [delegate performSelector:@selector(didClickReportButtonOfMainView:) withObject:self];
}

- (void)didClickCheckButton:(id)sender {
    if (delegate == nil)
        return;
    
    [delegate performSelector:@selector(didClickCheckButtonOfMainView:) withObject:self];
}

@end
