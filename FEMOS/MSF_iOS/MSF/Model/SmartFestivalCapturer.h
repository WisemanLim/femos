//
//  SmartFestivalCapturer.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureMessage.h"

#define DefaultSmartFestivalCapturer [SmartFestivalCapturer defaultCapturer]

@protocol SmartFestivalCapturerDelegate;


@interface SmartFestivalCapturer : NSObject

@property (nonatomic, assign) id<SmartFestivalCapturerDelegate> capturerDelegate;

+ (SmartFestivalCapturer*)defaultCapturer;

- (void)launchPictureCapturerInController:(UIViewController*)controller;

@end


@protocol SmartFestivalCapturerDelegate <NSObject>
@optional
- (void)smartFestivalCapturerDidStartToCapture:(SmartFestivalCapturer*)capturer;
- (void)smartFestivalCapturerDidCancelToCapture:(SmartFestivalCapturer*)capturer;
- (void)smartFestivalCapturer:(SmartFestivalCapturer*)capturer didSuccessToCaptureWithPictureMessage:(PictureMessage*)pictureMessage;
@end



