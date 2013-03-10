//
//  BZConfirmView.h
//  Bezel
//
//  Created by Josh Buchacher on 1/8/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZConfirmView : UIView

@property (nonatomic, copy) void (^completionBlock)(BOOL response);

- (void)presentConfirmationFromEdge:(CGRectEdge)edge inView:(UIView *)view;

@end
