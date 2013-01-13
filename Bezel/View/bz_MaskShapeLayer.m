//
//  bz_MaskShapeLayer.m
//  EssentialImagerDemo
//
//  Created by John Clem on 12/4/12.
//
//

#import "bz_MaskShapeLayer.h"

@implementation bz_MaskShapeLayer

-(id)initWithOvalShapeAtSize:(CGSize)size;
{
    
    self = [CAShapeLayer layer];
    self.backgroundColor = [UIColor whiteColor].CGColor;
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(size.width*0.1f, 1, size.width-(size.width*0.2f), size.height-1)];
    self.path = layerPath.CGPath;
    self.fillColor = [UIColor blackColor].CGColor;
    
    return self;
    
}

-(id)initWithSquareShapeAtSize:(CGSize)size;
{
    
    self = [CAShapeLayer layer];
    self.backgroundColor = [UIColor whiteColor].CGColor;
    float width = size.width;
    
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithRect:CGRectMake(width*.05, width*.05, width*.9, width*.9)];
    self.path = layerPath.CGPath;
    self.fillColor = [UIColor blackColor].CGColor;
    
    return self;
    
}


-(id)initWithCircleShapeAtSize:(CGSize)size;
{
    
    self = [CAShapeLayer layer];
    self.backgroundColor = [UIColor whiteColor].CGColor;
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1, 1, size.width-1, size.height-1)];
    self.path = layerPath.CGPath;
    self.fillColor = [UIColor blackColor].CGColor;
    
    return self;

}

-(id)initWithTriangleAtSize:(CGSize)size;
{
    self = [CAShapeLayer layer];
    self.backgroundColor = [UIColor whiteColor].CGColor;
    float width = size.width;
    
    UIBezierPath* trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint: CGPointMake(0.9286*width, 0.1*width)];
    [trianglePath addLineToPoint: CGPointMake(0.489*width, 0.862*width)];
    [trianglePath addLineToPoint: CGPointMake(0.05*width, 0.1*width)];
    [trianglePath addLineToPoint: CGPointMake(0.9286*width, 0.1*width)];
    [trianglePath closePath];

    self.path = trianglePath.CGPath;
    self.fillColor = [UIColor blackColor].CGColor;
    return self;
}

-(id)initWithHexagonAtSize:(CGSize)size;
{
    self = [CAShapeLayer layer];
    self.backgroundColor = [UIColor whiteColor].CGColor;
    float width = size.width;
    
    UIBezierPath* hexagonPath = [UIBezierPath bezierPath];
    [hexagonPath moveToPoint: CGPointMake(.0794*width, .2625*width)];
    [hexagonPath addLineToPoint: CGPointMake(.4902*width, .025*width)];
    [hexagonPath addLineToPoint: CGPointMake(.901*width, .2625*width)];
    [hexagonPath addLineToPoint: CGPointMake(.901*width, .7375*width)];
    [hexagonPath addLineToPoint: CGPointMake(.4902*width, .975*width)];
    [hexagonPath addLineToPoint: CGPointMake(.0794*width, .7375*width)];
    [hexagonPath addLineToPoint: CGPointMake(.0794*width, .2625*width)];
    [hexagonPath closePath];
    
    self.path = hexagonPath.CGPath;
    self.fillColor = [UIColor blackColor].CGColor;
    return self;
}

-(id)initWithHeartAtSize:(CGSize)size;
{
    self = [CAShapeLayer layer];
    self.backgroundColor = [UIColor whiteColor].CGColor;
    float width = size.width/100;

    UIBezierPath* heartPath = [UIBezierPath bezierPath];
    [heartPath moveToPoint: CGPointMake(69.25*width, 4.64*width)];
    [heartPath addLineToPoint: CGPointMake(69.24*width, 4.64*width)];
    [heartPath addCurveToPoint: CGPointMake(49.91*width, 11.62*width) controlPoint1: CGPointMake(61.45*width, 4.64*width) controlPoint2: CGPointMake(54.97*width, 7.37*width)];
    [heartPath addCurveToPoint: CGPointMake(30.57*width, 4.64*width) controlPoint1: CGPointMake(44.85*width, 7.37*width) controlPoint2: CGPointMake(38.37*width, 4.64*width)];
    [heartPath addCurveToPoint: CGPointMake(5.98*width, 17.58*width) controlPoint1: CGPointMake(20.61*width, 4.64*width) controlPoint2: CGPointMake(11.42*width, 9.48*width)];
    [heartPath addCurveToPoint: CGPointMake(4.17*width, 50.61*width) controlPoint1: CGPointMake(2.43*width, 22.86*width) controlPoint2: CGPointMake(-2.51*width, 34.16*width)];
    [heartPath addCurveToPoint: CGPointMake(43.32*width, 90.76*width) controlPoint1: CGPointMake(12.57*width, 71.3*width) controlPoint2: CGPointMake(40.2*width, 88.83*width)];
    [heartPath addLineToPoint: CGPointMake(49.91*width, 94.83*width)];
    [heartPath addLineToPoint: CGPointMake(56.5*width, 90.76*width)];
    [heartPath addCurveToPoint: CGPointMake(95.65*width, 50.61*width) controlPoint1: CGPointMake(59.62*width, 88.83*width) controlPoint2: CGPointMake(87.24*width, 71.31*width)];
    [heartPath addCurveToPoint: CGPointMake(93.84*width, 17.58*width) controlPoint1: CGPointMake(102.33*width, 34.17*width) controlPoint2: CGPointMake(97.39*width, 22.86*width)];
    [heartPath addCurveToPoint: CGPointMake(69.25*width, 4.64*width) controlPoint1: CGPointMake(88.4*width, 9.48*width) controlPoint2: CGPointMake(79.21*width, 4.64*width)];
    [heartPath addLineToPoint: CGPointMake(69.25*width, 4.64*width)];
    [heartPath closePath];

    self.path = heartPath.CGPath;
    self.fillColor = [UIColor blackColor].CGColor;
    return self;

}


-(id)initWithShapeFromImage:(UIImage*)image atSize:(CGSize)size;
{
    self                = [CALayer layer];
    self.contents       = (__bridge id)image.CGImage;
    self.frame          = CGRectMake(0, 0, size.width, size.height);
    
    return self;
}

+(UIImage*)maskImageFromShape:(bz_MaskShapeLayer*)shape atSize:(CGSize)size{
        
    UIGraphicsBeginImageContext(size);
    [shape renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* maskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Crop the image
//    CGImageRef imageRef = CGImageCreateWithImageInRect([maskImage CGImage], CGRectMake(0, 44, 1024, 660));
//    maskImage = [UIImage imageWithCGImage:imageRef];
    
    return maskImage;
}

@end
