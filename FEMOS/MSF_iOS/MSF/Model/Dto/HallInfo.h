//
//  HallInfo.h
//  MSF
//
//  Created by delta829 on 12. 10. 6..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EvaluateTypeVeryComplaint = 1,
    EvaluateTypeComplaint,
    EvaluateTypeNormal,
    EvaluateTypeSatisfaction,
    EvaluateTypeVerySatisfaction,
} EvaluateType;

@interface HallInfo : NSObject

@property (nonatomic, retain) NSString* hallName;
@property (nonatomic, retain) NSString* hallCd;
@property (nonatomic, assign) EvaluateType evaluateType;

@end
