//
//  SmartFestivalJoiner.m
//  MSF
//
//  Created by delta829 on 12. 9. 29..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "SmartFestivalJoiner.h"
#import "HTMLParser.h"
#import "HTMLNode.h"

#define CURRENT_JOIN_INFO_DATA_KEY      @"currentJoinInfoData"

#define JOIN_URL        @"http://hbsys98.vps.phps.kr/FEMOS/mobile/join_festival_1.jsp"
#define CHECK_URL       @"http://hbsys98.vps.phps.kr/FEMOS/mobile/view_festival.jsp"


@implementation SmartFestivalJoiner

#pragma mark -
#pragma mark Class Methods

static SmartFestivalJoiner* defaultJoiner = nil;
+ (SmartFestivalJoiner*)defaultJoiner {
    if (defaultJoiner == nil)
        defaultJoiner = [[SmartFestivalJoiner alloc] init];
    
    return defaultJoiner;
}

#pragma mark -
#pragma mark Properties

@synthesize currentJoinInfo;
@synthesize isRejoin;

#pragma mark -
#pragma mark Instance Methods

- (JoinInfo*)currentJoinInfo {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* data = [userDefaults objectForKey:CURRENT_JOIN_INFO_DATA_KEY];
    if (data)
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return nil;
}

- (BOOL)isJoined {
    JoinInfo* joinInfo = self.currentJoinInfo;
    if (joinInfo != nil && joinInfo.visitorId.length > 0) {
        if (self.isRejoin == YES)
            return NO;
        
        return YES;
    }
    
    return NO;
}

- (NSURL*)joinUrl {
    return [NSURL URLWithString:JOIN_URL];
}

- (NSURL*)checkUrl {
    NSMutableString* checkUrl = [NSMutableString stringWithString:CHECK_URL];
    if (self.currentJoinInfo)
        [checkUrl appendFormat:@"?visiterId=%@", self.currentJoinInfo.visitorId];
    
    return [NSURL URLWithString:checkUrl];
}

- (void)parseJoinInfoWithHtmlString:(NSString*)htmlString {
    NSError* error = nil;
	HTMLParser* parser = [[[HTMLParser alloc] initWithString:htmlString error:&error] autorelease];
    if (error == nil) {
        HTMLNode* bodyNode = [parser body];
        
        HTMLNode* festivalCd = [bodyNode findChildWithAttribute:@"id" matchingName:@"festival_cd" allowPartial:NO];
        HTMLNode* visitorNm = [bodyNode findChildWithAttribute:@"id" matchingName:@"visiter_nm" allowPartial:NO];
        HTMLNode* visitorSex = [bodyNode findChildWithAttribute:@"id" matchingName:@"sex" allowPartial:NO];
        HTMLNode* visitorHp = [bodyNode findChildWithAttribute:@"id" matchingName:@"hp" allowPartial:NO];
        HTMLNode* visitorEmail = [bodyNode findChildWithAttribute:@"id" matchingName:@"email" allowPartial:NO];
        HTMLNode* visitorId = [bodyNode findChildWithAttribute:@"id" matchingName:@"visiter_id" allowPartial:NO];
        
        if (festivalCd && visitorNm && visitorSex && visitorHp && visitorEmail && visitorId) {
            JoinInfo* joinInfo = [[JoinInfo new] autorelease];
            [joinInfo setFestivalCd:[festivalCd getAttributeNamed:@"value"]];
            [joinInfo setVisitorName:[visitorNm getAttributeNamed:@"value"]];
            [joinInfo setVisitorSex:[visitorSex getAttributeNamed:@"value"]];
            [joinInfo setVisitorPhoneNumber:[visitorHp getAttributeNamed:@"value"]];
            [joinInfo setVisitorEmail:[visitorEmail getAttributeNamed:@"value"]];
            [joinInfo setVisitorId:[visitorId getAttributeNamed:@"value"]];
            
            NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:joinInfo] forKey:CURRENT_JOIN_INFO_DATA_KEY];
            [userDefaults synchronize];
        }
    }
}

@end
