//
//  BZSession.m
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZSession.h"
#import "BZAdjustment.h"

@interface BZSession ()
@property (strong, nonatomic) NSMutableArray *adjustments;
@end

@implementation BZSession

+ (BZSession *)sharedSession
{
    static id singleton = nil;
	static dispatch_once_t pred;
	
	dispatch_once(
                  &pred,
                  ^{ singleton = [[self alloc] init]; }
                  );
    
    return singleton;
}

- (id)init
{
    if (self = [super init])
    {
        self.adjustments = [[NSMutableArray alloc] initWithCapacity: 10];
    }
    
    return self;
}

-(void)addAdjustment:(BZAdjustment *)adjustment
{
    BOOL success = TRUE;
    
    @try
    {
        if ([self containsAdjustment: adjustment] && adjustment.duplicatesAllowed == FALSE)
        {
            [self removeAdjustment: [self adjustmentWithIdentifier: adjustment.identifier]];
        }
        
        [self.adjustments addObject: adjustment];
    }
    @catch (NSException *exception)
    {
        success = FALSE;
        LogError(@"Failed to add adjustment: %@ to adjustments: %@", adjustment.identifier, _adjustments);
    }
    @finally
    {
        NSString *maskId = [adjustment.value objectForKey: kButtonIdentifier];
        LogInfo(@"Adjustment %@ (%@) was %@", adjustment.identifier, maskId, success ? @"added" : @"not added");
    }
}

- (void)removeAdjustment:(BZAdjustment *)adjustment
{
    BOOL success = TRUE;
    
    @try
    {
        if ([self containsAdjustment: adjustment])
        {
            [self.adjustments removeObject: adjustment];
        }
        
    }
    @catch (NSException *exception)
    {
        success = FALSE;
        LogError(@"Failed to remove adjustment: %@ from adjustments: %@", adjustment.identifier, _adjustments);
    }
    @finally
    {
        NSString *maskId = [adjustment.value objectForKey: kButtonIdentifier];
        LogInfo(@"Adjustment %@ (%@) was %@", adjustment.identifier, maskId, success ? @"removed" : @"not removed");
    }
}

- (BZAdjustment *)adjustmentWithIdentifier:(NSString *)identifier
{
    for (BZAdjustment *adj in self.adjustments)
    {
        if ([identifier isEqualToString: adj.identifier])
        {
            return adj;
        }
    }
    
    return nil;
}

- (BOOL)containsAdjustment:(BZAdjustment *)adjustment
{
    BOOL contains = NO;
    NSString *identifier = adjustment.identifier;
    
    for (BZAdjustment *adj in _adjustments)
    {
        if ([identifier isEqualToString: adj.identifier])
        {
            contains = YES;
            break;
        }
    }
    
    return contains;
}

@end