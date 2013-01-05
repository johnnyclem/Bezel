//
//  BZMaskAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

NSString * const kBZMaskAdjustmentMaskImageKey;
NSString * const kBZMaskAdjustmentMaskShapeKey;

@interface BZMaskAdjustment : BZAdjustment

@property (nonatomic, retain) NSDictionary *value;

- (CALayer *)layerMaskForView:(UIView *)view;

@end
