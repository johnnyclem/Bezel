//
//  BZMaskAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZMaskAdjustment.h"

@implementation BZMaskAdjustment

NSString * const kBZMaskAdjustmentMaskImageKey = @"kBZMaskAdjustmentMaskImageKey";
NSString * const kBZMaskAdjustmentMaskShapeKey = @"kBZMaskAdjustmentMaskShapeKey";

@synthesize identifier;
@synthesize value;
@synthesize session;

- (UIImage *)processImage:(UIImage *)inImage
{
    UIImage *outImage = [inImage resizedImage:CGSizeMake(100.0, 100.0) interpolationQuality: kCGInterpolationNone];
    
    return outImage;
}

@end
