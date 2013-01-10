//
//  BZBrightnessContrastAdjustment.h
//  Bezel
//
//  Created by Joshua Buchacher on 1/9/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

NSString* const kAdjustmentTypeBrightnessOrContrast;
NSString* const kAdjustmentTypeBrightness;
NSString* const kAdjustmentTypeContrast;

#define kExposureDefaultStep 0.125
#define kContrastDefaultStep 0.125

@interface BZBrightnessContrastAdjustment : BZAdjustment

@property (strong, nonatomic) NSDictionary *value;

- (UIImage *)adjustedImageWithImage:(UIImage *)inImage;

@end
