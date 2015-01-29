//
//  SmartFestivalCapturer.mm
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import "SmartFestivalCapturer.h"

@interface SmartFestivalCapturer() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end


@implementation SmartFestivalCapturer

#pragma mark -
#pragma mark Class Methods

static SmartFestivalCapturer* defaultCapturer = nil;
+ (SmartFestivalCapturer*)defaultCapturer {
    if (defaultCapturer == nil)
        defaultCapturer = [[SmartFestivalCapturer alloc] init];
    
    return defaultCapturer;
}

#pragma mark -
#pragma mark Properties

@synthesize capturerDelegate;

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

- (void)launchPictureCapturerInController:(UIViewController*)controller {
    [self performSelectorInBackground:@selector(backgroundLaunchPictureCapturerInController:) withObject:controller];
}

- (void)backgroundLaunchPictureCapturerInController:(UIViewController*)controller {
    [NSThread sleepForTimeInterval:0.4];        // for waiting stable UI thread
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        if (capturerDelegate != nil)
            [capturerDelegate performSelector:@selector(smartFestivalCapturerDidCancelToCapture:) withObject:self];
        return;
    }

    UIImagePickerController* pickerController = [[UIImagePickerController alloc] init];
    [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    [pickerController setAllowsEditing:YES];
    [pickerController setDelegate:self];
    [pickerController setModalPresentationStyle:UIModalPresentationFullScreen];
    [pickerController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [controller presentModalViewController:pickerController animated:YES];
    [pickerController release];
    
    if (capturerDelegate != nil)
        [capturerDelegate performSelector:@selector(smartFestivalCapturerDidStartToCapture:) withObject:self];
}

#pragma mark -
#pragma mark Business Methods

- (void)processPictureMessageWithImage:(UIImage*)image {
    if (capturerDelegate != nil) {
        NSAutoreleasePool* pool = [NSAutoreleasePool new];
        
        PictureMessage* pictureMessage = [[[PictureMessage alloc] init] autorelease];
        [pictureMessage setPicture:image];
        
        [capturerDelegate performSelector:@selector(smartFestivalCapturer:didSuccessToCaptureWithPictureMessage:) withObject:self withObject:pictureMessage];
        
        [pool drain];
    }
}

- (void)processCancel {
    [NSThread sleepForTimeInterval:0.4];        // waiting for stable UI thread
    
    if (capturerDelegate != nil)
        [capturerDelegate performSelector:@selector(smartFestivalCapturerDidCancelToCapture:) withObject:self];
}

#pragma mark -
#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    [self performSelectorInBackground:@selector(processPictureMessageWithImage:) withObject:[info objectForKey:UIImagePickerControllerEditedImage]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
    [self performSelectorInBackground:@selector(processCancel) withObject:nil];    
}

@end
