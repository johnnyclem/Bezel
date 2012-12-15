//
//  bz_MaskShapeLayer.h
//  EssentialImagerDemo
//
//  Created by John Clem on 12/4/12.
//
//

#import <QuartzCore/QuartzCore.h>

@interface bz_MaskShapeLayer : CAShapeLayer

-(id)initWithCircleShapeAtSize:(CGSize)size;
-(id)initWithOvalShapeAtSize:(CGSize)size;
-(id)initWithTriangleAtSize:(CGSize)size;
-(id)initWithHexagonAtSize:(CGSize)size;
-(id)initWithSquareShapeAtSize:(CGSize)size;
-(id)initWithHeartAtSize:(CGSize)size;

-(id)initWithShapeFromImage:(UIImage*)image atSize:(CGSize)size;

@end
