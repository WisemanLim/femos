//
//  EvaluateToolbar.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "EvaluateToolbar.h"


@interface EvaluateToolbar()
@end


@implementation EvaluateToolbar

@synthesize delegate;

#pragma mark -
#pragma mark Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSAutoreleasePool* pool = [NSAutoreleasePool new];
        
        UIImageView* backView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        [backView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [backView setImage:[UIImage imageNamed:@"toolbar_vote.png"]];
        [self addSubview:backView];
        
        UITextView* titleTextView = [[[UITextView alloc] initWithFrame:CGRectMake(0, -5, frame.size.width, 25)] autorelease];
        [titleTextView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
        [titleTextView setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [titleTextView setTextAlignment:UITextAlignmentCenter];
        [titleTextView setTextColor:[UIColor whiteColor]];
        [titleTextView setBackgroundColor:[UIColor clearColor]];
        [titleTextView setText:@"만족도 평가하기"];
        [self addSubview:titleTextView];
        
        UIView* voteButtonBackView = [[[UIView alloc] initWithFrame:CGRectMake(0, 25, frame.size.width, frame.size.height-25)] autorelease];
        [voteButtonBackView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth];
        [voteButtonBackView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:voteButtonBackView];
        
        CGFloat margin = 2.0;
        CGFloat interval = 4.0;
        CGFloat width = 60;
        CGFloat height = 48;
        
        UIButton* voteVeryComplaintButton = [[[UIButton alloc] initWithFrame:CGRectMake(margin, 0, width, height)] autorelease];
        [voteVeryComplaintButton setImage:[UIImage imageNamed:@"vote_05.png"] forState:UIControlStateNormal];
        [voteVeryComplaintButton addTarget:self action:@selector(didClickVeryComplaintButton:) forControlEvents:UIControlEventTouchUpInside];
        [voteButtonBackView addSubview:voteVeryComplaintButton];
        
        UIButton* voteComplaintButton = [[[UIButton alloc] initWithFrame:CGRectMake(voteVeryComplaintButton.frame.origin.x+voteVeryComplaintButton.frame.size.width+interval, 0, width, height)] autorelease];
        [voteComplaintButton setImage:[UIImage imageNamed:@"vote_04.png"] forState:UIControlStateNormal];
        [voteComplaintButton addTarget:self action:@selector(didClickComplaintButton:) forControlEvents:UIControlEventTouchUpInside];
        [voteButtonBackView addSubview:voteComplaintButton];
        
        UIButton* voteNormalButton = [[[UIButton alloc] initWithFrame:CGRectMake(voteComplaintButton.frame.origin.x+voteComplaintButton.frame.size.width+interval, 0, width, height)] autorelease];
        [voteNormalButton setImage:[UIImage imageNamed:@"vote_03.png"] forState:UIControlStateNormal];
        [voteNormalButton addTarget:self action:@selector(didClickNormalButton:) forControlEvents:UIControlEventTouchUpInside];
        [voteButtonBackView addSubview:voteNormalButton];
        
        UIButton* voteSatisfactionButton = [[[UIButton alloc] initWithFrame:CGRectMake(voteNormalButton.frame.origin.x+voteNormalButton.frame.size.width+interval, 0, width, height)] autorelease];
        [voteSatisfactionButton setImage:[UIImage imageNamed:@"vote_02.png"] forState:UIControlStateNormal];
        [voteSatisfactionButton addTarget:self action:@selector(didClickSatisfactionButton:) forControlEvents:UIControlEventTouchUpInside];
        [voteButtonBackView addSubview:voteSatisfactionButton];
        
        UIButton* voteVerySatisfactionButton = [[[UIButton alloc] initWithFrame:CGRectMake(voteSatisfactionButton.frame.origin.x+voteSatisfactionButton.frame.size.width+interval, 0, width, height)] autorelease];
        [voteVerySatisfactionButton setImage:[UIImage imageNamed:@"vote_01.png"] forState:UIControlStateNormal];
        [voteVerySatisfactionButton addTarget:self action:@selector(didClickVerySatisfactionButton:) forControlEvents:UIControlEventTouchUpInside];
        [voteButtonBackView addSubview:voteVerySatisfactionButton];
        
        [pool drain];
    }
    
    return self;
}

#pragma mark -
#pragma mark UI Event

- (void)didClickVeryComplaintButton:(id)sender {
    if (delegate != nil)
        [delegate didClickEvaluateButtonWithType:EvaluateTypeVeryComplaint];
}

- (void)didClickComplaintButton:(id)sender {
    if (delegate != nil)
        [delegate didClickEvaluateButtonWithType:EvaluateTypeComplaint];    
}

- (void)didClickNormalButton:(id)sender {
    if (delegate != nil)
        [delegate didClickEvaluateButtonWithType:EvaluateTypeNormal];
}

- (void)didClickSatisfactionButton:(id)sender {
    if (delegate != nil)
        [delegate didClickEvaluateButtonWithType:EvaluateTypeSatisfaction];
}

- (void)didClickVerySatisfactionButton:(id)sender {
    if (delegate != nil)
        [delegate didClickEvaluateButtonWithType:EvaluateTypeVerySatisfaction];
}

@end
