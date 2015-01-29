//
//  HallInfo.m
//  MSF
//
//  Created by delta829 on 12. 10. 6..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "HallInfo.h"

@implementation HallInfo

#pragma mark -
#pragma mark Properties

@synthesize hallName;
@synthesize hallCd;
@synthesize evaluateType;

#pragma mark -
#pragma mark Life Cycle

- (id)init {
    self = [super init];
    if (self) {
        [self setHallName:@""];
        [self setHallCd:@""];
        [self setEvaluateType:EvaluateTypeNormal];
    }
    
    return self;
}

- (void)dealloc {
    [hallName release];
    [hallCd release];
    [super dealloc];
}

@end
