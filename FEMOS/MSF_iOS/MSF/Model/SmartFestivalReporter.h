//
//  SmartFestivalReporter.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureMessage.h"

#define DefaultSmartFestivalReporter [SmartFestivalReporter defaultReporter]

@protocol SmartFestivalReporterDelegate;


@interface SmartFestivalReporter : NSObject

@property (nonatomic, assign) id<SmartFestivalReporterDelegate> reporterDelegate;

+ (SmartFestivalReporter*)defaultReporter;

- (void)reportPictureMessage:(PictureMessage*)pictureMessage;

@end


@protocol SmartFestivalReporterDelegate <NSObject>
@optional
- (void)smartFestivalReporterDidBeginToReport:(SmartFestivalReporter*)reporter withPictureMessage:(PictureMessage*)pictureMessage;
- (void)smartFestivalReporterDidEndToReport:(SmartFestivalReporter*)reporter withPictureMessage:(PictureMessage*)pictureMessage;
- (void)smartFestivalReporterDidFailToReport:(SmartFestivalReporter*)reporter withPictureMessage:(PictureMessage*)pictureMessage;
@end