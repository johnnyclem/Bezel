//
//  BZMaskAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustment.h"

NSString* const kAdjustmentTypeMask;

@interface BZMaskAdjustment : BZAdjustment

@property (nonatomic, strong) NSDictionary *value;

@property (strong, nonatomic, readonly) NSString *shapeName;
@property (strong, nonatomic, readonly) NSString *shapeAccessibilityLabel;
@property (strong, nonatomic, readonly) NSString *shapeAccessibilityHint;
@property (strong, nonatomic, readonly) NSString *shapeSvgRemoteHref;
@property (strong, nonatomic, readonly) NSString *shapeSvgLocalFilename;

- (id)initWithDictionary:(NSDictionary *)dict;

- (CAShapeLayer *)layerMaskForSize:(CGSize)size;

@end
