//
//  BZAdjustmentProcessor.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustmentProcessor.h"
#import "BZAdjustment.h"
#import "BZSession.h"

@implementation BZAdjustmentProcessor

- (id)initWithSession:(BZSession *)aSession
{
    if (self = [super init])
    {
        self.session = aSession;
    }
    
    return self;
}

- (UIImage *)processedThumbnailImage;
{
    UIImage *outImage = self.session.thumbnailImage;
    
    for (BZAdjustment *adj in self.session.adjustments)
    {
        outImage = [adj processImage: outImage];
    }
     
    return outImage;
}

- (UIImage *)processedFullResolutionImage
{
    UIImage *outImage = self.session.thumbnailImage;
  
    NSTimeInterval _startAllAdj = [NSDate timeIntervalSinceReferenceDate];
    
    for (BZAdjustment *adj in self.session.adjustments)
    {
        NSTimeInterval _startAdj = [NSDate timeIntervalSinceReferenceDate];
        outImage = [adj processImage: outImage];
        NSTimeInterval _endAdj = [NSDate timeIntervalSinceReferenceDate];
#ifdef DEBUG
        LogTrace(@"Processing adjustment: %@ took %0.3f ms", adj.identifier, (_endAdj - _startAdj) * 1000.0);
#endif
    }
    
    NSTimeInterval _endAllAdj = [NSDate timeIntervalSinceReferenceDate];
    
#ifdef DEBUG
    LogTrace(@"Processing %u adjustments took %0.3f ms", self.session.adjustments.count, (_endAllAdj - _startAllAdj) * 1000.0);
#endif
    
    return outImage;
}

@end
