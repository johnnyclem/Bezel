//
//  BZMaskAdjustment.m
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZMaskAdjustment.h"
#import "UIBezierPath+Shapes.h"

NSString *BZ_SHAPE_NAME_KEY = @"shape_name";
NSString *BZ_SHAPE_ACCESSIBILITY_LABEL = @"shape_accessibility_label";
NSString *BZ_SHAPE_ACCESSIBILITY_HINT = @"shape_accessibility_hint";
NSString *BZ_SHAPE_DRAWING_STRING_KEY = @"shape_drawing_string";

NSString* const kAdjustmentTypeMask = @"kAdjustmentTypeMask";

@interface BZMaskAdjustment ()

@property (nonatomic, assign) BOOL duplicatesAllowed;
@property (strong, nonatomic) NSMutableDictionary *cachedMasks;

@property (strong, nonatomic) NSString *shapeName;
@property (strong, nonatomic) NSString *shapeAccessibilityLabel;
@property (strong, nonatomic) NSString *shapeAccessibilityHint;
@property (strong, nonatomic) NSString *shapeDrawingString;

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
        self.identifier = kAdjustmentTypeMask;
        
        // Serialize model object from dictionary.
        self.shapeName = [dict valueForKey: BZ_SHAPE_NAME_KEY];
        self.shapeAccessibilityLabel = [dict valueForKey: BZ_SHAPE_ACCESSIBILITY_LABEL];
        self.shapeAccessibilityHint = [dict valueForKey: BZ_SHAPE_ACCESSIBILITY_HINT];
        
        self.shapeDrawingString = [dict valueForKey: BZ_SHAPE_DRAWING_STRING_KEY];
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
    if (!inImage) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, inImage.size.width, inImage.size.height);
    UIBezierPath *path = [UIBezierPath pathFromString: self.shapeDrawingString forSize: rect.size];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    [inImage drawAtPoint:CGPointZero];
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outImage;
}

- (CAShapeLayer *)layerMaskForSize:(CGSize)size
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath pathFromString: self.shapeDrawingString forSize: size];
    layer.path = path.CGPath;
    LogInfo(@"Creating mask for: %@", self.shapeName);
    return layer;
}

@end
