//
//  BZFilterAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/4/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZFilterAdjustment.h"

@implementation BZFilterAdjustment

- (UIImage *)processImage:(UIImage *)inImage
{
    return [self filteredImageWithImage: inImage];
}

- (UIImage *)filteredImageWithImage:(UIImage *)image
{
    UIImage *filterImage;
    NSString *filterType = [self.value objectForKey: kButtonIdentifier];
    
    if ([filterType isEqualToString: kButtonIdentifierFilterBW1])
    {
        filterImage = [UIImage imageNamed:@"B&W1.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterBW2])
    {
        filterImage = [UIImage imageNamed:@"B&W2.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterBlue])
    {
        filterImage =  [UIImage imageNamed:@"blue.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterDarkFade])
    {
        filterImage =  [UIImage imageNamed:@"DarkFade.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterFaded])
    {
        filterImage = [UIImage imageNamed:@"faded.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterGoldenHr])
    {
        filterImage = [UIImage imageNamed:@"GoldenHr.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterOz])
    {
        filterImage = [UIImage imageNamed:@"oz.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterSepia])
    {
        filterImage = [UIImage imageNamed:@"Sepia.png"];
    }
    else if ([filterType isEqualToString: kButtonIdentifierFilterNormal])
    {
        filterImage = [UIImage imageNamed:@"normal.png"];
    }
    else
    {
        // Bad! No filter value?
        LogError(@"No filter value provied to -filteredImageWithImage.");
        // Default to normal just to be safe.
        filterImage = [UIImage imageNamed:@"normal.png"];
    }
    
    GPUImageLookupFilter *lookupFilter  = [[GPUImageLookupFilter alloc] init];
    GPUImagePicture *stillImageSource   = [[GPUImagePicture alloc] initWithImage: filterImage];
    GPUImagePicture *sourceImage        = [[GPUImagePicture alloc] initWithImage: image];
    
    [sourceImage addTarget:lookupFilter];
    [sourceImage processImage];
    [stillImageSource addTarget:lookupFilter atTextureLocation:1];
    [stillImageSource processImage];

    return [lookupFilter imageFromCurrentlyProcessedOutput];
}


@end
