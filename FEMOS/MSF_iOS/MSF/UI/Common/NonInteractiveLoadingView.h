//
//  NonInteractiveLoadingView.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NonInteractiveLoadingView : UIAlertView

@property (nonatomic, assign) NSInteger leftMargin;
@property (nonatomic, assign) NSInteger rightMargin;

- (void)setTitle:(NSString*)title;
- (void)setTitleSize:(CGFloat)size;
- (void)setTitleFont:(UIFont*)font;

- (void)showIndicator:(BOOL)show;
- (void)showTitle:(BOOL)show;

@end
