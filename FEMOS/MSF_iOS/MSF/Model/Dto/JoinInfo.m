//
//  JoinInfo.m
//  MSF
//
//  Created by delta829 on 12. 9. 29..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "JoinInfo.h"

@implementation JoinInfo

#pragma mark -
#pragma mark Properties

@synthesize festivalCd;
@synthesize visitorName;
@synthesize visitorSex;
@synthesize visitorPhoneNumber;
@synthesize visitorEmail;
@synthesize visitorId;

#pragma mark -
#pragma mark Life Cycle

- (id)init {
    self = [super init];
    if (self) {
        [self setFestivalCd:@""];
        [self setVisitorName:@""];
        [self setVisitorSex:@""];
        [self setVisitorPhoneNumber:@""];
        [self setVisitorEmail:@""];
        [self setVisitorId:@""];
    }
    
    return self;
}

- (void)dealloc {
    [festivalCd release];
    [visitorName release];
    [visitorSex release];
    [visitorPhoneNumber release];
    [visitorEmail release];
    [visitorId release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSCoding Delegate

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
        [self setFestivalCd:[aDecoder decodeObjectForKey:@"festivalCd"]];
        [self setVisitorName:[aDecoder decodeObjectForKey:@"visitorName"]];
        [self setVisitorSex:[aDecoder decodeObjectForKey:@"visitorSex"]];
        [self setVisitorPhoneNumber:[aDecoder decodeObjectForKey:@"visitorPhoneNumber"]];
        [self setVisitorEmail:[aDecoder decodeObjectForKey:@"visitorEmail"]];
        [self setVisitorId:[aDecoder decodeObjectForKey:@"visitorId"]];
	}
    
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aEncoder {
    [aEncoder encodeObject:self.festivalCd forKey:@"festivalCd"];
    [aEncoder encodeObject:self.visitorName forKey:@"visitorName"];
    [aEncoder encodeObject:self.visitorSex forKey:@"visitorSex"];
    [aEncoder encodeObject:self.visitorPhoneNumber forKey:@"visitorPhoneNumber"];
    [aEncoder encodeObject:self.visitorEmail forKey:@"visitorEmail"];
    [aEncoder encodeObject:self.visitorId forKey:@"visitorId"];
}

@end
