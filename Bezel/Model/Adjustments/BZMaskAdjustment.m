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
#import "UIBezierPath+Shapes.h"
#import "UIImage+DrawRect.h"

NSString *BZ_SHAPE_NAME_KEY = @"shape_name";
NSString *BZ_SHAPE_ACCESSIBILITY_LABEL = @"shape_accessibility_label";
NSString *BZ_SHAPE_ACCESSIBILITY_HINT = @"shape_accessibility_hint";
NSString *BZ_SHAPE_SVG_REMOTE_HREF_KEY = @"shape_svg_remote_href";
NSString *BZ_SHAPE_SVG_LOCAL_FILENAME_KEY = @"shape_svg_local_filename";

NSString* const kAdjustmentTypeMask = @"kAdjustmentTypeMask";

@interface BZMaskAdjustment ()

@property (nonatomic, assign) BOOL duplicatesAllowed;
@property (strong, nonatomic) NSMutableDictionary *cachedMasks;

@property (strong, nonatomic) NSString *shapeName;
@property (strong, nonatomic) NSString *shapeAccessibilityLabel;
@property (strong, nonatomic) NSString *shapeAccessibilityHint;
@property (strong, nonatomic) NSString *shapeSvgRemoteHref;
@property (strong, nonatomic) NSString *shapeSvgLocalFilename;

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
        self.shapeSvgRemoteHref = [dict valueForKey: BZ_SHAPE_SVG_REMOTE_HREF_KEY];
        self.shapeSvgLocalFilename = [dict valueForKey: BZ_SHAPE_SVG_LOCAL_FILENAME_KEY];
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
    UIImage *mask = [UIImage imageForSize:rect.size opaque:TRUE withDrawingBlock:^(void)
    {
        UIBezierPath* path = [UIBezierPath pathForSize: rect.size withIdentifier: self.shapeName];
        [path fill];
    }];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0); {
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage);
        [inImage drawAtPoint:CGPointZero];
    }
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return maskedImage;
}

- (UIImage *)maskFromImageNamed:(NSString *)filename inRect:(CGRect)rect
{
    NSAssert(![filename isEqualToString:@""], @"filename must not be nil!");

    if ([self.cachedMasks objectForKey: filename])
    {
        LogInfo(@"Image mask for filename: %@ pulled from cache", filename);
        return [self.cachedMasks objectForKey: filename];
    }
    else
    {   
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
        {
            [[UIColor blackColor] setFill];
            UIRectFill(rect);
            [[UIColor whiteColor] setFill];
            UIBezierPath *path = [[PocketSVG alloc] initFromSVGFileNamed: filename].bezier;            
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

- (CAShapeLayer *)layerMaskForSize:(CGSize)size
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath pathForSize:size withIdentifier:self.shapeSvgLocalFilename];    
    layer.path = path.CGPath;
    
    NSLog(@"creating mask for: %@", self.shapeSvgLocalFilename);
    return layer;
}

@end
