//
//  BZAdjustmentProcessor.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustmentProcessor.h"
#import "BZAdjustmentManagedObject.h"
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
    
    for (BZAdjustmentManagedObject *adj in self.session.adjustments)
    {
        outImage = [adj processImage: outImage];
    }
     
    return outImage;
}

@end
