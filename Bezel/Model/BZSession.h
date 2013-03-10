//
//  BZSession.h
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BZAdjustment;

@interface BZSession : NSObject

@property (nonatomic, strong) UIImage *fullResolutionImage;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) NSNumber *imageId;
@property (nonatomic, strong, readonly) NSMutableArray *adjustments;

+ (BZSession *)sharedSession;

- (void)addAdjustment:(BZAdjustment *)adjustment;
- (void)removeAdjustment:(BZAdjustment *)adjustment;

- (BZAdjustment *)adjustmentWithIdentifier:(NSString *)identifier;

- (BOOL)containsAdjustment:(BZAdjustment *)adjustment;

@end