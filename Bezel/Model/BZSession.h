//
//  BZ_Session.h
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
@property (nonatomic, strong) NSOrderedSet *adjustments;

-(void)addAdjustment:(BZAdjustment *)adjustment;

@end