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
@property (strong, nonatomic) NSMutableArray *adjustments;
@end

@implementation BZSession

- (id)init
{
    if (self = [super init]) {
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
        LogInfo(@"Adjustment %@ was %@", adjustment.identifier, success ? @"added" : @"not added");
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
        LogInfo(@"Adjustment %@ was %@", adjustment.identifier, success ? @"removed" : @"not removed");
    }
}

- (BZAdjustment *)adjustmentWithIdentifier:(NSString *)identifier
{
    for (BZAdjustment *adj in _adjustments)
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