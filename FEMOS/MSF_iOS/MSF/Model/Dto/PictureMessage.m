//
//  PictureMessage.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "PictureMessage.h"

@implementation PictureMessage

#pragma mark -
#pragma mark Properties

@synthesize picture;
@synthesize message;

#pragma mark -
#pragma mark Life Cycle

- (void)dealloc {
    [picture release];
    [message release];
    [super dealloc];
}

@end
