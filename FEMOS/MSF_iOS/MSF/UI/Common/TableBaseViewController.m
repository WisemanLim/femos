//
//  TableBaseViewController.m
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TableBaseViewController.h"


@interface TableBaseViewController() {
@private
    UIImageView* navigationbarBackView;
    UIImageView* toolbarBackView;
}

@end


@implementation TableBaseViewController

- (void)dealloc {
    [navigationbarBackView release];
    [toolbarBackView release];
    [super dealloc];
}

- (void)loadView {
    [super loadView];
    
    NSAutoreleasePool* pool = [NSAutoreleasePool new];
    
    navigationbarBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    [navigationbarBackView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [navigationbarBackView setImage:[UIImage imageNamed:@"navibar_bg.png"]];
    [navigationbarBackView setTag:19283];
    [navigationbarBackView.layer setZPosition:-1.0];
    
    BOOL alreadyExistNavigationbarBackView = NO;
    for (UIView* subview in self.navigationController.navigationBar.subviews) {
        if ([subview isKindOfClass:[UIImageView class]] && subview.tag == 19283) {
            alreadyExistNavigationbarBackView = YES;
            break;
        }
    }
    if (alreadyExistNavigationbarBackView == NO) {
        if (self.navigationController.navigationBar.subviews.count <= 1) [self.navigationController.navigationBar addSubview:navigationbarBackView];
        else [[self.navigationController.navigationBar.subviews objectAtIndex:0] addSubview:navigationbarBackView];
    }
    
    toolbarBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.toolbar.frame.size.width, self.navigationController.toolbar.frame.size.height)];
    [toolbarBackView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [toolbarBackView setImage:nil];
    [toolbarBackView setTag:19283];
    [toolbarBackView.layer setZPosition:-1.0];
    
    BOOL alreadyExistToolbarBackView = NO;
    for (UIView* subview in self.navigationController.toolbar.subviews) {
        if ([subview isKindOfClass:[UIImageView class]] && subview.tag == 19283) {
            alreadyExistToolbarBackView = YES;
            break;
        }
    }
    if (alreadyExistToolbarBackView == NO) {
        if (self.navigationController.toolbar.subviews.count <= 0) [self.navigationController.toolbar addSubview:toolbarBackView];
        else [[self.navigationController.toolbar.subviews objectAtIndex:0] addSubview:toolbarBackView];
    }
    
    [pool drain];
}

@end
