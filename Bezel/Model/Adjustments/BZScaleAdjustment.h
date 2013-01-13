//
//  BZScaleAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/10/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

NSString* const kAdjustmentTypeScale;

@interface BZScaleAdjustment : BZAdjustment

@property (nonatomic, strong) NSDictionary *value;

@end
