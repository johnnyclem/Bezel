//
//  BZ_Session.m
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZSession.h"
#import "BZAdjustment.h"

@interface BZSession ()
@end

@implementation BZSession

static NSString *const kAdjustmentsKey = @"adjustments";

@dynamic imageId;
@synthesize adjustments = _adjustments;
@synthesize fullResolutionImage;
@synthesize thumbnailImage;

-(void)addAdjustment:(BZAdjustment *)adjustment
{
    // Grab a pointer to the current adjustment set
    NSMutableOrderedSet *prev;
    NSString *success = @"success";
    
    @try {
        // Make a mutable set to hold the additional adjustment
        prev = [[NSMutableOrderedSet alloc] initWithCapacity:_adjustments.count+1];
        
        // Add the old adjustments
        for (int i=0; i<=_adjustments.count; i++) {
            [prev insertObject:adjustment atIndex:i];
        }
        // Add the new adjustment
        [prev addObject:adjustment];
    }
    @catch (NSException *exception) {
        NSLog(@"couldn't add new object");
        success = @"failure";
    }
    @finally
    {
        self.adjustments = prev;
        NSLog(@"results: %@", success);
    }
}

@end