//
//  InteractiveLoadingView.h
//  MSF
//
//  Created by delta829 on 12. 7. 15..
//  Copyright (c) 2012년 BTBSolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveLoadingView : UIView

- (void)setTitle:(NSString*)title;
- (void)setTitleSize:(CGFloat)size;
- (void)setTitleFont:(UIFont*)font;

- (void)showIndicator:(BOOL)show;
- (void)showTitle:(BOOL)show;

- (void)startLoading;
- (void)stopLoading;

@end
