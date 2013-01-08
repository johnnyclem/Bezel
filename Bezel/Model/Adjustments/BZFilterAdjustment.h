//
//  BZFilterAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/4/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

@interface BZFilterAdjustment : BZAdjustment

@property (nonatomic, strong) NSDictionary *value;

- (UIImage *)filteredImageWithImage:(UIImage *)image;

@end
