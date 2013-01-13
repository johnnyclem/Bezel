//
//  BZAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

@interface BZAdjustment ()
@property (nonatomic, assign) BOOL duplicatesAllowed;
@end

@implementation BZAdjustment

@synthesize identifier;
@synthesize value;
@synthesize duplicatesAllowed;

- (id)init
{
    if (self = [super init]) {
        self.duplicatesAllowed = TRUE;
    }
    
    return self;
}

- (UIImage *)processImage:(UIImage *)inImage
{
    return nil;
}

@end