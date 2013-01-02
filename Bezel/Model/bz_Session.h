//
//  BZ_Session.h
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BZ_Adjustment;

@interface BZ_Session : NSManagedObject

@property (nonatomic, retain) NSData * currentFullResolutionImage;
@property (nonatomic, retain) NSData * currentThumbnailImage;
@property (nonatomic, retain) NSNumber * imageId;
@property (nonatomic, retain) NSOrderedSet *adjustments;
@end

@interface BZ_Session (CoreDataGeneratedAccessors)

- (void)insertObject:(BZ_Adjustment *)value inAdjustmentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAdjustmentsAtIndex:(NSUInteger)idx;
- (void)insertAdjustments:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAdjustmentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAdjustmentsAtIndex:(NSUInteger)idx withObject:(BZ_Adjustment *)value;
- (void)replaceAdjustmentsAtIndexes:(NSIndexSet *)indexes withAdjustments:(NSArray *)values;
- (void)addAdjustmentsObject:(BZ_Adjustment *)value;
- (void)removeAdjustmentsObject:(BZ_Adjustment *)value;
- (void)addAdjustments:(NSOrderedSet *)values;
- (void)removeAdjustments:(NSOrderedSet *)values;
@end
