//
//  BZ_Session.m
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZ_Session.h"
#import "BZ_Adjustment.h"

@interface BZ_Session ()
@property (nonatomic, retain, readwrite) NSData * currentFullResolutionImage;
@property (nonatomic, retain, readwrite) NSData * currentThumbnailImage;
@end

@implementation BZ_Session

@dynamic currentFullResolutionImage;
@dynamic currentThumbnailImage;
@dynamic imageId;
@dynamic adjustments;

- (void)setFullResolutionImage:(UIImage *)image
{
    self.currentFullResolutionImage = UIImagePNGRepresentation(image);
}
- (void)setThumbnailImage:(UIImage *)image
{
    self.currentThumbnailImage = UIImagePNGRepresentation(image);
}
- (UIImage *)fullResolutionImage
{
    return [UIImage imageWithData: self.currentFullResolutionImage];
}
- (UIImage *)thumbnailImage
{
    return [UIImage imageWithData: self.currentThumbnailImage];
}
@end
