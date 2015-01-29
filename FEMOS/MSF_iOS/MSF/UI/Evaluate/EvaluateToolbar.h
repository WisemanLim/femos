//
//  EvaluateToolbar.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HallInfo.h"

@protocol EvaluateToolbarDelegate;


@interface EvaluateToolbar : UIToolbar

@property (nonatomic, assign) id<EvaluateToolbarDelegate> delegate;

@end


@protocol EvaluateToolbarDelegate <NSObject>
@optional
- (void)didClickEvaluateButtonWithType:(EvaluateType)evaluateType;
@end

