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
        
        self.switchCamera = [UIButton buttonWithType: UIButtonTypeCustom];
        self.switchCamera.backgroundColor = [UIColor blackColor];
        
        self.showShapes = [UIButton buttonWithType: UIButtonTypeCustom];
        self.showShapes.backgroundColor = [UIColor blackColor];
        
        // TODO replace these with images.
        [self.takePhoto setTitle:@"shoot" forState: UIControlStateNormal];
        [self.takePhoto setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [self.switchCamera setTitle:@"switch" forState: UIControlStateNormal];
        [self.switchCamera setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [self.showShapes setTitle:@"shapes" forState: UIControlStateNormal];
        [self.showShapes setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        
        [self addSubview: self.takePhoto];
        [self addSubview: self.switchCamera];
        [self addSubview: self.showShapes];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect left, center, right;
    CGRectDivide(self.bounds, &left, &center, floorf(self.frame.size.width / 3), CGRectMinXEdge);
    CGRectDivide(center, &center, &right, floorf(self.frame.size.width / 3), CGRectMinXEdge);
    
    self.showShapes.frame = right;
    self.takePhoto.frame = center;
    self.switchCamera.frame = left;
    
}

@end
