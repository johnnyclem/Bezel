//
//  BZMaskAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZMaskAdjustment.h"
#import "bz_MaskShapeLayer.h"
#import "UIBezierPath+Shapes.h"

NSString *BZ_SHAPE_NAME_KEY = @"shape_name";
NSString *BZ_SHAPE_ACCESSIBILITY_LABEL = @"shape_accessibility_label";
NSString *BZ_SHAPE_ACCESSIBILITY_HINT = @"shape_accessibility_hint";

NSString* const kAdjustmentTypeMask = @"kAdjustmentTypeMask";

@interface BZMaskAdjustment ()

@property (nonatomic, assign) BOOL duplicatesAllowed;
@property (strong, nonatomic) NSMutableDictionary *cachedMasks;

@property (strong, nonatomic) NSString *shapeName;
@property (strong, nonatomic) NSString *shapeAccessibilityLabel;
@property (strong, nonatomic) NSString *shapeAccessibilityHint;

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
        
        // Serialize model object from dictionary.
        self.shapeName = [dict valueForKey: BZ_SHAPE_NAME_KEY];
        self.shapeAccessibilityLabel = [dict valueForKey: BZ_SHAPE_ACCESSIBILITY_LABEL];
        self.shapeAccessibilityHint = [dict valueForKey: BZ_SHAPE_ACCESSIBILITY_HINT];
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
    
    CGRect rect = CGRectMake(0.0, 0.0, inImage.size.width, inImage.size.height);

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    {
        UIBezierPath* path = [UIBezierPath pathForSize: rect.size withIdentifier: self.shapeName];
        [path fill];
    }
    
    UIImage *mask = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    {
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage);
        [inImage drawAtPoint:CGPointZero];
    }
    
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return maskedImage;
}

- (CAShapeLayer *)layerMaskForSize:(CGSize)size
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath pathForSize:size withIdentifier:self.shapeName];
    layer.path = path.CGPath;
    LogInfo(@"Creating mask for: %@", self.shapeName);
    return layer;
}

@end
