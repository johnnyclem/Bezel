//
//  BZ_Session.m
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZSession.h"
#import "BZAdjustmentManagedObject.h"

@interface BZSession ()
@end

@implementation BZSession

static NSString *const kAdjustmentsKey = @"adjustments";

@dynamic fullResolutionImage;
@dynamic thumbnailImage;
@dynamic imageId;
@dynamic adjustments;

// Fixes weird to-many relationships bug?
-(void)addAdjustmentsObject:(BZAdjustmentManagedObject *)adjustment
{
    NSMutableOrderedSet *adjustments = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.adjustments];
    [adjustments addObject: adjustment];
    self.adjustments = adjustments;
}

@end