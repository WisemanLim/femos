//
//  SmartFestivalReportRequest.h
//  MSF
//
//  Created by delta829 on 12. 10. 6..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JoinInfo.h"
#import "PictureMessage.h"
#import "SmartFestivalReportResponse.h"

@interface SmartFestivalReportRequest : NSObject

@property (nonatomic, retain) JoinInfo* joinInfo;
@property (nonatomic, retain) PictureMessage* pictureMessage;

- (SmartFestivalReportResponse*)synchronousRequest;

@end
