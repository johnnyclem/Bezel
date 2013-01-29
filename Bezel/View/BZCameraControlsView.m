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
        
        self.importFromLibrary = [UIButton buttonWithType: UIButtonTypeCustom];
        self.importFromLibrary.backgroundColor = [UIColor blackColor];
        
        // TODO replace these with images.
        [self.takePhoto setTitle:@"shoot" forState: UIControlStateNormal];
        [self.takePhoto setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [self.switchCamera setTitle:@"switch" forState: UIControlStateNormal];
        [self.switchCamera setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [self.importFromLibrary setTitle:@"import" forState: UIControlStateNormal];
        [self.importFromLibrary setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        
        [self addSubview: self.takePhoto];
        [self addSubview: self.switchCamera];
        [self addSubview: self.importFromLibrary];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect left, center, right;
    CGRectDivide(self.bounds, &left, &center, floorf(self.frame.size.width / 3), CGRectMinXEdge);
    CGRectDivide(center, &center, &right, floorf(self.frame.size.width / 3), CGRectMinXEdge);
    
    self.importFromLibrary.frame = left;
    self.takePhoto.frame = center;
    self.switchCamera.frame = right;
    
}

@end
