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

@dynamic imageId;
@synthesize adjustments = _adjustments;
@synthesize fullResolutionImage;
@synthesize thumbnailImage;

// Fixes weird to-many relationships bug?
-(void)addAdjustmentsObject:(BZAdjustmentManagedObject *)adjustment
{
    // Grab a pointer to the current adjustment set
    NSMutableOrderedSet *prev;
    NSString *success = @"success";
    
    @try {
        prev = [[NSMutableOrderedSet alloc] initWithCapacity:_adjustments.count+1];        
        NSLog(@"prev has %d objects", _adjustments.count+1);
        
        // Add the new adjustment
        for (int i=0; i<=_adjustments.count; i++) {
            [prev insertObject:adjustment atIndex:i];
            NSLog(@"%@", [prev objectAtIndex:i]);
        }
        [prev addObject:adjustment];
    }
    @catch (NSException *exception) {
        NSLog(@"couldn't add new object");
        success = @"failure";
    }
    @finally {
        NSLog(@"results: %@", success);
    }
}

@end