//
//  BZMaskAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZMaskAdjustment.h"
#import "bz_MaskShapeLayer.h"

NSString* const kAdjustmentTypeMask = @"kAdjustmentTypeMask";

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
    CGRect rect = CGRectZero;
    rect.size = inImage.size;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0); {
        [[UIColor blackColor] setFill];
        UIRectFill(rect);
        [[UIColor whiteColor] setFill];
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path.CGPath = [self layerMaskForSize: rect.size].path;
        [path fill];
    }
    
    UIImage *mask = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0); {
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage);
        [inImage drawAtPoint:CGPointZero];
    }
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return maskedImage;
    
}

- (CAShapeLayer *)layerMaskForSize:(CGSize)size
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
