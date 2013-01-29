//
//  BZCameraControlsView.m
//  Bezel
//
//  Created by Joshua Buchacher on 1/28/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZCameraControlsView.h"

@implementation BZCameraControlsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.takePhoto = [UIButton buttonWithType: UIButtonTypeCustom];
        self.takePhoto.backgroundColor = [UIColor blackColor];
        [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"takephoto"] forState: UIControlStateNormal];
        self.switchCamera = [UIButton buttonWithType: UIButtonTypeCustom];
        self.switchCamera.backgroundColor = [UIColor blackColor];
        
        [self addSubview: self.takePhoto];
        [self addSubview: self.switchCamera];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect left, center, right;
    CGRectDivide(self.bounds, &left, &center, floorf(self.frame.size.width / 3), CGRectMinXEdge);
    CGRectDivide(center, &center, &right, floorf(self.frame.size.width / 3), CGRectMinXEdge);
    
    self.takePhoto.frame = center;
    self.switchCamera.frame = right;
    
}

@end
