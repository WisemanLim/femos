//
//  SmartFestivalScanner.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HallInfo.h"

#define DefaultSmartFestivalScanner [SmartFestivalScanner defaultScanner]

@protocol SmartFestivalScannerDelegate;


@interface SmartFestivalScanner : NSObject

@property (nonatomic, assign) id<SmartFestivalScannerDelegate> scannerDelegate;

+ (SmartFestivalScanner*)defaultScanner;

- (void)launchQRCodeScannerInController:(UIViewController*)controller;

- (HallInfo*)parseHallInfoWithHtmlString:(NSString*)htmlString;
- (NSURL*)evaluateUrlWithHallInfo:(HallInfo*)hallInfo;

@end


@protocol SmartFestivalScannerDelegate <NSObject>
@optional
- (void)smartFestivalScannerDidStartToScan:(SmartFestivalScanner*)scanner;
- (void)smartFestivalScannerDidCancelToScan:(SmartFestivalScanner*)scanner;
- (void)smartFestivalScannerDidFailToScan:(SmartFestivalScanner*)scanner;
- (void)smartFestivalScanner:(SmartFestivalScanner*)scanner didSuccessToScanWithUrl:(NSURL*)url;
@end
