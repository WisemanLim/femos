//
//  SmartFestivalReportRequest.m
//  MSF
//
//  Created by delta829 on 12. 10. 6..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "SmartFestivalReportRequest.h"

#define REPORT_URL      @"http://hbsys98.vps.phps.kr/FEMOS/mobile/upload_inconvenient.jsp"
#define BOUNDARY        @"---------------------------8437329539574375435345"

#define IMAGE_COMPRESSION_QUALITY   1.0f

@implementation SmartFestivalReportRequest

#pragma mark -
#pragma mark Properties

@synthesize joinInfo;
@synthesize pictureMessage;

#pragma mark -
#pragma mark Life Cycle

- (void)dealloc {
    [joinInfo release];
    [pictureMessage release];
    [super dealloc];
}

#pragma mark -
#pragma mark Private Method

- (NSData*)makeBody {
    NSMutableData* bodyData = [NSMutableData data];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // festival cd
    [bodyData appendData:[@"Content-Disposition: form-data; name=\"festival_cd\";\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[self.joinInfo.festivalCd dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // visitor id
    [bodyData appendData:[@"Content-Disposition: form-data; name=\"visiter_id\";\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[self.joinInfo.visitorId dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // ivt div
    [bodyData appendData:[@"Content-Disposition: form-data; name=\"ivt_div\";\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"A7010001" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // ivt content
    [bodyData appendData:[@"Content-Disposition: form-data; name=\"ivt_content\";\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[self.pictureMessage.message dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // attach file
    [bodyData appendData:[@"Content-Disposition: form-data; name=\"attach_file\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:UIImageJPEGRepresentation(self.pictureMessage.picture, IMAGE_COMPRESSION_QUALITY)];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return bodyData;
}

#pragma mark -
#pragma mark Public Method

- (SmartFestivalReportResponse*)synchronousRequest {
    SmartFestivalReportResponse* response = [[SmartFestivalReportResponse new] autorelease];
    [response setIsSuccess:NO];
    
    if (self.joinInfo == nil || self.pictureMessage == nil)
        return response;
    if (self.joinInfo.festivalCd == nil || self.joinInfo.visitorId == nil ||
        self.pictureMessage.picture == nil || self.pictureMessage.message == nil)
        return response;
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest new] autorelease];
    [request setURL:[NSURL URLWithString:REPORT_URL]];
    [request setTimeoutInterval:30.0];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY] forHTTPHeaderField:@"Content-type"];
    
    NSData* bodyData = [self makeBody];
    [request setValue:[NSString stringWithFormat:@"%d", bodyData.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:bodyData];
    
    NSError* error = nil;
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString* responseDataStr = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", responseDataStr);
    if (error == nil && responseDataStr.length > 0)
        [response setIsSuccess:YES];
    
    [pool drain];
    
    return response;
}

@end
