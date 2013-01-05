//
//  BZMaskAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZMaskAdjustment.h"
#import "bz_MaskShapeLayer.h"

@interface BZMaskAdjustment ()
@property (nonatomic, assign) BOOL duplicatesAllowed;
@end

@implementation BZMaskAdjustment

@synthesize identifier;
@synthesize value;
@synthesize duplicatesAllowed;

- (id)init
{
    if (self = [super init]) {
        self.duplicatesAllowed = FALSE;
    }
    
    return self;
}

- (UIImage *)processImage:(UIImage *)inImage
{
    UIImage *outImage;

    return outImage;
}

- (CALayer *)layerMaskForSize:(CGSize)size
{
    NSString *maskShape = [self.value objectForKey: kButtonIdentifier];

    if ([maskShape isEqualToString: kButtonIdentifierCircleMask])
    {
        return [[bz_MaskShapeLayer alloc] initWithCircleShapeAtSize: size];
    }
    else if ([maskShape isEqualToString: kButtonIdentifierSquareMask])
    {
        return [[bz_MaskShapeLayer alloc] initWithSquareShapeAtSize: size];
    }
    else if ([maskShape isEqualToString: kButtonIdentifierTriangleMask])
    {
        return [[bz_MaskShapeLayer alloc] initWithTriangleAtSize: size];
    }
    else if ([maskShape isEqualToString: kButtonIdentifierHexagonMask])
    {
        return [[bz_MaskShapeLayer alloc] initWithHexagonAtSize: size];
    }
    else if ([maskShape isEqualToString: kButtonIdentifierHeartMask])
    {
        return [[bz_MaskShapeLayer alloc] initWithHeartAtSize: size];
    }
    else
    {
        // This is bad, no shape identifier!
        return [CALayer layer];
    }
}

@end
