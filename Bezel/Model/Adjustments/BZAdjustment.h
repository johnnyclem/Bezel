//
//  BZAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZAdjustment : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) id value;

// This allows us to remove identical adjustments when adding new ones, when applicable. (like shape masks).
@property (nonatomic, assign, readonly) BOOL duplicatesAllowed;

- (UIImage *)processImage:(UIImage *)inImage;

@end
