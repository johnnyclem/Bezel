//
//  BZAdjustmentProcessor.h
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BZSession;

@interface BZAdjustmentProcessor : NSObject

@property (strong, nonatomic) BZSession *session;

- (id)initWithSession:(BZSession *)aSession;

- (UIImage *)processedThumbnailImage;
- (UIImage *)processedFullResolutionImage;

@end
