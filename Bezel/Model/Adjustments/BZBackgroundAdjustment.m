//
//  BZBackgroundAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/11/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZBackgroundAdjustment.h"
#import "UIImage+Utils.h"
#import "GPUImage.h"

@interface BZBackgroundAdjustment ()
@property (nonatomic, assign) BOOL duplicatesAllowed;
@end

NSString* const kAdjustmentTypeBackgroundColor = @"kAdjustmentTypeBackgroundColor";
NSString* const kAdjustmentTypeBackgroundImage = @"kAdjustmentTypeBackgroundImage";

@implementation BZBackgroundAdjustment

- (id)init
{
    if (self = [super init])
    {
        self.duplicatesAllowed = FALSE;
    }
    
    return self;
}

- (UIImage *)processImage:(UIImage *)inImage
{
    UIImage *bgImage;
    UIColor *color = [self.value objectForKey: kAdjustmentTypeBackgroundColor];
    UIImage *image = [self.value objectForKey: kAdjustmentTypeBackgroundImage];
    
    if (color)
    {
        bgImage = [UIImage imageWithColor: color atSize: inImage.size];
    }
    else if (image)
    {
        bgImage = image;
    }
    else
    {
        LogError(@"Did not provide background adjustment with color or image value! Defaulting to black.");
        bgImage = [UIImage imageWithColor: [UIColor blackColor] atSize: inImage.size];
    }
    
    
    // TODO protect against crashes here due to incomplete filters
    GPUImagePicture *border = [[GPUImagePicture alloc] initWithImage: bgImage];
    GPUImageAlphaBlendFilter *alpha = [[GPUImageAlphaBlendFilter alloc] init];
    GPUImagePicture *imageToProcess = [[GPUImagePicture alloc] initWithImage: inImage];
    alpha.mix = 1.0f;
    [border addTarget:alpha];
    [imageToProcess addTarget:alpha];
    [border processImage];
    [imageToProcess processImage];
    
    return [alpha imageFromCurrentlyProcessedOutput];
}

@end
