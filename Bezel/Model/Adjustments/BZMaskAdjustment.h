//
//  BZMaskAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

@interface BZMaskAdjustment : BZAdjustment

@property (nonatomic, strong) NSDictionary *value;

- (CALayer *)layerMaskForSize:(CGSize)size;

@end
