//
//  BZConfirmView.m
//  Bezel
//
//  Created by Josh Buchacher on 1/8/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZConfirmView.h"
#import "BZButton.h"

@interface BZConfirmView ()
@property (strong, nonatomic) UIView *confirm;
@end

@implementation BZConfirmView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame])
    {
        self.backgroundColor = [UIColor blackColor];

        self.confirm = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, (UIScreen.mainScreen.bounds.size.height-380)/2)];
        
        CGRect yesRect, noRect, emptyMiddleRect;
        CGRectDivide(self.frame, &yesRect, &emptyMiddleRect, self.confirm.frame.size.width/3, CGRectMinXEdge);
        CGRectDivide(emptyMiddleRect, &noRect, &emptyMiddleRect, emptyMiddleRect.size.width/2, CGRectMaxXEdge);
        
        BZButton *yes = [[BZButton alloc] initWithFrame: CGRectMake(0.0, 0.0, 50.0, 50.0)];
        yes.frame = centerRectInRect(yes.frame, yesRect);
        yes.buttonIdentifier = @"TRUE";
        [yes addTarget:self action:@selector(responseTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        BZButton *no = [[BZButton alloc] initWithFrame: CGRectMake(0.0, 0.0, 50.0, 50.0)];
        no.frame = centerRectInRect(no.frame, noRect);
        no.buttonIdentifier = @"FALSE";
        [no addTarget:self action:@selector(responseTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        yes.tag = 33;
        no.tag = 34;
        
        [self.confirm addSubview: yes];
        [self.confirm addSubview: no];
        
        [self addSubview: self.confirm];
    }
    
    return self;
}

- (id)init
{
    return [self initWithFrame: CGRectMake(0.0, 0.0, 320.0, (UIScreen.mainScreen.bounds.size.height-380)/2)];
}

- (void)presentConfirmationFromEdge:(CGRectEdge)edge forViewController:(UIViewController *)viewController
{
    if (edge == CGRectMinXEdge || edge == CGRectMaxXEdge)
    {
        // Doesn't support coming in from right or left.
    }
    else
    {   
        CGFloat yPosFrom = (edge == CGRectMaxYEdge) ? UIScreen.mainScreen.bounds.size.height : -60.0;
        self.frame = CGRectMake(0.0, yPosFrom, 320.0, (UIScreen.mainScreen.bounds.size.height-380)/2);
        
        CGFloat yPosTo = (edge == CGRectMaxYEdge) ? UIScreen.mainScreen.bounds.size.height - self.frame.size.height : 0.0;
        
        [viewController.view addSubview: self];
        [viewController.view bringSubviewToFront: self];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.frame = CGRectMake(0, yPosTo, 320.f, self.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             LogTrace(@"Completed BZConfirmView animation");
                         }];
    }
}

- (void)responseTapped:(BZButton *)button
{
    [self removeFromSuperview];
    
    if (self.completionBlock)
    {
        self.completionBlock([button.buttonIdentifier boolValue]);
        self.completionBlock = nil;
    }
}

#pragma mark - Convenience

CGRect centerRectInRect(CGRect innerRect, CGRect outerRect)
{
    return CGRectMake(
                      outerRect.origin.x + floor(outerRect.size.width  / 2 - innerRect.size.width  / 2),
                      outerRect.origin.y + floor(outerRect.size.height / 2 - innerRect.size.height / 2),
                      innerRect.size.width,
                      innerRect.size.height
                      );
}

@end
