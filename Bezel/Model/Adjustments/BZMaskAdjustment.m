//
//  BZMaskAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZMaskAdjustment.h"
#import "bz_MaskShapeLayer.h"
#import "PocketSVG.h"

NSString* const kAdjustmentTypeMask = @"kAdjustmentTypeMask";

@interface BZMaskAdjustment ()
@property (nonatomic, assign) BOOL duplicatesAllowed;
@property (strong, nonatomic) NSMutableDictionary *cachedMasks;
@end

@implementation BZMaskAdjustment

@synthesize identifier;
@synthesize value;
@synthesize duplicatesAllowed;

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.cachedMasks = [NSMutableArray array];
        self.duplicatesAllowed = FALSE;
    }
    
    return self;
}

- (id)init
{
    NSAssert(FALSE, @"BZMaskAdjustment must be initialized with a dictionary of all required values.");
    return nil;
}

- (UIImage *)processImage:(UIImage *)inImage
{
    if (!inImage)
    {
        return nil;
    }
    
    CGRect rect = CGRectZero;
    rect.size = inImage.size;
    
    UIImage *mask = [self maskFromImageNamed:[self svgFilename]];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0); {
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage);
        [inImage drawAtPoint:CGPointZero];
    }
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return maskedImage;
}

- (UIImage *)maskFromImageNamed:(NSString *)filename
{
    NSAssert(![filename isEqualToString:@""], @"filename must not be nil!");
    
    if ([self.cachedMasks objectForKey: filename])
    {
        LogInfo(@"Image mask for filename: %@ pulled from cache", filename);
        return [self.cachedMasks objectForKey: filename];
    }
    else
    {   
        // TODO fix hardcoded values here
        CGRect rect = CGRectMake(0.0, 0.0, 640.0, 640.0);
        
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
        {
            [[UIColor blackColor] setFill];
            UIRectFill(rect);
            [[UIColor whiteColor] setFill];
            UIBezierPath *path = [[PocketSVG alloc] initFromSVGFileNamed: filename].bezier;

//          CGSize aSize = inImage.size;
//
//          CGSize bezierSize = path.bounds.size;
//          CGFloat xScale = aSize.width / bezierSize.width;
//          CGFloat yScale = aSize.height / bezierSize.height;
//
//          CGAffineTransform transform = CGAffineTransformMakeScale(xScale, yScale);
//          CGPathRef intermediatePath = CGPathCreateCopyByTransformingPath(path.CGPath,
//                                                                        &transform);
//
//          path.CGPath = intermediatePath;
            
            [path fill];
        }
        
        UIImage *mask = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Cache mask
        [self.cachedMasks setObject: mask forKey: filename];
        LogInfo(@"Image mask for filename: %@ stored to cache.", filename);
        
        return mask;
    }
}

- (NSString *)svgFilename
{
    // TODO Remove this and use real filenames...
    return @"test_square";
    
    NSString *maskShape = [self.value objectForKey: kButtonIdentifier];
    
    if ([maskShape isEqualToString: kButtonIdentifierCircleMask])
    {
        return @"";
    }
    else if ([maskShape isEqualToString: kButtonIdentifierSquareMask])
    {
        return @"";
    }
    else if ([maskShape isEqualToString: kButtonIdentifierTriangleMask])
    {
        return @"";
    }
    else if ([maskShape isEqualToString: kButtonIdentifierHexagonMask])
    {
        return @"";
    }
    else if ([maskShape isEqualToString: kButtonIdentifierHeartMask])
    {
        return @"";
    }
    else
    {
        // This is bad, no shape identifier!
        return @"";
    }
}

- (CAShapeLayer *)layerMaskForSize:(CGSize)size
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIBezierPath *path = [[PocketSVG alloc] initFromSVGFileNamed: [self svgFilename]].bezier;
    
    // TODO: Scale to correct value regardless of input image sizes.
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
    CGPathRef intermediatePath = CGPathCreateCopyByTransformingPath(path.CGPath,
                                                                    &transform);
    layer.path = intermediatePath;
    
    return layer;
}

@end
