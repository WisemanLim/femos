//
//  SmartFestivalJoiner.h
//  MSF
//
//  Created by delta829 on 12. 9. 29..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JoinInfo.h"

#define DefaultSmartFestivalJoiner [SmartFestivalJoiner defaultJoiner]

@interface SmartFestivalJoiner : NSObject

@property (nonatomic, readonly) JoinInfo* currentJoinInfo;
@property (nonatomic, assign) BOOL isRejoin;

+ (SmartFestivalJoiner*)defaultJoiner;

- (BOOL)isJoined;

- (NSURL*)joinUrl;
- (NSURL*)checkUrl;

- (void)parseJoinInfoWithHtmlString:(NSString*)htmlString;

@end
