//
//  SmartFestivalReporter.mm
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "SmartFestivalReporter.h"
#import "SmartFestivalReportRequest.h"
#import "SmartFestivalReportResponse.h"
#import "SmartFestivalJoiner.h"

@interface SmartFestivalReporter()
- (void)reportPictureMessage:(PictureMessage *)pictureMessage;
@end


@implementation SmartFestivalReporter

#pragma mark -
#pragma mark Class Methods

static SmartFestivalReporter* defaultReporter = nil;
+ (SmartFestivalReporter*)defaultReporter {
    if (defaultReporter == nil)
        defaultReporter = [[SmartFestivalReporter alloc] init];
    
    return defaultReporter;
}

#pragma mark -
#pragma mark Properties

@synthesize reporterDelegate;

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

- (void)reportPictureMessage:(PictureMessage *)pictureMessage {
    [self performSelectorInBackground:@selector(backgroundReportPictureMessage:) withObject:pictureMessage];
}

- (void)backgroundReportPictureMessage:(PictureMessage*)pictureMessage {
    [self processReportPictureMessage:pictureMessage];
}

#pragma mark -
#pragma mark Business Methods

- (void)processReportPictureMessage:(PictureMessage*)pictureMessage {
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    if (reporterDelegate != nil)
        [reporterDelegate performSelector:@selector(smartFestivalReporterDidBeginToReport:withPictureMessage:) withObject:self withObject:pictureMessage];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    SmartFestivalReportRequest* request = [[SmartFestivalReportRequest new] autorelease];
    [request setJoinInfo:[DefaultSmartFestivalJoiner currentJoinInfo]];
    [request setPictureMessage:pictureMessage];
    SmartFestivalReportResponse* response = [request synchronousRequest];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (reporterDelegate != nil) {
        if (response.isSuccess)
            [reporterDelegate performSelector:@selector(smartFestivalReporterDidEndToReport:withPictureMessage:) withObject:self withObject:pictureMessage];
        else
            [reporterDelegate performSelector:@selector(smartFestivalReporterDidFailToReport:withPictureMessage:) withObject:self withObject:pictureMessage];
    }
    
    [pool drain];
}

@end

