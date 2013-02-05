//
//  UIBezierPath+Shapes.h
//  Bezel
//
//  Created by John Clem on 1/30/12.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBezierPath (Shapes)

typedef enum {
    BZShapeTypeAnchor = 1,
    BZShapeTypeCircle,
    BZShapeTypeTriangle
} BZShapeIdentifier;

+ (UIBezierPath*)pathForSize:(CGSize)size withIdentifier:(NSString*)identifier;


@end
