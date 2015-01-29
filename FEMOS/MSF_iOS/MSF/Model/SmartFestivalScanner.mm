//
//  SmartFestivalScanner.mm
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "SmartFestivalScanner.h"
#import "ZXingWidgetController.h"
#import "QRCodeReader.h"
#import "HTMLParser.h"
#import "SmartFestivalJoiner.h"

#define EVALUATE_URL    @"http://hbsys98.vps.phps.kr/FEMOS/mobile/satis_check_prc.jsp"


@interface SmartFestivalScanner() <ZXingDelegate>

- (void)processFestivalWithResult:(NSString*)result;
- (void)processCancel;

@end


@implementation SmartFestivalScanner

#pragma mark -
#pragma mark Class Methods

static SmartFestivalScanner* defaultScanner = nil;
+ (SmartFestivalScanner*)defaultScanner {
    if (defaultScanner == nil)
        defaultScanner = [[SmartFestivalScanner alloc] init];
    
    return defaultScanner;
}

#pragma mark -
#pragma mark Properties

@synthesize scannerDelegate;

#pragma mark -
#pragma mark Life Cycle

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Instance Methods

- (void)launchQRCodeScannerInController:(UIViewController*)controller {
    [self performSelectorInBackground:@selector(backgroundLaunchQRScannerInController:) withObject:controller];
}

- (void)backgroundLaunchQRScannerInController:(UIViewController*)controller {
    [NSThread sleepForTimeInterval:0.4];        // waiting for stable UI thread
    
    QRCodeReader* reader = [[QRCodeReader alloc] init];
    NSSet* readers = [[NSSet alloc] initWithObjects:reader, nil];
    [reader release];
    
    ZXingWidgetController* viewController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    [viewController setReaders:readers];
    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [readers release];
    
    [controller presentModalViewController:viewController animated:NO];
    [viewController release];
    
    if (scannerDelegate != nil)
        [scannerDelegate performSelector:@selector(smartFestivalScannerDidStartToScan:) withObject:self];
}

- (HallInfo*)parseHallInfoWithHtmlString:(NSString*)htmlString {
    NSError* error = nil;
	HTMLParser* parser = [[[HTMLParser alloc] initWithString:htmlString error:&error] autorelease];
    if (error == nil) {
        HTMLNode* bodyNode = [parser body];
        
        HTMLNode* hallCd = [bodyNode findChildWithAttribute:@"id" matchingName:@"festival_hall_cd" allowPartial:NO];
        if (hallCd) {
            HallInfo* hallInfo = [[HallInfo new] autorelease];
            [hallInfo setHallName:@"Unknown"];
            [hallInfo setHallCd:[hallCd getAttributeNamed:@"value"]];
            
            return hallInfo;
        }
    }
    
    return nil;
}

- (NSURL*)evaluateUrlWithHallInfo:(HallInfo*)hallInfo {
    NSMutableString* evaluateUrl = [NSMutableString stringWithString:EVALUATE_URL];
    if (hallInfo) {
        [evaluateUrl appendFormat:@"?festival_cd=%@", DefaultSmartFestivalJoiner.currentJoinInfo.festivalCd];
        [evaluateUrl appendFormat:@"&festival_hall_cd=%@", hallInfo.hallCd];
        [evaluateUrl appendFormat:@"&visiter_id=%@", DefaultSmartFestivalJoiner.currentJoinInfo.visitorId];
        [evaluateUrl appendFormat:@"&grade=%d", hallInfo.evaluateType];
    }
    
    return [NSURL URLWithString:evaluateUrl];
}

#pragma mark -
#pragma mark Business Methods

- (void)processFestivalWithResult:(NSString*)result {
    NSRange range = [[result lowercaseString] rangeOfString:@"http"];
    if (range.location == NSNotFound) {
        if (scannerDelegate != nil)
            [scannerDelegate performSelector:@selector(smartFestivalScannerDidFailToScan:) withObject:self];        
        return;
    }
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    if (scannerDelegate != nil)
        [scannerDelegate performSelector:@selector(smartFestivalScanner:didSuccessToScanWithUrl:) withObject:self withObject:[NSURL URLWithString:result]];
    
    [pool drain];
}

- (void)processCancel {
    [NSThread sleepForTimeInterval:0.4];        // waiting for stable UI thread
    
    if (scannerDelegate != nil)
        [scannerDelegate performSelector:@selector(smartFestivalScannerDidCancelToScan:) withObject:self];
}

#pragma mark -
#pragma mark ZXing Delegate

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString*)result {
    [controller dismissModalViewControllerAnimated:YES];
    [self performSelectorInBackground:@selector(processFestivalWithResult:) withObject:result];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [controller dismissModalViewControllerAnimated:YES];
    [self performSelectorInBackground:@selector(processCancel) withObject:nil];
}

@end
