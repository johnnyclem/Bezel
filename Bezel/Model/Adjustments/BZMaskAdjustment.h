//
//  BZMaskAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

NSString* const kAdjustmentTypeMask;

@interface BZMaskAdjustment : BZAdjustment

@property (nonatomic, strong) NSDictionary *value;

- (id)initWithDictionary:(NSDictionary *)dict;

- (CAShapeLayer *)layerMaskForSize:(CGSize)size;

@end
