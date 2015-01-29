//
//  JoinInfo.h
//  MSF
//
//  Created by delta829 on 12. 9. 29..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoinInfo : NSObject <NSCoding>

@property (nonatomic, retain) NSString* festivalCd;
@property (nonatomic, retain) NSString* visitorName;
@property (nonatomic, retain) NSString* visitorSex;
@property (nonatomic ,retain) NSString* visitorPhoneNumber;
@property (nonatomic, retain) NSString* visitorEmail;
@property (nonatomic, retain) NSString* visitorId;

@end
