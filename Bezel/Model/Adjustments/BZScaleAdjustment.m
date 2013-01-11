//
//  BZScaleAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/10/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZScaleAdjustment.h"
#import "UIImage+Utils.h"

NSString* const kAdjustmentTypeScale = @"kAdjustmentTypeScale";

@implementation BZScaleAdjustment

- (UIImage *)processImage:(UIImage *)inImage
{
    float scaleAmount = [[self.value objectForKey: kAdjustmentTypeScale] floatValue];
    
    CGSize inputSize = inImage.size;
    inputSize.width = inputSize.width * scaleAmount;
    inputSize.height = inputSize.height * scaleAmount;
    
    // not really working yet
    
    return [UIImage scaleImage: inImage toSize: inputSize];
}

@end
