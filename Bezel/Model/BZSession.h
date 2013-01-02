//
//  BZ_Session.h
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BZAdjustmentManagedObject;

@interface BZSession : NSManagedObject

@property (nonatomic, retain) UIImage *fullResolutionImage;
@property (nonatomic, retain) UIImage *thumbnailImage;
@property (nonatomic, retain) NSNumber *imageId;
@property (nonatomic, retain) NSOrderedSet *adjustments;

@end

@interface BZSession (CoreDataGeneratedAccessors)

- (void)insertObject:(BZAdjustmentManagedObject *)value inAdjustmentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAdjustmentsAtIndex:(NSUInteger)idx;
- (void)insertAdjustments:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAdjustmentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAdjustmentsAtIndex:(NSUInteger)idx withObject:(BZAdjustmentManagedObject *)value;
- (void)replaceAdjustmentsAtIndexes:(NSIndexSet *)indexes withAdjustments:(NSArray *)values;
- (void)addAdjustmentsObject:(BZAdjustmentManagedObject *)value;
- (void)removeAdjustmentsObject:(BZAdjustmentManagedObject *)value;
- (void)addAdjustments:(NSOrderedSet *)values;
- (void)removeAdjustments:(NSOrderedSet *)values;

@end

