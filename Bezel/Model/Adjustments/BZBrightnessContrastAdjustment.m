//
//  BZBrightnessContrastAdjustment.m
//  Bezel
//
//  Created by Joshua Buchacher on 1/9/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZBrightnessContrastAdjustment.h"
#import "GPUImageExposure+Contrast.h"

NSString* const kAdjustmentTypeBrightnessOrContrast = @"kAdjustmentTypeBrightnessOrContrast";
NSString* const kAdjustmentTypeBrightness = @"kAdjustmentTypeBrightness";
NSString* const kAdjustmentTypeContrast = @"kAdjustmentTypeContrast";

@implementation BZBrightnessContrastAdjustment

- (UIImage *)processImage:(UIImage *)inImage
{
    float contrast = [[self.value valueForKey: kAdjustmentTypeContrast] floatValue];
    float exposure = [[self.value valueForKey: kAdjustmentTypeContrast] floatValue];
    
    GPUImageExposure_Contrast *filter = [[GPUImageExposure_Contrast alloc] initWithContrast: contrast andExposure: exposure];
    return [filter imageByFilteringImage: inImage];
}

- (UIImage *)adjustedImageWithImage:(UIImage *)inImage
{
    return [self processImage: inImage];
}

@end
