//
//  bz_Button.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_Button.h"

@implementation bz_Button

@synthesize notificationName = _notificationName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTag:(int)tag {

    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
    }
    return self;

}


-(void)setNotificationName:(NSString *)notificationName {
    
    _notificationName = notificationName;
    [self addTarget:self action:@selector(notify:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)setBackgroundImage:(UIImage *)backgroundImage {
    
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
}

-(void)notify:(bz_Button*)button {

    [[NSNotificationCenter defaultCenter] postNotificationName:button.notificationName object:nil];
    
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color8 = [UIColor colorWithRed: 0.427 green: 0.431 blue: 0.443 alpha: 1];
    UIColor* color7 = [UIColor colorWithRed: 0.169 green: 0.224 blue: 0.565 alpha: 1];
    UIColor* color12 = [UIColor colorWithRed: 0.969 green: 0.58 blue: 0.118 alpha: 1];
    UIColor* color15 = [UIColor colorWithRed: 0.561 green: 0.824 blue: 0.894 alpha: 1];
    UIColor* color21 = [UIColor colorWithRed: 0.933 green: 0.816 blue: 0.533 alpha: 1];
    UIColor* color10 = [UIColor colorWithRed: 0.8 green: 0.212 blue: 0.2 alpha: 1];
    UIColor* color9 = [UIColor colorWithRed: 0.153 green: 0.667 blue: 0.882 alpha: 1];
    UIColor* color11 = [UIColor colorWithRed: 0.82 green: 0.737 blue: 0.329 alpha: 1];
    UIColor* color13 = [UIColor colorWithRed: 0.11 green: 0.459 blue: 0.737 alpha: 1];
    UIColor* color16 = [UIColor colorWithRed: 0.737 green: 0.427 blue: 0.427 alpha: 1];
    UIColor* color18 = [UIColor colorWithRed: 0.91 green: 0.733 blue: 0.702 alpha: 1];
    UIColor* color14 = [UIColor colorWithRed: 0.427 green: 0.651 blue: 0.8 alpha: 1];
    UIColor* color17 = [UIColor colorWithRed: 0.655 green: 0.663 blue: 0.675 alpha: 1];
    UIColor* color19 = [UIColor colorWithRed: 0.925 green: 0.749 blue: 0.114 alpha: 1];
    UIColor* color20 = [UIColor colorWithRed: 0.867 green: 0.608 blue: 0.549 alpha: 1];
    UIColor* color22 = [UIColor colorWithRed: 0.663 green: 0.608 blue: 0.259 alpha: 1];
    UIColor* color23 = [UIColor colorWithRed: 0.325 green: 0.349 blue: 0.463 alpha: 1];
    UIColor* color24 = [UIColor colorWithRed: 0.345 green: 0.349 blue: 0.357 alpha: 1];
    UIColor* color25 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color26 = [UIColor colorWithRed: 0.498 green: 0.451 blue: 0.18 alpha: 1];
    UIColor* color27 = [UIColor colorWithRed: 0.918 green: 0.784 blue: 0.365 alpha: 1];
    UIColor* color28 = [UIColor colorWithRed: 0.945 green: 0.353 blue: 0.161 alpha: 1];
    UIColor* color60 = [UIColor colorWithRed: 0.345 green: 0.349 blue: 0.357 alpha: 1];
    UIColor* color61 = [UIColor colorWithRed: 0.902 green: 0.906 blue: 0.91 alpha: 1];
    UIColor* color62 = [UIColor colorWithRed: 0.255 green: 0.251 blue: 0.259 alpha: 1];
    UIColor* color64 = [UIColor colorWithRed: 0.427 green: 0.431 blue: 0.443 alpha: 1];
    UIColor* color65 = [UIColor colorWithRed: 0.576 green: 0.584 blue: 0.596 alpha: 1];
    UIColor* color66 = [UIColor colorWithRed: 0.655 green: 0.663 blue: 0.675 alpha: 1];
    UIColor* color67 = [UIColor colorWithRed: 0.737 green: 0.745 blue: 0.753 alpha: 1];
    UIColor* color68 = [UIColor colorWithRed: 0.82 green: 0.827 blue: 0.831 alpha: 1];
    UIColor* color69 = [UIColor colorWithRed: 0.345 green: 0.349 blue: 0.357 alpha: 1];
    UIColor* color70 = [UIColor colorWithRed: 0.902 green: 0.906 blue: 0.91 alpha: 1];
    UIColor* color72 = [UIColor colorWithRed: 0.427 green: 0.431 blue: 0.443 alpha: 1];
    UIColor* color73 = [UIColor colorWithRed: 0.655 green: 0.663 blue: 0.675 alpha: 1];
    UIColor* color74 = [UIColor colorWithRed: 0.737 green: 0.745 blue: 0.753 alpha: 1];
    UIColor* color100 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color103 = [UIColor colorWithRed: 0.255 green: 0.251 blue: 0.259 alpha: 1];
    UIColor* color101 = [UIColor colorWithRed: 0.745 green: 0.118 blue: 0.176 alpha: 1];
    UIColor* color102 = [UIColor colorWithRed: 0 green: 0.651 blue: 0.318 alpha: 1];
    UIColor* color104 = [UIColor colorWithRed: 0 green: 0.682 blue: 0.937 alpha: 1];
    UIColor* color105 = [UIColor colorWithRed: 1 green: 0.949 blue: 0 alpha: 1];
    UIColor* color115 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color116 = [UIColor colorWithRed: 0.949 green: 0.867 blue: 0.424 alpha: 1];
    UIColor* color117 = [UIColor colorWithRed: 0.745 green: 0.118 blue: 0.176 alpha: 1];
    UIColor* color118 = [UIColor colorWithRed: 0.902 green: 0.765 blue: 0.157 alpha: 1];
    UIColor* color119 = [UIColor colorWithRed: 0.325 green: 0.533 blue: 0.243 alpha: 1];

    //// Gradient Declarations
    NSArray* sVGID_1_Colors = [NSArray arrayWithObjects:
                               (id)color118.CGColor,
                               (id)color116.CGColor, nil];
    CGFloat sVGID_1_Locations[] = {0, 1};
    CGGradientRef sVGID_1_ = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)sVGID_1_Colors, sVGID_1_Locations);

    switch (self.tag) {
            //// GalleryButton
        case 0:
        {
            //// Bezier 110 Drawing
            UIBezierPath* bezier110Path = [UIBezierPath bezierPath];
            [bezier110Path moveToPoint: CGPointMake(32.27, 30.27)];
            [bezier110Path addLineToPoint: CGPointMake(7.31, 30.27)];
            [bezier110Path addLineToPoint: CGPointMake(7.31, 10.5)];
            [bezier110Path addLineToPoint: CGPointMake(32.27, 10.5)];
            [bezier110Path addLineToPoint: CGPointMake(32.27, 30.27)];
            [bezier110Path closePath];
            [bezier110Path moveToPoint: CGPointMake(11.08, 26.5)];
            [bezier110Path addLineToPoint: CGPointMake(28.5, 26.5)];
            [bezier110Path addLineToPoint: CGPointMake(28.5, 14.26)];
            [bezier110Path addLineToPoint: CGPointMake(11.08, 14.26)];
            [bezier110Path addLineToPoint: CGPointMake(11.08, 26.5)];
            [bezier110Path closePath];
            [color setFill];
            [bezier110Path fill];
            
            
            //// Bezier 109 Drawing
            UIBezierPath* bezier109Path = [UIBezierPath bezierPath];
            [bezier109Path moveToPoint: CGPointMake(34.75, 20.12)];
            [bezier109Path addLineToPoint: CGPointMake(34.75, 23.89)];
            [bezier109Path addLineToPoint: CGPointMake(37.96, 23.89)];
            [bezier109Path addLineToPoint: CGPointMake(37.96, 36.12)];
            [bezier109Path addLineToPoint: CGPointMake(20.7, 36.12)];
            [bezier109Path addLineToPoint: CGPointMake(20.7, 33.1)];
            [bezier109Path addLineToPoint: CGPointMake(16.97, 33.1)];
            [bezier109Path addLineToPoint: CGPointMake(16.97, 39.89)];
            [bezier109Path addLineToPoint: CGPointMake(41.69, 39.89)];
            [bezier109Path addLineToPoint: CGPointMake(41.69, 20.12)];
            [bezier109Path addLineToPoint: CGPointMake(34.75, 20.12)];
            [bezier109Path closePath];
            [color setFill];
            [bezier109Path fill];
        }
            
            break;
        case 1:
            //// CameraButton
        {
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(58.73, 21.49)];
            [bezierPath addCurveToPoint: CGPointMake(58.73, 29.71) controlPoint1: CGPointMake(61.07, 23.76) controlPoint2: CGPointMake(61.07, 27.44)];
            [bezierPath addCurveToPoint: CGPointMake(50.27, 29.71) controlPoint1: CGPointMake(56.39, 31.98) controlPoint2: CGPointMake(52.61, 31.98)];
            [bezierPath addCurveToPoint: CGPointMake(50.27, 21.49) controlPoint1: CGPointMake(47.94, 27.44) controlPoint2: CGPointMake(47.94, 23.76)];
            [bezierPath addCurveToPoint: CGPointMake(58.73, 21.49) controlPoint1: CGPointMake(52.61, 19.21) controlPoint2: CGPointMake(56.39, 19.21)];
            [bezierPath closePath];
            [color setStroke];
            bezierPath.lineWidth = 4;
            [bezierPath stroke];
            
            
            //// Rectangle Drawing
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(32.75, 12.33, 43.5, 26.55)];
            [color setStroke];
            rectanglePath.lineWidth = 4;
            [rectanglePath stroke];
        }
            break;
            //// SettingsButton
        case 2:
        {
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(23.51, 19.87)];
            [bezier2Path addLineToPoint: CGPointMake(25.03, 20.23)];
            [bezier2Path addCurveToPoint: CGPointMake(26.66, 20.86) controlPoint1: CGPointMake(25.61, 20.36) controlPoint2: CGPointMake(26.16, 20.58)];
            [bezier2Path addLineToPoint: CGPointMake(28.01, 21.63)];
            [bezier2Path addLineToPoint: CGPointMake(28.82, 22.93)];
            [bezier2Path addCurveToPoint: CGPointMake(29.48, 24.49) controlPoint1: CGPointMake(29.12, 23.41) controlPoint2: CGPointMake(29.34, 23.94)];
            [bezier2Path addLineToPoint: CGPointMake(29.86, 25.95)];
            [bezier2Path addLineToPoint: CGPointMake(29.46, 27.41)];
            [bezier2Path addCurveToPoint: CGPointMake(28.79, 28.91) controlPoint1: CGPointMake(29.31, 27.94) controlPoint2: CGPointMake(29.09, 28.44)];
            [bezier2Path addLineToPoint: CGPointMake(27.97, 30.21)];
            [bezier2Path addLineToPoint: CGPointMake(26.6, 30.97)];
            [bezier2Path addCurveToPoint: CGPointMake(25.08, 31.56) controlPoint1: CGPointMake(26.12, 31.23) controlPoint2: CGPointMake(25.62, 31.43)];
            [bezier2Path addLineToPoint: CGPointMake(23.55, 31.94)];
            [bezier2Path addLineToPoint: CGPointMake(22, 31.54)];
            [bezier2Path addCurveToPoint: CGPointMake(20.53, 30.96) controlPoint1: CGPointMake(21.49, 31.41) controlPoint2: CGPointMake(20.99, 31.22)];
            [bezier2Path addLineToPoint: CGPointMake(19.15, 30.19)];
            [bezier2Path addLineToPoint: CGPointMake(18.34, 28.87)];
            [bezier2Path addCurveToPoint: CGPointMake(17.71, 27.45) controlPoint1: CGPointMake(18.07, 28.43) controlPoint2: CGPointMake(17.85, 27.95)];
            [bezier2Path addLineToPoint: CGPointMake(17.29, 25.99)];
            [bezier2Path addLineToPoint: CGPointMake(17.67, 24.51)];
            [bezier2Path addCurveToPoint: CGPointMake(18.28, 23.03) controlPoint1: CGPointMake(17.8, 23.99) controlPoint2: CGPointMake(18.01, 23.49)];
            [bezier2Path addLineToPoint: CGPointMake(19.06, 21.71)];
            [bezier2Path addLineToPoint: CGPointMake(20.41, 20.91)];
            [bezier2Path addCurveToPoint: CGPointMake(21.99, 20.26) controlPoint1: CGPointMake(20.9, 20.62) controlPoint2: CGPointMake(21.43, 20.4)];
            [bezier2Path addLineToPoint: CGPointMake(23.51, 19.87)];
            [bezier2Path closePath];
            [bezier2Path moveToPoint: CGPointMake(25.64, 14.46)];
            [bezier2Path addLineToPoint: CGPointMake(21.3, 14.46)];
            [bezier2Path addLineToPoint: CGPointMake(20.99, 16.7)];
            [bezier2Path addCurveToPoint: CGPointMake(18.4, 17.76) controlPoint1: CGPointMake(20.07, 16.93) controlPoint2: CGPointMake(19.2, 17.3)];
            [bezier2Path addLineToPoint: CGPointMake(16.52, 16.39)];
            [bezier2Path addLineToPoint: CGPointMake(13.45, 19.33)];
            [bezier2Path addLineToPoint: CGPointMake(14.93, 21.2)];
            [bezier2Path addCurveToPoint: CGPointMake(13.93, 23.62) controlPoint1: CGPointMake(14.49, 21.95) controlPoint2: CGPointMake(14.15, 22.77)];
            [bezier2Path addLineToPoint: CGPointMake(11.48, 23.94)];
            [bezier2Path addLineToPoint: CGPointMake(11.48, 28.11)];
            [bezier2Path addLineToPoint: CGPointMake(14, 28.44)];
            [bezier2Path addCurveToPoint: CGPointMake(15.03, 30.76) controlPoint1: CGPointMake(14.24, 29.26) controlPoint2: CGPointMake(14.59, 30.04)];
            [bezier2Path addLineToPoint: CGPointMake(13.49, 32.71)];
            [bezier2Path addLineToPoint: CGPointMake(16.56, 35.65)];
            [bezier2Path addLineToPoint: CGPointMake(18.6, 34.15)];
            [bezier2Path addCurveToPoint: CGPointMake(21.02, 35.11) controlPoint1: CGPointMake(19.35, 34.57) controlPoint2: CGPointMake(20.16, 34.9)];
            [bezier2Path addLineToPoint: CGPointMake(21.36, 37.54)];
            [bezier2Path addLineToPoint: CGPointMake(25.7, 37.54)];
            [bezier2Path addLineToPoint: CGPointMake(26.04, 35.14)];
            [bezier2Path addCurveToPoint: CGPointMake(28.52, 34.17) controlPoint1: CGPointMake(26.92, 34.93) controlPoint2: CGPointMake(27.75, 34.6)];
            [bezier2Path addLineToPoint: CGPointMake(30.48, 35.61)];
            [bezier2Path addLineToPoint: CGPointMake(33.55, 32.67)];
            [bezier2Path addLineToPoint: CGPointMake(32.09, 30.82)];
            [bezier2Path addCurveToPoint: CGPointMake(33.18, 28.36) controlPoint1: CGPointMake(32.56, 30.07) controlPoint2: CGPointMake(32.93, 29.24)];
            [bezier2Path addLineToPoint: CGPointMake(35.52, 28.06)];
            [bezier2Path addLineToPoint: CGPointMake(35.52, 23.89)];
            [bezier2Path addLineToPoint: CGPointMake(33.22, 23.59)];
            [bezier2Path addCurveToPoint: CGPointMake(32.13, 21.05) controlPoint1: CGPointMake(32.98, 22.69) controlPoint2: CGPointMake(32.61, 21.83)];
            [bezier2Path addLineToPoint: CGPointMake(33.51, 19.3)];
            [bezier2Path addLineToPoint: CGPointMake(30.45, 16.35)];
            [bezier2Path addLineToPoint: CGPointMake(28.62, 17.69)];
            [bezier2Path addCurveToPoint: CGPointMake(25.95, 16.64) controlPoint1: CGPointMake(27.8, 17.22) controlPoint2: CGPointMake(26.9, 16.87)];
            [bezier2Path addLineToPoint: CGPointMake(25.64, 14.46)];
            [bezier2Path addLineToPoint: CGPointMake(25.64, 14.46)];
            [bezier2Path closePath];
            [color setFill];
            [bezier2Path fill];
        }
            break;
        case 3:
            /// CircleButton
        {
            //// LoupeCircle Drawing
            UIBezierPath* loupeCirclePath = [UIBezierPath bezierPath];
            [loupeCirclePath moveToPoint: CGPointMake(45.99, 10.98)];
            [loupeCirclePath addCurveToPoint: CGPointMake(45.99, 40.02) controlPoint1: CGPointMake(54.01, 19) controlPoint2: CGPointMake(54.01, 32)];
            [loupeCirclePath addCurveToPoint: CGPointMake(16.95, 40.02) controlPoint1: CGPointMake(37.97, 48.04) controlPoint2: CGPointMake(24.97, 48.04)];
            [loupeCirclePath addCurveToPoint: CGPointMake(16.95, 10.98) controlPoint1: CGPointMake(8.93, 32) controlPoint2: CGPointMake(8.93, 19)];
            [loupeCirclePath addCurveToPoint: CGPointMake(45.99, 10.98) controlPoint1: CGPointMake(24.97, 2.96) controlPoint2: CGPointMake(37.97, 2.96)];
            [loupeCirclePath closePath];
            [color setStroke];
            loupeCirclePath.lineWidth = 4;
            [loupeCirclePath stroke];
        }
            break;
        case 4:
            /// SquareButton
        {
            //// LoupeSquare Drawing
            UIBezierPath* loupeSquarePath = [UIBezierPath bezierPath];
            [loupeSquarePath moveToPoint: CGPointMake(15.53, 9.13)];
            [loupeSquarePath addLineToPoint: CGPointMake(49.28, 9.13)];
            [loupeSquarePath addLineToPoint: CGPointMake(49.28, 42.87)];
            [loupeSquarePath addLineToPoint: CGPointMake(15.53, 42.87)];
            [loupeSquarePath addLineToPoint: CGPointMake(15.53, 9.13)];
            [loupeSquarePath closePath];
            [color setStroke];
            loupeSquarePath.lineWidth = 4;
            [loupeSquarePath stroke];
        }
            break;
        case 5:
            /// TriangleButton
        {
            //// LoupeTriangle Drawing
            UIBezierPath* loupeTrianglePath = [UIBezierPath bezierPath];
            [loupeTrianglePath moveToPoint: CGPointMake(50.88, 9.79)];
            [loupeTrianglePath addLineToPoint: CGPointMake(32.16, 42.21)];
            [loupeTrianglePath addLineToPoint: CGPointMake(13.44, 9.79)];
            [loupeTrianglePath addLineToPoint: CGPointMake(50.88, 9.79)];
            [loupeTrianglePath closePath];
            [color setStroke];
            loupeTrianglePath.lineWidth = 4;
            [loupeTrianglePath stroke];
        }
            break;
        case 6:
            /// HexagonButton
        {
            //// LoupeHexagon Drawing
            UIBezierPath* loupeHexagonPath = [UIBezierPath bezierPath];
            [loupeHexagonPath moveToPoint: CGPointMake(14.11, 15.9)];
            [loupeHexagonPath addLineToPoint: CGPointMake(31.61, 5.79)];
            [loupeHexagonPath addLineToPoint: CGPointMake(49.12, 15.9)];
            [loupeHexagonPath addLineToPoint: CGPointMake(49.12, 36.1)];
            [loupeHexagonPath addLineToPoint: CGPointMake(31.61, 46.21)];
            [loupeHexagonPath addLineToPoint: CGPointMake(14.11, 36.1)];
            [loupeHexagonPath addLineToPoint: CGPointMake(14.11, 15.9)];
            [loupeHexagonPath closePath];
            [color setStroke];
            loupeHexagonPath.lineWidth = 4;
            [loupeHexagonPath stroke];
        }
            break;
        case 7:
            //// LoupeHeart Drawing
        {
            //// LoupeHeart Drawing
            UIBezierPath* loupeHeartPath = [UIBezierPath bezierPath];
            [loupeHeartPath moveToPoint: CGPointMake(39.71, 13.5)];
            [loupeHeartPath addCurveToPoint: CGPointMake(45.6, 24.9) controlPoint1: CGPointMake(44.24, 13.5) controlPoint2: CGPointMake(48.47, 17.83)];
            [loupeHeartPath addCurveToPoint: CGPointMake(32, 38.5) controlPoint1: CGPointMake(42.77, 31.86) controlPoint2: CGPointMake(32, 38.5)];
            [loupeHeartPath addCurveToPoint: CGPointMake(18.4, 24.9) controlPoint1: CGPointMake(32, 38.5) controlPoint2: CGPointMake(21.23, 31.86)];
            [loupeHeartPath addCurveToPoint: CGPointMake(24.29, 13.5) controlPoint1: CGPointMake(15.52, 17.83) controlPoint2: CGPointMake(19.76, 13.5)];
            [loupeHeartPath addCurveToPoint: CGPointMake(32, 20.76) controlPoint1: CGPointMake(27.55, 13.5) controlPoint2: CGPointMake(30.95, 15.73)];
            [loupeHeartPath addCurveToPoint: CGPointMake(39.71, 13.5) controlPoint1: CGPointMake(33.05, 15.73) controlPoint2: CGPointMake(36.45, 13.5)];
            [loupeHeartPath closePath];
            [loupeHeartPath moveToPoint: CGPointMake(39.71, 8.5)];
            [loupeHeartPath addLineToPoint: CGPointMake(39.71, 8.5)];
            [loupeHeartPath addCurveToPoint: CGPointMake(32, 11.28) controlPoint1: CGPointMake(36.6, 8.5) controlPoint2: CGPointMake(34.02, 9.58)];
            [loupeHeartPath addCurveToPoint: CGPointMake(24.29, 8.5) controlPoint1: CGPointMake(29.98, 9.58) controlPoint2: CGPointMake(27.4, 8.5)];
            [loupeHeartPath addCurveToPoint: CGPointMake(14.49, 13.65) controlPoint1: CGPointMake(20.32, 8.5) controlPoint2: CGPointMake(16.66, 10.42)];
            [loupeHeartPath addCurveToPoint: CGPointMake(13.77, 26.79) controlPoint1: CGPointMake(13.08, 15.75) controlPoint2: CGPointMake(11.11, 20.24)];
            [loupeHeartPath addCurveToPoint: CGPointMake(29.38, 42.76) controlPoint1: CGPointMake(17.12, 35.02) controlPoint2: CGPointMake(28.13, 41.99)];
            [loupeHeartPath addLineToPoint: CGPointMake(32, 44.38)];
            [loupeHeartPath addLineToPoint: CGPointMake(34.62, 42.76)];
            [loupeHeartPath addCurveToPoint: CGPointMake(50.23, 26.79) controlPoint1: CGPointMake(35.87, 41.99) controlPoint2: CGPointMake(46.88, 35.02)];
            [loupeHeartPath addCurveToPoint: CGPointMake(49.51, 13.65) controlPoint1: CGPointMake(52.89, 20.25) controlPoint2: CGPointMake(50.92, 15.75)];
            [loupeHeartPath addCurveToPoint: CGPointMake(39.71, 8.5) controlPoint1: CGPointMake(47.34, 10.42) controlPoint2: CGPointMake(43.68, 8.5)];
            [loupeHeartPath addLineToPoint: CGPointMake(39.71, 8.5)];
            [loupeHeartPath closePath];
            [color setFill];
            [loupeHeartPath fill];
        }
            break;
        case 8:
            /// RectangleButton
        {
            UIBezierPath* loupeRectanglePath = [UIBezierPath bezierPath];
            [loupeRectanglePath moveToPoint: CGPointMake(18.7, 10.13)];
            [loupeRectanglePath addLineToPoint: CGPointMake(35.57, 10.13)];
            [loupeRectanglePath addLineToPoint: CGPointMake(35.57, 43.87)];
            [loupeRectanglePath addLineToPoint: CGPointMake(18.7, 43.87)];
            [loupeRectanglePath addLineToPoint: CGPointMake(18.7, 10.13)];
            [loupeRectanglePath closePath];
            [color setStroke];
            loupeRectanglePath.lineWidth = 4;
            [loupeRectanglePath stroke];
        }
            break;
        case 9:
            //// FilterOne
        {
            //// Bezier 10 Drawing
            UIBezierPath* bezier10Path = [UIBezierPath bezierPath];
            [bezier10Path moveToPoint: CGPointMake(23.62, 21.74)];
            [bezier10Path addLineToPoint: CGPointMake(22.47, 22.09)];
            [bezier10Path addCurveToPoint: CGPointMake(22.11, 22.14) controlPoint1: CGPointMake(22.36, 22.12) controlPoint2: CGPointMake(22.21, 22.14)];
            [bezier10Path addCurveToPoint: CGPointMake(21.25, 21.31) controlPoint1: CGPointMake(21.65, 22.14) controlPoint2: CGPointMake(21.25, 21.76)];
            [bezier10Path addCurveToPoint: CGPointMake(21.91, 20.46) controlPoint1: CGPointMake(21.25, 20.89) controlPoint2: CGPointMake(21.51, 20.57)];
            [bezier10Path addLineToPoint: CGPointMake(23.6, 19.92)];
            [bezier10Path addCurveToPoint: CGPointMake(24.56, 19.74) controlPoint1: CGPointMake(23.98, 19.81) controlPoint2: CGPointMake(24.27, 19.74)];
            [bezier10Path addLineToPoint: CGPointMake(24.59, 19.74)];
            [bezier10Path addCurveToPoint: CGPointMake(25.56, 20.72) controlPoint1: CGPointMake(25.15, 19.74) controlPoint2: CGPointMake(25.56, 20.17)];
            [bezier10Path addLineToPoint: CGPointMake(25.56, 30.17)];
            [bezier10Path addCurveToPoint: CGPointMake(24.59, 31.15) controlPoint1: CGPointMake(25.56, 30.71) controlPoint2: CGPointMake(25.13, 31.15)];
            [bezier10Path addCurveToPoint: CGPointMake(23.62, 30.17) controlPoint1: CGPointMake(24.06, 31.15) controlPoint2: CGPointMake(23.62, 30.71)];
            [bezier10Path addLineToPoint: CGPointMake(23.62, 21.74)];
            [bezier10Path closePath];
            [color25 setFill];
            [bezier10Path fill];
            
            
            //// Bezier 11 Drawing
            UIBezierPath* bezier11Path = [UIBezierPath bezierPath];
            [bezier11Path moveToPoint: CGPointMake(38.74, 33.66)];
            [bezier11Path addLineToPoint: CGPointMake(24.12, 42.1)];
            [bezier11Path addLineToPoint: CGPointMake(24.12, 42.1)];
            [bezier11Path addLineToPoint: CGPointMake(24.12, 47.29)];
            [bezier11Path addLineToPoint: CGPointMake(24.12, 47.29)];
            [bezier11Path addLineToPoint: CGPointMake(43.24, 36.25)];
            [bezier11Path addLineToPoint: CGPointMake(43.24, 36.16)];
            [bezier11Path addLineToPoint: CGPointMake(38.74, 33.58)];
            [bezier11Path addLineToPoint: CGPointMake(38.74, 33.66)];
            [bezier11Path closePath];
            [color7 setFill];
            [bezier11Path fill];
            
            
            //// Bezier 12 Drawing
            UIBezierPath* bezier12Path = [UIBezierPath bezierPath];
            [bezier12Path moveToPoint: CGPointMake(9.49, 33.66)];
            [bezier12Path addLineToPoint: CGPointMake(9.49, 33.62)];
            [bezier12Path addLineToPoint: CGPointMake(5, 36.22)];
            [bezier12Path addLineToPoint: CGPointMake(5, 36.25)];
            [bezier12Path addLineToPoint: CGPointMake(24.12, 47.29)];
            [bezier12Path addLineToPoint: CGPointMake(24.12, 42.1)];
            [bezier12Path addLineToPoint: CGPointMake(9.49, 33.66)];
            [bezier12Path closePath];
            [color25 setFill];
            [bezier12Path fill];
            
            
            //// Bezier 13 Drawing
            UIBezierPath* bezier13Path = [UIBezierPath bezierPath];
            [bezier13Path moveToPoint: CGPointMake(43.16, 14.13)];
            [bezier13Path addLineToPoint: CGPointMake(38.67, 16.73)];
            [bezier13Path addLineToPoint: CGPointMake(38.74, 16.77)];
            [bezier13Path addLineToPoint: CGPointMake(38.74, 33.58)];
            [bezier13Path addLineToPoint: CGPointMake(43.24, 36.16)];
            [bezier13Path addLineToPoint: CGPointMake(43.24, 14.18)];
            [bezier13Path addLineToPoint: CGPointMake(43.16, 14.13)];
            [bezier13Path closePath];
            [color13 setFill];
            [bezier13Path fill];
            
            
            //// Bezier 14 Drawing
            UIBezierPath* bezier14Path = [UIBezierPath bezierPath];
            [bezier14Path moveToPoint: CGPointMake(24.12, 8.33)];
            [bezier14Path addLineToPoint: CGPointMake(38.67, 16.73)];
            [bezier14Path addLineToPoint: CGPointMake(43.16, 14.13)];
            [bezier14Path addLineToPoint: CGPointMake(24.12, 3.14)];
            [bezier14Path addLineToPoint: CGPointMake(24.12, 3.14)];
            [bezier14Path addLineToPoint: CGPointMake(24.12, 8.33)];
            [bezier14Path addLineToPoint: CGPointMake(24.12, 8.33)];
            [bezier14Path closePath];
            [color9 setFill];
            [bezier14Path fill];
            
            
            //// Bezier 15 Drawing
            UIBezierPath* bezier15Path = [UIBezierPath bezierPath];
            [bezier15Path moveToPoint: CGPointMake(24.12, 8.33)];
            [bezier15Path addLineToPoint: CGPointMake(24.12, 3.14)];
            [bezier15Path addLineToPoint: CGPointMake(5, 14.18)];
            [bezier15Path addLineToPoint: CGPointMake(5, 14.18)];
            [bezier15Path addLineToPoint: CGPointMake(9.5, 16.77)];
            [bezier15Path addLineToPoint: CGPointMake(24.12, 8.33)];
            [bezier15Path closePath];
            [color25 setFill];
            [bezier15Path fill];
            
            
            //// Bezier 16 Drawing
            UIBezierPath* bezier16Path = [UIBezierPath bezierPath];
            [bezier16Path moveToPoint: CGPointMake(9.49, 16.77)];
            [bezier16Path addLineToPoint: CGPointMake(9.5, 16.77)];
            [bezier16Path addLineToPoint: CGPointMake(5, 14.18)];
            [bezier16Path addLineToPoint: CGPointMake(5, 36.22)];
            [bezier16Path addLineToPoint: CGPointMake(9.49, 33.62)];
            [bezier16Path addLineToPoint: CGPointMake(9.49, 16.77)];
            [bezier16Path closePath];
            [color25 setFill];
            [bezier16Path fill];
        }
            break;
        case 10:
            //// FilterTwo
        {
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(21.02, 29.09)];
            [bezier3Path addLineToPoint: CGPointMake(24.45, 26.16)];
            [bezier3Path addCurveToPoint: CGPointMake(26.55, 23.14) controlPoint1: CGPointMake(25.99, 24.87) controlPoint2: CGPointMake(26.55, 24.15)];
            [bezier3Path addCurveToPoint: CGPointMake(24.74, 21.41) controlPoint1: CGPointMake(26.55, 22.04) controlPoint2: CGPointMake(25.76, 21.41)];
            [bezier3Path addCurveToPoint: CGPointMake(22.54, 22.65) controlPoint1: CGPointMake(23.85, 21.41) controlPoint2: CGPointMake(23.22, 21.82)];
            [bezier3Path addCurveToPoint: CGPointMake(21.85, 22.95) controlPoint1: CGPointMake(22.39, 22.81) controlPoint2: CGPointMake(22.17, 22.95)];
            [bezier3Path addCurveToPoint: CGPointMake(20.95, 22.06) controlPoint1: CGPointMake(21.35, 22.95) controlPoint2: CGPointMake(20.95, 22.56)];
            [bezier3Path addCurveToPoint: CGPointMake(21.18, 21.45) controlPoint1: CGPointMake(20.95, 21.85) controlPoint2: CGPointMake(21.03, 21.63)];
            [bezier3Path addCurveToPoint: CGPointMake(24.88, 19.65) controlPoint1: CGPointMake(22.09, 20.32) controlPoint2: CGPointMake(23.13, 19.65)];
            [bezier3Path addCurveToPoint: CGPointMake(28.57, 22.99) controlPoint1: CGPointMake(27.07, 19.65) controlPoint2: CGPointMake(28.57, 20.99)];
            [bezier3Path addLineToPoint: CGPointMake(28.57, 23.02)];
            [bezier3Path addCurveToPoint: CGPointMake(25.67, 27.35) controlPoint1: CGPointMake(28.57, 24.77) controlPoint2: CGPointMake(27.65, 25.73)];
            [bezier3Path addLineToPoint: CGPointMake(23.37, 29.26)];
            [bezier3Path addLineToPoint: CGPointMake(27.9, 29.26)];
            [bezier3Path addCurveToPoint: CGPointMake(28.77, 30.12) controlPoint1: CGPointMake(28.38, 29.26) controlPoint2: CGPointMake(28.77, 29.65)];
            [bezier3Path addCurveToPoint: CGPointMake(27.9, 30.99) controlPoint1: CGPointMake(28.77, 30.6) controlPoint2: CGPointMake(28.38, 30.99)];
            [bezier3Path addLineToPoint: CGPointMake(21.56, 30.99)];
            [bezier3Path addCurveToPoint: CGPointMake(20.51, 30.06) controlPoint1: CGPointMake(20.96, 30.99) controlPoint2: CGPointMake(20.51, 30.63)];
            [bezier3Path addCurveToPoint: CGPointMake(21.02, 29.09) controlPoint1: CGPointMake(20.51, 29.68) controlPoint2: CGPointMake(20.68, 29.36)];
            [bezier3Path closePath];
            [color25 setFill];
            [bezier3Path fill];
            
            
            //// Bezier 23 Drawing
            UIBezierPath* bezier23Path = [UIBezierPath bezierPath];
            [bezier23Path moveToPoint: CGPointMake(39.2, 34.23)];
            [bezier23Path addLineToPoint: CGPointMake(24.57, 42.68)];
            [bezier23Path addLineToPoint: CGPointMake(24.57, 42.68)];
            [bezier23Path addLineToPoint: CGPointMake(24.57, 47.86)];
            [bezier23Path addLineToPoint: CGPointMake(24.57, 47.86)];
            [bezier23Path addLineToPoint: CGPointMake(43.69, 36.82)];
            [bezier23Path addLineToPoint: CGPointMake(43.69, 36.73)];
            [bezier23Path addLineToPoint: CGPointMake(39.2, 34.15)];
            [bezier23Path addLineToPoint: CGPointMake(39.2, 34.23)];
            [bezier23Path closePath];
            [color24 setFill];
            [bezier23Path fill];
            
            
            //// Bezier 24 Drawing
            UIBezierPath* bezier24Path = [UIBezierPath bezierPath];
            [bezier24Path moveToPoint: CGPointMake(9.94, 34.23)];
            [bezier24Path addLineToPoint: CGPointMake(9.94, 34.19)];
            [bezier24Path addLineToPoint: CGPointMake(5.45, 36.78)];
            [bezier24Path addLineToPoint: CGPointMake(5.45, 36.82)];
            [bezier24Path addLineToPoint: CGPointMake(24.57, 47.86)];
            [bezier24Path addLineToPoint: CGPointMake(24.57, 42.68)];
            [bezier24Path addLineToPoint: CGPointMake(9.94, 34.23)];
            [bezier24Path closePath];
            [color25 setFill];
            [bezier24Path fill];
            
            
            //// Bezier 25 Drawing
            UIBezierPath* bezier25Path = [UIBezierPath bezierPath];
            [bezier25Path moveToPoint: CGPointMake(43.61, 14.7)];
            [bezier25Path addLineToPoint: CGPointMake(39.12, 17.3)];
            [bezier25Path addLineToPoint: CGPointMake(39.2, 17.34)];
            [bezier25Path addLineToPoint: CGPointMake(39.2, 34.15)];
            [bezier25Path addLineToPoint: CGPointMake(43.69, 36.73)];
            [bezier25Path addLineToPoint: CGPointMake(43.69, 14.75)];
            [bezier25Path addLineToPoint: CGPointMake(43.61, 14.7)];
            [bezier25Path closePath];
            [color8 setFill];
            [bezier25Path fill];
            
            
            //// Bezier 26 Drawing
            UIBezierPath* bezier26Path = [UIBezierPath bezierPath];
            [bezier26Path moveToPoint: CGPointMake(24.57, 8.9)];
            [bezier26Path addLineToPoint: CGPointMake(39.12, 17.3)];
            [bezier26Path addLineToPoint: CGPointMake(43.61, 14.7)];
            [bezier26Path addLineToPoint: CGPointMake(24.57, 3.71)];
            [bezier26Path addLineToPoint: CGPointMake(24.57, 3.71)];
            [bezier26Path addLineToPoint: CGPointMake(24.57, 8.9)];
            [bezier26Path closePath];
            [color17 setFill];
            [bezier26Path fill];
            
            
            //// Bezier 27 Drawing
            UIBezierPath* bezier27Path = [UIBezierPath bezierPath];
            [bezier27Path moveToPoint: CGPointMake(24.57, 8.9)];
            [bezier27Path addLineToPoint: CGPointMake(24.57, 3.71)];
            [bezier27Path addLineToPoint: CGPointMake(5.45, 14.75)];
            [bezier27Path addLineToPoint: CGPointMake(5.45, 14.75)];
            [bezier27Path addLineToPoint: CGPointMake(9.95, 17.34)];
            [bezier27Path addLineToPoint: CGPointMake(24.57, 8.9)];
            [bezier27Path closePath];
            [color25 setFill];
            [bezier27Path fill];
            
            
            //// Bezier 28 Drawing
            UIBezierPath* bezier28Path = [UIBezierPath bezierPath];
            [bezier28Path moveToPoint: CGPointMake(9.94, 17.34)];
            [bezier28Path addLineToPoint: CGPointMake(9.95, 17.34)];
            [bezier28Path addLineToPoint: CGPointMake(5.45, 14.75)];
            [bezier28Path addLineToPoint: CGPointMake(5.45, 36.78)];
            [bezier28Path addLineToPoint: CGPointMake(9.94, 34.19)];
            [bezier28Path addLineToPoint: CGPointMake(9.94, 17.34)];
            [bezier28Path closePath];
            [color25 setFill];
            [bezier28Path fill];
        }
            break;
        case 11:
            //// FilterThree
        {
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(21.5, 29.81)];
            [bezier4Path addCurveToPoint: CGPointMake(21.19, 29.1) controlPoint1: CGPointMake(21.33, 29.66) controlPoint2: CGPointMake(21.19, 29.39)];
            [bezier4Path addCurveToPoint: CGPointMake(22.13, 28.16) controlPoint1: CGPointMake(21.19, 28.59) controlPoint2: CGPointMake(21.62, 28.16)];
            [bezier4Path addCurveToPoint: CGPointMake(22.78, 28.41) controlPoint1: CGPointMake(22.41, 28.16) controlPoint2: CGPointMake(22.62, 28.27)];
            [bezier4Path addCurveToPoint: CGPointMake(25.32, 29.48) controlPoint1: CGPointMake(23.48, 29.12) controlPoint2: CGPointMake(24.28, 29.48)];
            [bezier4Path addCurveToPoint: CGPointMake(27.25, 27.79) controlPoint1: CGPointMake(26.42, 29.48) controlPoint2: CGPointMake(27.25, 28.81)];
            [bezier4Path addLineToPoint: CGPointMake(27.25, 27.76)];
            [bezier4Path addCurveToPoint: CGPointMake(24.68, 26.03) controlPoint1: CGPointMake(27.25, 26.66) controlPoint2: CGPointMake(26.25, 26.03)];
            [bezier4Path addLineToPoint: CGPointMake(24.28, 26.03)];
            [bezier4Path addCurveToPoint: CGPointMake(23.44, 25.19) controlPoint1: CGPointMake(23.82, 26.03) controlPoint2: CGPointMake(23.44, 25.65)];
            [bezier4Path addCurveToPoint: CGPointMake(23.85, 24.39) controlPoint1: CGPointMake(23.44, 24.93) controlPoint2: CGPointMake(23.55, 24.69)];
            [bezier4Path addLineToPoint: CGPointMake(26.47, 21.59)];
            [bezier4Path addLineToPoint: CGPointMake(22.41, 21.59)];
            [bezier4Path addCurveToPoint: CGPointMake(21.55, 20.75) controlPoint1: CGPointMake(21.94, 21.59) controlPoint2: CGPointMake(21.55, 21.21)];
            [bezier4Path addCurveToPoint: CGPointMake(22.41, 19.89) controlPoint1: CGPointMake(21.55, 20.27) controlPoint2: CGPointMake(21.94, 19.89)];
            [bezier4Path addLineToPoint: CGPointMake(28.13, 19.89)];
            [bezier4Path addCurveToPoint: CGPointMake(29.11, 20.75) controlPoint1: CGPointMake(28.69, 19.89) controlPoint2: CGPointMake(29.11, 20.22)];
            [bezier4Path addCurveToPoint: CGPointMake(28.55, 21.82) controlPoint1: CGPointMake(29.11, 21.21) controlPoint2: CGPointMake(28.88, 21.48)];
            [bezier4Path addLineToPoint: CGPointMake(25.91, 24.55)];
            [bezier4Path addCurveToPoint: CGPointMake(29.2, 27.68) controlPoint1: CGPointMake(27.6, 24.76) controlPoint2: CGPointMake(29.2, 25.62)];
            [bezier4Path addLineToPoint: CGPointMake(29.2, 27.71)];
            [bezier4Path addCurveToPoint: CGPointMake(25.29, 31.25) controlPoint1: CGPointMake(29.2, 29.77) controlPoint2: CGPointMake(27.62, 31.25)];
            [bezier4Path addCurveToPoint: CGPointMake(21.5, 29.81) controlPoint1: CGPointMake(23.64, 31.26) controlPoint2: CGPointMake(22.42, 30.68)];
            [bezier4Path closePath];
            [color25 setFill];
            [bezier4Path fill];
            
            
            //// Bezier 17 Drawing
            UIBezierPath* bezier17Path = [UIBezierPath bezierPath];
            [bezier17Path moveToPoint: CGPointMake(39.65, 33.66)];
            [bezier17Path addLineToPoint: CGPointMake(25.02, 42.1)];
            [bezier17Path addLineToPoint: CGPointMake(25.02, 42.1)];
            [bezier17Path addLineToPoint: CGPointMake(25.02, 47.29)];
            [bezier17Path addLineToPoint: CGPointMake(25.02, 47.29)];
            [bezier17Path addLineToPoint: CGPointMake(44.14, 36.25)];
            [bezier17Path addLineToPoint: CGPointMake(44.14, 36.16)];
            [bezier17Path addLineToPoint: CGPointMake(39.65, 33.58)];
            [bezier17Path addLineToPoint: CGPointMake(39.65, 33.66)];
            [bezier17Path closePath];
            [color26 setFill];
            [bezier17Path fill];
            
            
            //// Bezier 18 Drawing
            UIBezierPath* bezier18Path = [UIBezierPath bezierPath];
            [bezier18Path moveToPoint: CGPointMake(10.39, 33.66)];
            [bezier18Path addLineToPoint: CGPointMake(10.39, 33.62)];
            [bezier18Path addLineToPoint: CGPointMake(5.9, 36.22)];
            [bezier18Path addLineToPoint: CGPointMake(5.9, 36.25)];
            [bezier18Path addLineToPoint: CGPointMake(25.02, 47.29)];
            [bezier18Path addLineToPoint: CGPointMake(25.02, 42.1)];
            [bezier18Path addLineToPoint: CGPointMake(10.39, 33.66)];
            [bezier18Path closePath];
            [color25 setFill];
            [bezier18Path fill];
            
            
            //// Bezier 19 Drawing
            UIBezierPath* bezier19Path = [UIBezierPath bezierPath];
            [bezier19Path moveToPoint: CGPointMake(44.06, 14.13)];
            [bezier19Path addLineToPoint: CGPointMake(39.57, 16.73)];
            [bezier19Path addLineToPoint: CGPointMake(39.65, 16.77)];
            [bezier19Path addLineToPoint: CGPointMake(39.65, 33.58)];
            [bezier19Path addLineToPoint: CGPointMake(44.14, 36.16)];
            [bezier19Path addLineToPoint: CGPointMake(44.14, 14.18)];
            [bezier19Path addLineToPoint: CGPointMake(44.06, 14.13)];
            [bezier19Path closePath];
            [color22 setFill];
            [bezier19Path fill];
            
            
            //// Bezier 20 Drawing
            UIBezierPath* bezier20Path = [UIBezierPath bezierPath];
            [bezier20Path moveToPoint: CGPointMake(25.02, 8.33)];
            [bezier20Path addLineToPoint: CGPointMake(39.57, 16.73)];
            [bezier20Path addLineToPoint: CGPointMake(44.06, 14.13)];
            [bezier20Path addLineToPoint: CGPointMake(25.02, 3.14)];
            [bezier20Path addLineToPoint: CGPointMake(25.02, 3.14)];
            [bezier20Path addLineToPoint: CGPointMake(25.02, 8.33)];
            [bezier20Path closePath];
            [color11 setFill];
            [bezier20Path fill];
            
            
            //// Bezier 21 Drawing
            UIBezierPath* bezier21Path = [UIBezierPath bezierPath];
            [bezier21Path moveToPoint: CGPointMake(25.02, 8.33)];
            [bezier21Path addLineToPoint: CGPointMake(25.02, 3.14)];
            [bezier21Path addLineToPoint: CGPointMake(5.9, 14.18)];
            [bezier21Path addLineToPoint: CGPointMake(5.9, 14.18)];
            [bezier21Path addLineToPoint: CGPointMake(10.4, 16.77)];
            [bezier21Path addLineToPoint: CGPointMake(25.02, 8.33)];
            [bezier21Path closePath];
            [color25 setFill];
            [bezier21Path fill];
            
            
            //// Bezier 22 Drawing
            UIBezierPath* bezier22Path = [UIBezierPath bezierPath];
            [bezier22Path moveToPoint: CGPointMake(10.39, 16.77)];
            [bezier22Path addLineToPoint: CGPointMake(10.4, 16.77)];
            [bezier22Path addLineToPoint: CGPointMake(5.9, 14.18)];
            [bezier22Path addLineToPoint: CGPointMake(5.9, 36.22)];
            [bezier22Path addLineToPoint: CGPointMake(10.39, 33.62)];
            [bezier22Path addLineToPoint: CGPointMake(10.39, 16.77)];
            [bezier22Path closePath];
            [color25 setFill];
            [bezier22Path fill];
        }
            break;
        case 12:
            //// FilterFour
        {
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(25.21, 28.48)];
            [bezier5Path addLineToPoint: CGPointMake(20.21, 28.48)];
            [bezier5Path addCurveToPoint: CGPointMake(19.25, 27.55) controlPoint1: CGPointMake(19.68, 28.48) controlPoint2: CGPointMake(19.25, 28.09)];
            [bezier5Path addCurveToPoint: CGPointMake(19.68, 26.52) controlPoint1: CGPointMake(19.25, 27.17) controlPoint2: CGPointMake(19.4, 26.85)];
            [bezier5Path addLineToPoint: CGPointMake(24.94, 20.29)];
            [bezier5Path addCurveToPoint: CGPointMake(26.13, 19.65) controlPoint1: CGPointMake(25.29, 19.87) controlPoint2: CGPointMake(25.56, 19.65)];
            [bezier5Path addCurveToPoint: CGPointMake(27.09, 20.59) controlPoint1: CGPointMake(26.66, 19.65) controlPoint2: CGPointMake(27.09, 20.06)];
            [bezier5Path addLineToPoint: CGPointMake(27.09, 26.86)];
            [bezier5Path addLineToPoint: CGPointMake(27.95, 26.86)];
            [bezier5Path addCurveToPoint: CGPointMake(28.77, 27.68) controlPoint1: CGPointMake(28.42, 26.86) controlPoint2: CGPointMake(28.77, 27.23)];
            [bezier5Path addCurveToPoint: CGPointMake(27.95, 28.48) controlPoint1: CGPointMake(28.77, 28.13) controlPoint2: CGPointMake(28.42, 28.48)];
            [bezier5Path addLineToPoint: CGPointMake(27.09, 28.48)];
            [bezier5Path addLineToPoint: CGPointMake(27.09, 30.14)];
            [bezier5Path addCurveToPoint: CGPointMake(26.15, 31.06) controlPoint1: CGPointMake(27.09, 30.66) controlPoint2: CGPointMake(26.68, 31.06)];
            [bezier5Path addCurveToPoint: CGPointMake(25.21, 30.14) controlPoint1: CGPointMake(25.62, 31.06) controlPoint2: CGPointMake(25.21, 30.67)];
            [bezier5Path addLineToPoint: CGPointMake(25.21, 28.48)];
            [bezier5Path closePath];
            [bezier5Path moveToPoint: CGPointMake(25.21, 26.87)];
            [bezier5Path addLineToPoint: CGPointMake(25.21, 22.44)];
            [bezier5Path addLineToPoint: CGPointMake(21.53, 26.87)];
            [bezier5Path addLineToPoint: CGPointMake(25.21, 26.87)];
            [bezier5Path closePath];
            [color25 setFill];
            [bezier5Path fill];
            
            
            //// Bezier 29 Drawing
            UIBezierPath* bezier29Path = [UIBezierPath bezierPath];
            [bezier29Path moveToPoint: CGPointMake(39.53, 34.23)];
            [bezier29Path addLineToPoint: CGPointMake(24.91, 42.68)];
            [bezier29Path addLineToPoint: CGPointMake(24.91, 42.68)];
            [bezier29Path addLineToPoint: CGPointMake(24.91, 47.86)];
            [bezier29Path addLineToPoint: CGPointMake(24.91, 47.86)];
            [bezier29Path addLineToPoint: CGPointMake(44.03, 36.82)];
            [bezier29Path addLineToPoint: CGPointMake(44.03, 36.73)];
            [bezier29Path addLineToPoint: CGPointMake(39.53, 34.15)];
            [bezier29Path addLineToPoint: CGPointMake(39.53, 34.23)];
            [bezier29Path closePath];
            [color10 setFill];
            [bezier29Path fill];
            
            
            //// Bezier 30 Drawing
            UIBezierPath* bezier30Path = [UIBezierPath bezierPath];
            [bezier30Path moveToPoint: CGPointMake(10.28, 34.23)];
            [bezier30Path addLineToPoint: CGPointMake(10.28, 34.19)];
            [bezier30Path addLineToPoint: CGPointMake(5.79, 36.78)];
            [bezier30Path addLineToPoint: CGPointMake(5.79, 36.82)];
            [bezier30Path addLineToPoint: CGPointMake(24.91, 47.86)];
            [bezier30Path addLineToPoint: CGPointMake(24.91, 42.68)];
            [bezier30Path addLineToPoint: CGPointMake(10.28, 34.23)];
            [bezier30Path closePath];
            [color25 setFill];
            [bezier30Path fill];
            
            
            //// Bezier 31 Drawing
            UIBezierPath* bezier31Path = [UIBezierPath bezierPath];
            [bezier31Path moveToPoint: CGPointMake(43.94, 14.7)];
            [bezier31Path addLineToPoint: CGPointMake(39.46, 17.3)];
            [bezier31Path addLineToPoint: CGPointMake(39.53, 17.34)];
            [bezier31Path addLineToPoint: CGPointMake(39.53, 34.15)];
            [bezier31Path addLineToPoint: CGPointMake(44.03, 36.73)];
            [bezier31Path addLineToPoint: CGPointMake(44.03, 14.75)];
            [bezier31Path addLineToPoint: CGPointMake(43.94, 14.7)];
            [bezier31Path closePath];
            [color28 setFill];
            [bezier31Path fill];
            
            
            //// Bezier 32 Drawing
            UIBezierPath* bezier32Path = [UIBezierPath bezierPath];
            [bezier32Path moveToPoint: CGPointMake(24.91, 8.9)];
            [bezier32Path addLineToPoint: CGPointMake(39.46, 17.3)];
            [bezier32Path addLineToPoint: CGPointMake(43.94, 14.7)];
            [bezier32Path addLineToPoint: CGPointMake(24.91, 3.71)];
            [bezier32Path addLineToPoint: CGPointMake(24.91, 3.71)];
            [bezier32Path addLineToPoint: CGPointMake(24.91, 8.9)];
            [bezier32Path closePath];
            [color12 setFill];
            [bezier32Path fill];
            
            
            //// Bezier 33 Drawing
            UIBezierPath* bezier33Path = [UIBezierPath bezierPath];
            [bezier33Path moveToPoint: CGPointMake(24.91, 8.9)];
            [bezier33Path addLineToPoint: CGPointMake(24.91, 3.71)];
            [bezier33Path addLineToPoint: CGPointMake(5.79, 14.75)];
            [bezier33Path addLineToPoint: CGPointMake(5.79, 14.75)];
            [bezier33Path addLineToPoint: CGPointMake(10.29, 17.34)];
            [bezier33Path addLineToPoint: CGPointMake(24.91, 8.9)];
            [bezier33Path closePath];
            [color25 setFill];
            [bezier33Path fill];
            
            
            //// Bezier 34 Drawing
            UIBezierPath* bezier34Path = [UIBezierPath bezierPath];
            [bezier34Path moveToPoint: CGPointMake(10.28, 17.34)];
            [bezier34Path addLineToPoint: CGPointMake(10.29, 17.34)];
            [bezier34Path addLineToPoint: CGPointMake(5.79, 14.75)];
            [bezier34Path addLineToPoint: CGPointMake(5.79, 36.78)];
            [bezier34Path addLineToPoint: CGPointMake(10.28, 34.19)];
            [bezier34Path addLineToPoint: CGPointMake(10.28, 17.34)];
            [bezier34Path closePath];
            [color25 setFill];
            [bezier34Path fill];
        }
            break;
        case 13:
            //// FilterFive
        {
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(21.01, 30.04)];
            [bezier6Path addCurveToPoint: CGPointMake(20.62, 29.28) controlPoint1: CGPointMake(20.78, 29.85) controlPoint2: CGPointMake(20.62, 29.6)];
            [bezier6Path addCurveToPoint: CGPointMake(21.56, 28.33) controlPoint1: CGPointMake(20.62, 28.77) controlPoint2: CGPointMake(21.05, 28.33)];
            [bezier6Path addCurveToPoint: CGPointMake(22.13, 28.53) controlPoint1: CGPointMake(21.8, 28.33) controlPoint2: CGPointMake(21.97, 28.4)];
            [bezier6Path addCurveToPoint: CGPointMake(24.56, 29.47) controlPoint1: CGPointMake(22.9, 29.15) controlPoint2: CGPointMake(23.68, 29.47)];
            [bezier6Path addCurveToPoint: CGPointMake(26.73, 27.54) controlPoint1: CGPointMake(25.82, 29.47) controlPoint2: CGPointMake(26.73, 28.72)];
            [bezier6Path addLineToPoint: CGPointMake(26.73, 27.5)];
            [bezier6Path addCurveToPoint: CGPointMake(24.42, 25.65) controlPoint1: CGPointMake(26.73, 26.35) controlPoint2: CGPointMake(25.77, 25.65)];
            [bezier6Path addCurveToPoint: CGPointMake(22.5, 26.03) controlPoint1: CGPointMake(23.33, 25.65) controlPoint2: CGPointMake(22.8, 26.03)];
            [bezier6Path addCurveToPoint: CGPointMake(21.57, 25.65) controlPoint1: CGPointMake(22.2, 26.03) controlPoint2: CGPointMake(21.96, 25.92)];
            [bezier6Path addCurveToPoint: CGPointMake(21.19, 24.79) controlPoint1: CGPointMake(21.29, 25.44) controlPoint2: CGPointMake(21.18, 25.16)];
            [bezier6Path addLineToPoint: CGPointMake(21.43, 20.77)];
            [bezier6Path addCurveToPoint: CGPointMake(22.32, 19.89) controlPoint1: CGPointMake(21.46, 20.25) controlPoint2: CGPointMake(21.84, 19.89)];
            [bezier6Path addLineToPoint: CGPointMake(27.39, 19.89)];
            [bezier6Path addCurveToPoint: CGPointMake(28.26, 20.77) controlPoint1: CGPointMake(27.87, 19.89) controlPoint2: CGPointMake(28.26, 20.29)];
            [bezier6Path addCurveToPoint: CGPointMake(27.39, 21.63) controlPoint1: CGPointMake(28.26, 21.24) controlPoint2: CGPointMake(27.87, 21.63)];
            [bezier6Path addLineToPoint: CGPointMake(23.19, 21.63)];
            [bezier6Path addLineToPoint: CGPointMake(23.01, 24.25)];
            [bezier6Path addCurveToPoint: CGPointMake(24.78, 23.93) controlPoint1: CGPointMake(23.54, 24.06) controlPoint2: CGPointMake(24.03, 23.93)];
            [bezier6Path addCurveToPoint: CGPointMake(28.68, 27.44) controlPoint1: CGPointMake(26.97, 23.93) controlPoint2: CGPointMake(28.68, 25.08)];
            [bezier6Path addLineToPoint: CGPointMake(28.68, 27.47)];
            [bezier6Path addCurveToPoint: CGPointMake(24.59, 31.26) controlPoint1: CGPointMake(28.68, 29.74) controlPoint2: CGPointMake(26.99, 31.26)];
            [bezier6Path addCurveToPoint: CGPointMake(21.01, 30.04) controlPoint1: CGPointMake(23.07, 31.26) controlPoint2: CGPointMake(21.92, 30.75)];
            [bezier6Path closePath];
            [color25 setFill];
            [bezier6Path fill];
            
            
            //// Bezier 35 Drawing
            UIBezierPath* bezier35Path = [UIBezierPath bezierPath];
            [bezier35Path moveToPoint: CGPointMake(38.98, 33.59)];
            [bezier35Path addLineToPoint: CGPointMake(24.36, 42.03)];
            [bezier35Path addLineToPoint: CGPointMake(24.36, 42.03)];
            [bezier35Path addLineToPoint: CGPointMake(24.36, 47.22)];
            [bezier35Path addLineToPoint: CGPointMake(24.36, 47.22)];
            [bezier35Path addLineToPoint: CGPointMake(43.47, 36.18)];
            [bezier35Path addLineToPoint: CGPointMake(43.47, 36.09)];
            [bezier35Path addLineToPoint: CGPointMake(38.98, 33.51)];
            [bezier35Path addLineToPoint: CGPointMake(38.98, 33.59)];
            [bezier35Path closePath];
            [color8 setFill];
            [bezier35Path fill];
            
            
            //// Bezier 36 Drawing
            UIBezierPath* bezier36Path = [UIBezierPath bezierPath];
            [bezier36Path moveToPoint: CGPointMake(9.73, 33.59)];
            [bezier36Path addLineToPoint: CGPointMake(9.73, 33.55)];
            [bezier36Path addLineToPoint: CGPointMake(5.24, 36.14)];
            [bezier36Path addLineToPoint: CGPointMake(5.24, 36.18)];
            [bezier36Path addLineToPoint: CGPointMake(24.36, 47.22)];
            [bezier36Path addLineToPoint: CGPointMake(24.36, 42.03)];
            [bezier36Path addLineToPoint: CGPointMake(9.73, 33.59)];
            [bezier36Path closePath];
            [color25 setFill];
            [bezier36Path fill];
            
            
            //// Bezier 37 Drawing
            UIBezierPath* bezier37Path = [UIBezierPath bezierPath];
            [bezier37Path moveToPoint: CGPointMake(43.4, 14.06)];
            [bezier37Path addLineToPoint: CGPointMake(38.91, 16.66)];
            [bezier37Path addLineToPoint: CGPointMake(38.98, 16.7)];
            [bezier37Path addLineToPoint: CGPointMake(38.98, 33.51)];
            [bezier37Path addLineToPoint: CGPointMake(43.47, 36.09)];
            [bezier37Path addLineToPoint: CGPointMake(43.47, 14.11)];
            [bezier37Path addLineToPoint: CGPointMake(43.4, 14.06)];
            [bezier37Path closePath];
            [color17 setFill];
            [bezier37Path fill];
            
            
            //// Bezier 38 Drawing
            UIBezierPath* bezier38Path = [UIBezierPath bezierPath];
            [bezier38Path moveToPoint: CGPointMake(24.36, 8.26)];
            [bezier38Path addLineToPoint: CGPointMake(38.91, 16.66)];
            [bezier38Path addLineToPoint: CGPointMake(43.4, 14.06)];
            [bezier38Path addLineToPoint: CGPointMake(24.36, 3.07)];
            [bezier38Path addLineToPoint: CGPointMake(24.36, 3.07)];
            [bezier38Path addLineToPoint: CGPointMake(24.36, 8.26)];
            [bezier38Path closePath];
            [color25 setFill];
            [bezier38Path fill];
            
            
            //// Bezier 39 Drawing
            UIBezierPath* bezier39Path = [UIBezierPath bezierPath];
            [bezier39Path moveToPoint: CGPointMake(24.36, 8.26)];
            [bezier39Path addLineToPoint: CGPointMake(24.36, 3.07)];
            [bezier39Path addLineToPoint: CGPointMake(5.24, 14.11)];
            [bezier39Path addLineToPoint: CGPointMake(5.24, 14.11)];
            [bezier39Path addLineToPoint: CGPointMake(9.74, 16.7)];
            [bezier39Path addLineToPoint: CGPointMake(24.36, 8.26)];
            [bezier39Path closePath];
            [color25 setFill];
            [bezier39Path fill];
            
            
            //// Bezier 40 Drawing
            UIBezierPath* bezier40Path = [UIBezierPath bezierPath];
            [bezier40Path moveToPoint: CGPointMake(9.73, 16.7)];
            [bezier40Path addLineToPoint: CGPointMake(9.74, 16.7)];
            [bezier40Path addLineToPoint: CGPointMake(5.24, 14.11)];
            [bezier40Path addLineToPoint: CGPointMake(5.24, 36.14)];
            [bezier40Path addLineToPoint: CGPointMake(9.73, 33.55)];
            [bezier40Path addLineToPoint: CGPointMake(9.73, 16.7)];
            [bezier40Path closePath];
            [color25 setFill];
            [bezier40Path fill];
        }
            break;
        case 14:
            //// FilterSix
        {
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(21.27, 30)];
            [bezier7Path addCurveToPoint: CGPointMake(19.91, 25.73) controlPoint1: CGPointMake(20.42, 29.15) controlPoint2: CGPointMake(19.91, 27.98)];
            [bezier7Path addLineToPoint: CGPointMake(19.91, 25.7)];
            [bezier7Path addCurveToPoint: CGPointMake(24.7, 19.61) controlPoint1: CGPointMake(19.91, 22.28) controlPoint2: CGPointMake(21.54, 19.61)];
            [bezier7Path addCurveToPoint: CGPointMake(27.5, 20.41) controlPoint1: CGPointMake(25.85, 19.61) controlPoint2: CGPointMake(26.76, 19.92)];
            [bezier7Path addCurveToPoint: CGPointMake(27.99, 21.26) controlPoint1: CGPointMake(27.8, 20.61) controlPoint2: CGPointMake(27.99, 20.86)];
            [bezier7Path addCurveToPoint: CGPointMake(27.05, 22.17) controlPoint1: CGPointMake(27.99, 21.77) controlPoint2: CGPointMake(27.56, 22.17)];
            [bezier7Path addCurveToPoint: CGPointMake(26.56, 22.03) controlPoint1: CGPointMake(26.88, 22.17) controlPoint2: CGPointMake(26.7, 22.11)];
            [bezier7Path addCurveToPoint: CGPointMake(24.64, 21.4) controlPoint1: CGPointMake(25.95, 21.63) controlPoint2: CGPointMake(25.39, 21.4)];
            [bezier7Path addCurveToPoint: CGPointMake(21.96, 24.95) controlPoint1: CGPointMake(22.98, 21.4) controlPoint2: CGPointMake(22.05, 22.91)];
            [bezier7Path addCurveToPoint: CGPointMake(24.64, 23.83) controlPoint1: CGPointMake(22.55, 24.37) controlPoint2: CGPointMake(23.31, 23.83)];
            [bezier7Path addCurveToPoint: CGPointMake(28.54, 27.35) controlPoint1: CGPointMake(26.8, 23.83) controlPoint2: CGPointMake(28.54, 25.11)];
            [bezier7Path addLineToPoint: CGPointMake(28.54, 27.38)];
            [bezier7Path addCurveToPoint: CGPointMake(24.38, 31.18) controlPoint1: CGPointMake(28.54, 29.6) controlPoint2: CGPointMake(26.73, 31.18)];
            [bezier7Path addCurveToPoint: CGPointMake(21.27, 30) controlPoint1: CGPointMake(23.01, 31.18) controlPoint2: CGPointMake(22.02, 30.75)];
            [bezier7Path closePath];
            [bezier7Path moveToPoint: CGPointMake(26.57, 27.46)];
            [bezier7Path addLineToPoint: CGPointMake(26.57, 27.42)];
            [bezier7Path addCurveToPoint: CGPointMake(24.29, 25.48) controlPoint1: CGPointMake(26.57, 26.31) controlPoint2: CGPointMake(25.68, 25.48)];
            [bezier7Path addCurveToPoint: CGPointMake(22.02, 27.44) controlPoint1: CGPointMake(22.9, 25.48) controlPoint2: CGPointMake(22.02, 26.37)];
            [bezier7Path addLineToPoint: CGPointMake(22.02, 27.47)];
            [bezier7Path addCurveToPoint: CGPointMake(24.34, 29.47) controlPoint1: CGPointMake(22.02, 28.61) controlPoint2: CGPointMake(22.95, 29.47)];
            [bezier7Path addCurveToPoint: CGPointMake(26.57, 27.46) controlPoint1: CGPointMake(25.72, 29.47) controlPoint2: CGPointMake(26.57, 28.61)];
            [bezier7Path closePath];
            [color25 setFill];
            [bezier7Path fill];
            
            
            //// Bezier 41 Drawing
            UIBezierPath* bezier41Path = [UIBezierPath bezierPath];
            [bezier41Path moveToPoint: CGPointMake(38.8, 34.25)];
            [bezier41Path addLineToPoint: CGPointMake(24.18, 42.69)];
            [bezier41Path addLineToPoint: CGPointMake(24.18, 42.69)];
            [bezier41Path addLineToPoint: CGPointMake(24.18, 47.88)];
            [bezier41Path addLineToPoint: CGPointMake(24.18, 47.88)];
            [bezier41Path addLineToPoint: CGPointMake(43.3, 36.84)];
            [bezier41Path addLineToPoint: CGPointMake(43.3, 36.75)];
            [bezier41Path addLineToPoint: CGPointMake(38.8, 34.16)];
            [bezier41Path addLineToPoint: CGPointMake(38.8, 34.25)];
            [bezier41Path closePath];
            [color23 setFill];
            [bezier41Path fill];
            
            
            //// Bezier 42 Drawing
            UIBezierPath* bezier42Path = [UIBezierPath bezierPath];
            [bezier42Path moveToPoint: CGPointMake(9.55, 34.25)];
            [bezier42Path addLineToPoint: CGPointMake(9.55, 34.2)];
            [bezier42Path addLineToPoint: CGPointMake(5.06, 36.8)];
            [bezier42Path addLineToPoint: CGPointMake(5.06, 36.84)];
            [bezier42Path addLineToPoint: CGPointMake(24.18, 47.88)];
            [bezier42Path addLineToPoint: CGPointMake(24.18, 42.69)];
            [bezier42Path addLineToPoint: CGPointMake(9.55, 34.25)];
            [bezier42Path closePath];
            [color25 setFill];
            [bezier42Path fill];
            
            
            //// Bezier 43 Drawing
            UIBezierPath* bezier43Path = [UIBezierPath bezierPath];
            [bezier43Path moveToPoint: CGPointMake(43.22, 14.72)];
            [bezier43Path addLineToPoint: CGPointMake(38.73, 17.31)];
            [bezier43Path addLineToPoint: CGPointMake(38.8, 17.36)];
            [bezier43Path addLineToPoint: CGPointMake(38.8, 34.16)];
            [bezier43Path addLineToPoint: CGPointMake(43.3, 36.75)];
            [bezier43Path addLineToPoint: CGPointMake(43.3, 14.77)];
            [bezier43Path addLineToPoint: CGPointMake(43.22, 14.72)];
            [bezier43Path closePath];
            [color14 setFill];
            [bezier43Path fill];
            
            
            //// Bezier 44 Drawing
            UIBezierPath* bezier44Path = [UIBezierPath bezierPath];
            [bezier44Path moveToPoint: CGPointMake(24.18, 8.91)];
            [bezier44Path addLineToPoint: CGPointMake(38.73, 17.31)];
            [bezier44Path addLineToPoint: CGPointMake(43.22, 14.72)];
            [bezier44Path addLineToPoint: CGPointMake(24.18, 3.73)];
            [bezier44Path addLineToPoint: CGPointMake(24.18, 3.73)];
            [bezier44Path addLineToPoint: CGPointMake(24.18, 8.91)];
            [bezier44Path addLineToPoint: CGPointMake(24.18, 8.91)];
            [bezier44Path closePath];
            [color15 setFill];
            [bezier44Path fill];
            
            
            //// Bezier 45 Drawing
            UIBezierPath* bezier45Path = [UIBezierPath bezierPath];
            [bezier45Path moveToPoint: CGPointMake(24.18, 8.91)];
            [bezier45Path addLineToPoint: CGPointMake(24.18, 3.73)];
            [bezier45Path addLineToPoint: CGPointMake(5.06, 14.77)];
            [bezier45Path addLineToPoint: CGPointMake(5.06, 14.77)];
            [bezier45Path addLineToPoint: CGPointMake(9.56, 17.35)];
            [bezier45Path addLineToPoint: CGPointMake(24.18, 8.91)];
            [bezier45Path closePath];
            [color25 setFill];
            [bezier45Path fill];
            
            
            //// Bezier 46 Drawing
            UIBezierPath* bezier46Path = [UIBezierPath bezierPath];
            [bezier46Path moveToPoint: CGPointMake(9.55, 17.36)];
            [bezier46Path addLineToPoint: CGPointMake(9.56, 17.35)];
            [bezier46Path addLineToPoint: CGPointMake(5.06, 14.77)];
            [bezier46Path addLineToPoint: CGPointMake(5.06, 36.8)];
            [bezier46Path addLineToPoint: CGPointMake(9.55, 34.2)];
            [bezier46Path addLineToPoint: CGPointMake(9.55, 17.36)];
            [bezier46Path closePath];
            [color25 setFill];
            [bezier46Path fill];
        }
            break;
        case 15:
            //// FilterSeven
        {
            //// Bezier 9 Drawing
            UIBezierPath* bezier9Path = [UIBezierPath bezierPath];
            [bezier9Path moveToPoint: CGPointMake(22.35, 29.66)];
            [bezier9Path addLineToPoint: CGPointMake(26.69, 21.61)];
            [bezier9Path addLineToPoint: CGPointMake(21.86, 21.61)];
            [bezier9Path addCurveToPoint: CGPointMake(20.99, 20.75) controlPoint1: CGPointMake(21.38, 21.61) controlPoint2: CGPointMake(20.99, 21.23)];
            [bezier9Path addCurveToPoint: CGPointMake(21.86, 19.89) controlPoint1: CGPointMake(20.99, 20.27) controlPoint2: CGPointMake(21.38, 19.89)];
            [bezier9Path addLineToPoint: CGPointMake(28.13, 19.89)];
            [bezier9Path addCurveToPoint: CGPointMake(29.03, 20.77) controlPoint1: CGPointMake(28.67, 19.89) controlPoint2: CGPointMake(29.03, 20.21)];
            [bezier9Path addCurveToPoint: CGPointMake(28.75, 21.71) controlPoint1: CGPointMake(29.03, 21.05) controlPoint2: CGPointMake(28.91, 21.4)];
            [bezier9Path addLineToPoint: CGPointMake(24.12, 30.49)];
            [bezier9Path addCurveToPoint: CGPointMake(23.18, 31.15) controlPoint1: CGPointMake(23.88, 30.94) controlPoint2: CGPointMake(23.58, 31.15)];
            [bezier9Path addCurveToPoint: CGPointMake(22.18, 30.27) controlPoint1: CGPointMake(22.65, 31.15) controlPoint2: CGPointMake(22.18, 30.83)];
            [bezier9Path addCurveToPoint: CGPointMake(22.35, 29.66) controlPoint1: CGPointMake(22.18, 30.11) controlPoint2: CGPointMake(22.25, 29.84)];
            [bezier9Path closePath];
            [color25 setFill];
            [bezier9Path fill];
            
            
            //// Bezier 47 Drawing
            UIBezierPath* bezier47Path = [UIBezierPath bezierPath];
            [bezier47Path moveToPoint: CGPointMake(38.76, 33.52)];
            [bezier47Path addLineToPoint: CGPointMake(24.13, 41.96)];
            [bezier47Path addLineToPoint: CGPointMake(24.13, 41.96)];
            [bezier47Path addLineToPoint: CGPointMake(24.13, 47.15)];
            [bezier47Path addLineToPoint: CGPointMake(24.13, 47.15)];
            [bezier47Path addLineToPoint: CGPointMake(43.25, 36.11)];
            [bezier47Path addLineToPoint: CGPointMake(43.25, 36.02)];
            [bezier47Path addLineToPoint: CGPointMake(38.76, 33.44)];
            [bezier47Path addLineToPoint: CGPointMake(38.76, 33.52)];
            [bezier47Path closePath];
            [color16 setFill];
            [bezier47Path fill];
            
            
            //// Bezier 48 Drawing
            UIBezierPath* bezier48Path = [UIBezierPath bezierPath];
            [bezier48Path moveToPoint: CGPointMake(9.5, 33.52)];
            [bezier48Path addLineToPoint: CGPointMake(9.5, 33.48)];
            [bezier48Path addLineToPoint: CGPointMake(5.01, 36.08)];
            [bezier48Path addLineToPoint: CGPointMake(5.01, 36.11)];
            [bezier48Path addLineToPoint: CGPointMake(24.13, 47.15)];
            [bezier48Path addLineToPoint: CGPointMake(24.13, 41.96)];
            [bezier48Path addLineToPoint: CGPointMake(9.5, 33.52)];
            [bezier48Path closePath];
            [color25 setFill];
            [bezier48Path fill];
            
            
            //// Bezier 49 Drawing
            UIBezierPath* bezier49Path = [UIBezierPath bezierPath];
            [bezier49Path moveToPoint: CGPointMake(43.17, 13.99)];
            [bezier49Path addLineToPoint: CGPointMake(38.68, 16.59)];
            [bezier49Path addLineToPoint: CGPointMake(38.76, 16.63)];
            [bezier49Path addLineToPoint: CGPointMake(38.76, 33.44)];
            [bezier49Path addLineToPoint: CGPointMake(43.25, 36.02)];
            [bezier49Path addLineToPoint: CGPointMake(43.25, 14.04)];
            [bezier49Path addLineToPoint: CGPointMake(43.17, 13.99)];
            [bezier49Path closePath];
            [color20 setFill];
            [bezier49Path fill];
            
            
            //// Bezier 50 Drawing
            UIBezierPath* bezier50Path = [UIBezierPath bezierPath];
            [bezier50Path moveToPoint: CGPointMake(24.13, 8.19)];
            [bezier50Path addLineToPoint: CGPointMake(38.68, 16.59)];
            [bezier50Path addLineToPoint: CGPointMake(43.17, 13.99)];
            [bezier50Path addLineToPoint: CGPointMake(24.13, 3)];
            [bezier50Path addLineToPoint: CGPointMake(24.13, 3)];
            [bezier50Path addLineToPoint: CGPointMake(24.13, 8.19)];
            [bezier50Path addLineToPoint: CGPointMake(24.13, 8.19)];
            [bezier50Path closePath];
            [color18 setFill];
            [bezier50Path fill];
            
            
            //// Bezier 51 Drawing
            UIBezierPath* bezier51Path = [UIBezierPath bezierPath];
            [bezier51Path moveToPoint: CGPointMake(24.13, 8.19)];
            [bezier51Path addLineToPoint: CGPointMake(24.13, 3)];
            [bezier51Path addLineToPoint: CGPointMake(5.01, 14.04)];
            [bezier51Path addLineToPoint: CGPointMake(5.01, 14.04)];
            [bezier51Path addLineToPoint: CGPointMake(9.51, 16.63)];
            [bezier51Path addLineToPoint: CGPointMake(24.13, 8.19)];
            [bezier51Path closePath];
            [color25 setFill];
            [bezier51Path fill];
            
            
            //// Bezier 52 Drawing
            UIBezierPath* bezier52Path = [UIBezierPath bezierPath];
            [bezier52Path moveToPoint: CGPointMake(9.5, 16.63)];
            [bezier52Path addLineToPoint: CGPointMake(9.51, 16.63)];
            [bezier52Path addLineToPoint: CGPointMake(5.01, 14.04)];
            [bezier52Path addLineToPoint: CGPointMake(5.01, 36.08)];
            [bezier52Path addLineToPoint: CGPointMake(9.5, 33.48)];
            [bezier52Path addLineToPoint: CGPointMake(9.5, 16.63)];
            [bezier52Path closePath];
            [color25 setFill];
            [bezier52Path fill];
        }
            break;
        case 16:
            //// FilterEight
        {
            //// Bezier 8 Drawing
            UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
            [bezier8Path moveToPoint: CGPointMake(20.4, 27.94)];
            [bezier8Path addLineToPoint: CGPointMake(20.4, 27.91)];
            [bezier8Path addCurveToPoint: CGPointMake(22.41, 25.19) controlPoint1: CGPointMake(20.4, 26.56) controlPoint2: CGPointMake(21.15, 25.72)];
            [bezier8Path addCurveToPoint: CGPointMake(20.78, 22.7) controlPoint1: CGPointMake(21.47, 24.7) controlPoint2: CGPointMake(20.78, 23.94)];
            [bezier8Path addLineToPoint: CGPointMake(20.78, 22.67)];
            [bezier8Path addCurveToPoint: CGPointMake(24.66, 19.65) controlPoint1: CGPointMake(20.78, 20.96) controlPoint2: CGPointMake(22.43, 19.65)];
            [bezier8Path addCurveToPoint: CGPointMake(28.54, 22.67) controlPoint1: CGPointMake(26.9, 19.65) controlPoint2: CGPointMake(28.54, 20.94)];
            [bezier8Path addLineToPoint: CGPointMake(28.54, 22.7)];
            [bezier8Path addCurveToPoint: CGPointMake(26.92, 25.19) controlPoint1: CGPointMake(28.54, 23.94) controlPoint2: CGPointMake(27.86, 24.7)];
            [bezier8Path addCurveToPoint: CGPointMake(28.93, 27.87) controlPoint1: CGPointMake(28.14, 25.75) controlPoint2: CGPointMake(28.93, 26.55)];
            [bezier8Path addLineToPoint: CGPointMake(28.93, 27.91)];
            [bezier8Path addCurveToPoint: CGPointMake(24.66, 31.15) controlPoint1: CGPointMake(28.93, 29.9) controlPoint2: CGPointMake(27.11, 31.15)];
            [bezier8Path addCurveToPoint: CGPointMake(20.4, 27.94) controlPoint1: CGPointMake(22.22, 31.15) controlPoint2: CGPointMake(20.4, 29.87)];
            [bezier8Path closePath];
            [bezier8Path moveToPoint: CGPointMake(27.01, 27.82)];
            [bezier8Path addLineToPoint: CGPointMake(27.01, 27.79)];
            [bezier8Path addCurveToPoint: CGPointMake(24.66, 26.1) controlPoint1: CGPointMake(27.01, 26.77) controlPoint2: CGPointMake(25.99, 26.1)];
            [bezier8Path addCurveToPoint: CGPointMake(22.33, 27.79) controlPoint1: CGPointMake(23.34, 26.1) controlPoint2: CGPointMake(22.33, 26.77)];
            [bezier8Path addLineToPoint: CGPointMake(22.33, 27.82)];
            [bezier8Path addCurveToPoint: CGPointMake(24.66, 29.5) controlPoint1: CGPointMake(22.33, 28.73) controlPoint2: CGPointMake(23.19, 29.5)];
            [bezier8Path addCurveToPoint: CGPointMake(27.01, 27.82) controlPoint1: CGPointMake(26.13, 29.5) controlPoint2: CGPointMake(27.01, 28.75)];
            [bezier8Path closePath];
            [bezier8Path moveToPoint: CGPointMake(26.66, 22.89)];
            [bezier8Path addLineToPoint: CGPointMake(26.66, 22.86)];
            [bezier8Path addCurveToPoint: CGPointMake(24.66, 21.29) controlPoint1: CGPointMake(26.66, 22) controlPoint2: CGPointMake(25.86, 21.29)];
            [bezier8Path addCurveToPoint: CGPointMake(22.67, 22.84) controlPoint1: CGPointMake(23.47, 21.29) controlPoint2: CGPointMake(22.67, 22)];
            [bezier8Path addLineToPoint: CGPointMake(22.67, 22.88)];
            [bezier8Path addCurveToPoint: CGPointMake(24.66, 24.54) controlPoint1: CGPointMake(22.67, 23.85) controlPoint2: CGPointMake(23.51, 24.54)];
            [bezier8Path addCurveToPoint: CGPointMake(26.66, 22.89) controlPoint1: CGPointMake(25.81, 24.54) controlPoint2: CGPointMake(26.66, 23.85)];
            [bezier8Path closePath];
            [color25 setFill];
            [bezier8Path fill];
            
            
            //// Bezier 53 Drawing
            UIBezierPath* bezier53Path = [UIBezierPath bezierPath];
            [bezier53Path moveToPoint: CGPointMake(39.51, 34.07)];
            [bezier53Path addLineToPoint: CGPointMake(24.88, 42.52)];
            [bezier53Path addLineToPoint: CGPointMake(24.88, 42.52)];
            [bezier53Path addLineToPoint: CGPointMake(24.88, 47.7)];
            [bezier53Path addLineToPoint: CGPointMake(24.88, 47.7)];
            [bezier53Path addLineToPoint: CGPointMake(44, 36.67)];
            [bezier53Path addLineToPoint: CGPointMake(44, 36.57)];
            [bezier53Path addLineToPoint: CGPointMake(39.51, 33.99)];
            [bezier53Path addLineToPoint: CGPointMake(39.51, 34.07)];
            [bezier53Path closePath];
            [color19 setFill];
            [bezier53Path fill];
            
            
            //// Bezier 54 Drawing
            UIBezierPath* bezier54Path = [UIBezierPath bezierPath];
            [bezier54Path moveToPoint: CGPointMake(10.25, 34.07)];
            [bezier54Path addLineToPoint: CGPointMake(10.25, 34.03)];
            [bezier54Path addLineToPoint: CGPointMake(5.76, 36.63)];
            [bezier54Path addLineToPoint: CGPointMake(5.76, 36.67)];
            [bezier54Path addLineToPoint: CGPointMake(24.88, 47.7)];
            [bezier54Path addLineToPoint: CGPointMake(24.88, 42.52)];
            [bezier54Path addLineToPoint: CGPointMake(10.25, 34.07)];
            [bezier54Path closePath];
            [color25 setFill];
            [bezier54Path fill];
            
            
            //// Bezier 55 Drawing
            UIBezierPath* bezier55Path = [UIBezierPath bezierPath];
            [bezier55Path moveToPoint: CGPointMake(43.92, 14.55)];
            [bezier55Path addLineToPoint: CGPointMake(39.43, 17.14)];
            [bezier55Path addLineToPoint: CGPointMake(39.51, 17.19)];
            [bezier55Path addLineToPoint: CGPointMake(39.51, 33.99)];
            [bezier55Path addLineToPoint: CGPointMake(44, 36.57)];
            [bezier55Path addLineToPoint: CGPointMake(44, 14.59)];
            [bezier55Path addLineToPoint: CGPointMake(43.92, 14.55)];
            [bezier55Path closePath];
            [color27 setFill];
            [bezier55Path fill];
            
            
            //// Bezier 56 Drawing
            UIBezierPath* bezier56Path = [UIBezierPath bezierPath];
            [bezier56Path moveToPoint: CGPointMake(24.88, 8.74)];
            [bezier56Path addLineToPoint: CGPointMake(39.43, 17.14)];
            [bezier56Path addLineToPoint: CGPointMake(43.92, 14.55)];
            [bezier56Path addLineToPoint: CGPointMake(24.88, 3.55)];
            [bezier56Path addLineToPoint: CGPointMake(24.88, 3.55)];
            [bezier56Path addLineToPoint: CGPointMake(24.88, 8.74)];
            [bezier56Path addLineToPoint: CGPointMake(24.88, 8.74)];
            [bezier56Path closePath];
            [color21 setFill];
            [bezier56Path fill];
            
            
            //// Bezier 57 Drawing
            UIBezierPath* bezier57Path = [UIBezierPath bezierPath];
            [bezier57Path moveToPoint: CGPointMake(24.88, 8.74)];
            [bezier57Path addLineToPoint: CGPointMake(24.88, 3.55)];
            [bezier57Path addLineToPoint: CGPointMake(5.76, 14.59)];
            [bezier57Path addLineToPoint: CGPointMake(5.76, 14.6)];
            [bezier57Path addLineToPoint: CGPointMake(10.26, 17.18)];
            [bezier57Path addLineToPoint: CGPointMake(24.88, 8.74)];
            [bezier57Path closePath];
            [color25 setFill];
            [bezier57Path fill];
            
            
            //// Bezier 58 Drawing
            UIBezierPath* bezier58Path = [UIBezierPath bezierPath];
            [bezier58Path moveToPoint: CGPointMake(10.25, 17.19)];
            [bezier58Path addLineToPoint: CGPointMake(10.26, 17.18)];
            [bezier58Path addLineToPoint: CGPointMake(5.76, 14.6)];
            [bezier58Path addLineToPoint: CGPointMake(5.76, 36.63)];
            [bezier58Path addLineToPoint: CGPointMake(10.25, 34.03)];
            [bezier58Path addLineToPoint: CGPointMake(10.25, 17.19)];
            [bezier58Path closePath];
            [color25 setFill];
            [bezier58Path fill];
        }
            break;
        case 17:
            //// TopArrow
        {
            UIBezierPath* topArrowPath = [UIBezierPath bezierPath];
            [topArrowPath moveToPoint: CGPointMake(65.61, 34.83)];
            [topArrowPath addLineToPoint: CGPointMake(81, 8.17)];
            [topArrowPath addLineToPoint: CGPointMake(96.39, 34.83)];
            [topArrowPath addLineToPoint: CGPointMake(65.61, 34.83)];
            [topArrowPath closePath];
            [[UIColor blackColor] setFill];
            [topArrowPath fill];
            [color setStroke];
            topArrowPath.lineWidth = 4;
            [topArrowPath stroke];
        }
            break;
        case 18:
            //// BottomArrow
        {
            //// BottomArrow Drawing
            UIBezierPath* bottomArrowPath = [UIBezierPath bezierPath];
            [bottomArrowPath moveToPoint: CGPointMake(96.39, 9.17)];
            [bottomArrowPath addLineToPoint: CGPointMake(81, 35.83)];
            [bottomArrowPath addLineToPoint: CGPointMake(65.61, 9.17)];
            [bottomArrowPath addLineToPoint: CGPointMake(96.39, 9.17)];
            [bottomArrowPath closePath];
            [[UIColor blackColor] setFill];
            [bottomArrowPath fill];
            [color setStroke];
            bottomArrowPath.lineWidth = 4;
            [bottomArrowPath stroke];
        }
            break;
        case 19:
            //// TopArrow
        {
            UIBezierPath* topArrowPath = [UIBezierPath bezierPath];
            [topArrowPath moveToPoint: CGPointMake(65.61, 34.83)];
            [topArrowPath addLineToPoint: CGPointMake(81, 8.17)];
            [topArrowPath addLineToPoint: CGPointMake(96.39, 34.83)];
            [topArrowPath addLineToPoint: CGPointMake(65.61, 34.83)];
            [topArrowPath closePath];
            [[UIColor blackColor] setFill];
            [topArrowPath fill];
            [color setStroke];
            topArrowPath.lineWidth = 4;
            [topArrowPath stroke];
        }
            break;
        case 20:
            //// BottomArrow
        {
            //// BottomArrow Drawing
            UIBezierPath* bottomArrowPath = [UIBezierPath bezierPath];
            [bottomArrowPath moveToPoint: CGPointMake(96.39, 9.17)];
            [bottomArrowPath addLineToPoint: CGPointMake(81, 35.83)];
            [bottomArrowPath addLineToPoint: CGPointMake(65.61, 9.17)];
            [bottomArrowPath addLineToPoint: CGPointMake(96.39, 9.17)];
            [bottomArrowPath closePath];
            [[UIColor blackColor] setFill];
            [bottomArrowPath fill];
            [color setStroke];
            bottomArrowPath.lineWidth = 4;
            [bottomArrowPath stroke];
        }
            break;
        case 21:
            //// LeftBar
        {
            //// Bezier 59 Drawing
            UIBezierPath* bezier59Path = [UIBezierPath bezierPath];
            [bezier59Path moveToPoint: CGPointMake(41.78, 49.92)];
            [bezier59Path addLineToPoint: CGPointMake(37.82, 49.92)];
            [color61 setStroke];
            bezier59Path.lineWidth = 11;
            [bezier59Path stroke];
            
            
            //// Bezier 60 Drawing
            UIBezierPath* bezier60Path = [UIBezierPath bezierPath];
            [bezier60Path moveToPoint: CGPointMake(125.21, 49.92)];
            [bezier60Path addLineToPoint: CGPointMake(117.84, 49.92)];
            [color62 setStroke];
            bezier60Path.lineWidth = 11;
            [bezier60Path stroke];
            
            
            //// Bezier 61 Drawing
            UIBezierPath* bezier61Path = [UIBezierPath bezierPath];
            [bezier61Path moveToPoint: CGPointMake(125.21, 49.92)];
            [bezier61Path addLineToPoint: CGPointMake(114.29, 49.92)];
            [color62 setStroke];
            bezier61Path.lineWidth = 11;
            [bezier61Path stroke];
            
            
            //// Bezier 62 Drawing
            UIBezierPath* bezier62Path = [UIBezierPath bezierPath];
            [bezier62Path moveToPoint: CGPointMake(114.29, 49.92)];
            [bezier62Path addLineToPoint: CGPointMake(103.36, 49.92)];
            [color60 setStroke];
            bezier62Path.lineWidth = 11;
            [bezier62Path stroke];
            
            
            //// Bezier 63 Drawing
            UIBezierPath* bezier63Path = [UIBezierPath bezierPath];
            [bezier63Path moveToPoint: CGPointMake(103.36, 49.92)];
            [bezier63Path addLineToPoint: CGPointMake(92.44, 49.92)];
            [color64 setStroke];
            bezier63Path.lineWidth = 11;
            [bezier63Path stroke];
            
            
            //// Bezier 64 Drawing
            UIBezierPath* bezier64Path = [UIBezierPath bezierPath];
            [bezier64Path moveToPoint: CGPointMake(92.44, 49.92)];
            [bezier64Path addLineToPoint: CGPointMake(81.51, 49.92)];
            [color65 setStroke];
            bezier64Path.lineWidth = 11;
            [bezier64Path stroke];
            
            
            //// Bezier 65 Drawing
            UIBezierPath* bezier65Path = [UIBezierPath bezierPath];
            [bezier65Path moveToPoint: CGPointMake(81.51, 49.92)];
            [bezier65Path addLineToPoint: CGPointMake(70.59, 49.92)];
            [color66 setStroke];
            bezier65Path.lineWidth = 11;
            [bezier65Path stroke];
            
            
            //// Bezier 66 Drawing
            UIBezierPath* bezier66Path = [UIBezierPath bezierPath];
            [bezier66Path moveToPoint: CGPointMake(70.59, 49.92)];
            [bezier66Path addLineToPoint: CGPointMake(59.67, 49.92)];
            [color67 setStroke];
            bezier66Path.lineWidth = 11;
            [bezier66Path stroke];
            
            
            //// Bezier 67 Drawing
            UIBezierPath* bezier67Path = [UIBezierPath bezierPath];
            [bezier67Path moveToPoint: CGPointMake(59.67, 49.92)];
            [bezier67Path addLineToPoint: CGPointMake(48.74, 49.92)];
            [color68 setStroke];
            bezier67Path.lineWidth = 11;
            [bezier67Path stroke];
            
            
            //// Bezier 68 Drawing
            UIBezierPath* bezier68Path = [UIBezierPath bezierPath];
            [bezier68Path moveToPoint: CGPointMake(48.74, 49.92)];
            [bezier68Path addLineToPoint: CGPointMake(37.82, 49.92)];
            [color61 setStroke];
            bezier68Path.lineWidth = 11;
            [bezier68Path stroke];
        }            
            break;
        case 22:
            //// RightBar
        {
            //// Bezier 69 Drawing
            UIBezierPath* bezier69Path = [UIBezierPath bezierPath];
            [bezier69Path moveToPoint: CGPointMake(121.22, 49.92)];
            [bezier69Path addLineToPoint: CGPointMake(125.18, 49.92)];
            [color70 setStroke];
            bezier69Path.lineWidth = 10;
            [bezier69Path stroke];
            
            
            //// Bezier 70 Drawing
            UIBezierPath* bezier70Path = [UIBezierPath bezierPath];
            [bezier70Path moveToPoint: CGPointMake(37.79, 49.92)];
            [bezier70Path addLineToPoint: CGPointMake(45.16, 49.92)];
            [color69 setStroke];
            bezier70Path.lineWidth = 10;
            [bezier70Path stroke];
            
            
            //// Bezier 71 Drawing
            UIBezierPath* bezier71Path = [UIBezierPath bezierPath];
            [bezier71Path moveToPoint: CGPointMake(37.79, 49.92)];
            [bezier71Path addLineToPoint: CGPointMake(48.72, 49.92)];
            [color69 setStroke];
            bezier71Path.lineWidth = 10;
            [bezier71Path stroke];
            
            
            //// Bezier 72 Drawing
            UIBezierPath* bezier72Path = [UIBezierPath bezierPath];
            [bezier72Path moveToPoint: CGPointMake(48.72, 49.92)];
            [bezier72Path addLineToPoint: CGPointMake(59.64, 49.92)];
            [color72 setStroke];
            bezier72Path.lineWidth = 10;
            [bezier72Path stroke];
            
            
            //// Bezier 73 Drawing
            UIBezierPath* bezier73Path = [UIBezierPath bezierPath];
            [bezier73Path moveToPoint: CGPointMake(59.64, 49.92)];
            [bezier73Path addLineToPoint: CGPointMake(70.56, 49.92)];
            [color69 setStroke];
            bezier73Path.lineWidth = 10;
            [bezier73Path stroke];
            
            
            //// Bezier 74 Drawing
            UIBezierPath* bezier74Path = [UIBezierPath bezierPath];
            [bezier74Path moveToPoint: CGPointMake(70.56, 49.92)];
            [bezier74Path addLineToPoint: CGPointMake(81.48, 49.92)];
            [color73 setStroke];
            bezier74Path.lineWidth = 10;
            [bezier74Path stroke];
            
            
            //// Bezier 75 Drawing
            UIBezierPath* bezier75Path = [UIBezierPath bezierPath];
            [bezier75Path moveToPoint: CGPointMake(81.48, 49.92)];
            [bezier75Path addLineToPoint: CGPointMake(92.41, 49.92)];
            [color69 setStroke];
            bezier75Path.lineWidth = 10;
            [bezier75Path stroke];
            
            
            //// Bezier 76 Drawing
            UIBezierPath* bezier76Path = [UIBezierPath bezierPath];
            [bezier76Path moveToPoint: CGPointMake(92.41, 49.92)];
            [bezier76Path addLineToPoint: CGPointMake(103.33, 49.92)];
            [color74 setStroke];
            bezier76Path.lineWidth = 10;
            [bezier76Path stroke];
            
            
            //// Bezier 77 Drawing
            UIBezierPath* bezier77Path = [UIBezierPath bezierPath];
            [bezier77Path moveToPoint: CGPointMake(103.33, 49.92)];
            [bezier77Path addLineToPoint: CGPointMake(114.26, 49.92)];
            [color69 setStroke];
            bezier77Path.lineWidth = 10;
            [bezier77Path stroke];
            
            
            //// Bezier 78 Drawing
            UIBezierPath* bezier78Path = [UIBezierPath bezierPath];
            [bezier78Path moveToPoint: CGPointMake(114.26, 49.92)];
            [bezier78Path addLineToPoint: CGPointMake(125.18, 49.92)];
            [color70 setStroke];
            bezier78Path.lineWidth = 10;
            [bezier78Path stroke];
        }
            break;
        case 23:
            //// WhiteSquare
        {
            //// Bezier 79 Drawing
            UIBezierPath* bezier79Path = [UIBezierPath bezierPath];
            [bezier79Path moveToPoint: CGPointMake(33.22, 57.39)];
            [bezier79Path addLineToPoint: CGPointMake(29.49, 46.82)];
            [bezier79Path addCurveToPoint: CGPointMake(29.33, 46.01) controlPoint1: CGPointMake(29.41, 46.61) controlPoint2: CGPointMake(29.33, 46.27)];
            [bezier79Path addCurveToPoint: CGPointMake(30.88, 44.54) controlPoint1: CGPointMake(29.33, 45.25) controlPoint2: CGPointMake(29.94, 44.54)];
            [bezier79Path addCurveToPoint: CGPointMake(32.43, 45.8) controlPoint1: CGPointMake(31.67, 44.54) controlPoint2: CGPointMake(32.2, 45.06)];
            [bezier79Path addLineToPoint: CGPointMake(35.12, 54.21)];
            [bezier79Path addLineToPoint: CGPointMake(37.82, 45.8)];
            [bezier79Path addCurveToPoint: CGPointMake(39.45, 44.54) controlPoint1: CGPointMake(38.06, 45.06) controlPoint2: CGPointMake(38.64, 44.54)];
            [bezier79Path addLineToPoint: CGPointMake(39.64, 44.54)];
            [bezier79Path addCurveToPoint: CGPointMake(41.27, 45.8) controlPoint1: CGPointMake(40.45, 44.54) controlPoint2: CGPointMake(41.03, 45.06)];
            [bezier79Path addLineToPoint: CGPointMake(44, 54.21)];
            [bezier79Path addLineToPoint: CGPointMake(46.71, 45.77)];
            [bezier79Path addCurveToPoint: CGPointMake(48.26, 44.54) controlPoint1: CGPointMake(46.92, 45.09) controlPoint2: CGPointMake(47.42, 44.54)];
            [bezier79Path addCurveToPoint: CGPointMake(49.76, 46.01) controlPoint1: CGPointMake(49.12, 44.54) controlPoint2: CGPointMake(49.76, 45.22)];
            [bezier79Path addCurveToPoint: CGPointMake(49.62, 46.72) controlPoint1: CGPointMake(49.76, 46.25) controlPoint2: CGPointMake(49.68, 46.56)];
            [bezier79Path addLineToPoint: CGPointMake(45.84, 57.39)];
            [bezier79Path addCurveToPoint: CGPointMake(44.08, 58.81) controlPoint1: CGPointMake(45.5, 58.36) controlPoint2: CGPointMake(44.84, 58.81)];
            [bezier79Path addLineToPoint: CGPointMake(43.97, 58.81)];
            [bezier79Path addCurveToPoint: CGPointMake(42.24, 57.44) controlPoint1: CGPointMake(43.18, 58.81) controlPoint2: CGPointMake(42.53, 58.36)];
            [bezier79Path addLineToPoint: CGPointMake(39.53, 49.19)];
            [bezier79Path addLineToPoint: CGPointMake(36.8, 57.44)];
            [bezier79Path addCurveToPoint: CGPointMake(35.09, 58.81) controlPoint1: CGPointMake(36.51, 58.36) controlPoint2: CGPointMake(35.85, 58.81)];
            [bezier79Path addLineToPoint: CGPointMake(34.98, 58.81)];
            [bezier79Path addCurveToPoint: CGPointMake(33.22, 57.39) controlPoint1: CGPointMake(34.19, 58.81) controlPoint2: CGPointMake(33.54, 58.36)];
            [bezier79Path closePath];
            [color100 setFill];
            [bezier79Path fill];
            
            
            //// Bezier 81 Drawing
            UIBezierPath* bezier81Path = [UIBezierPath bezierPath];
            [bezier81Path moveToPoint: CGPointMake(61.81, 27.29)];
            [bezier81Path addLineToPoint: CGPointMake(61.89, 27.29)];
            [bezier81Path addLineToPoint: CGPointMake(61.89, 72.09)];
            [bezier81Path addLineToPoint: CGPointMake(17.22, 72.09)];
            [bezier81Path addLineToPoint: CGPointMake(12.3, 77.03)];
            [bezier81Path addLineToPoint: CGPointMake(66.83, 77.03)];
            [bezier81Path addLineToPoint: CGPointMake(66.83, 22.34)];
            [bezier81Path addLineToPoint: CGPointMake(66.72, 22.34)];
            [bezier81Path addLineToPoint: CGPointMake(61.81, 27.29)];
            [bezier81Path closePath];
            [color100 setFill];
            [bezier81Path fill];
            
            
            //// Bezier 82 Drawing
            UIBezierPath* bezier82Path = [UIBezierPath bezierPath];
            [bezier82Path moveToPoint: CGPointMake(17.09, 72.09)];
            [bezier82Path addLineToPoint: CGPointMake(17.09, 27.29)];
            [bezier82Path addLineToPoint: CGPointMake(61.81, 27.29)];
            [bezier82Path addLineToPoint: CGPointMake(66.72, 22.34)];
            [bezier82Path addLineToPoint: CGPointMake(12.15, 22.34)];
            [bezier82Path addLineToPoint: CGPointMake(12.15, 77.03)];
            [bezier82Path addLineToPoint: CGPointMake(12.3, 77.03)];
            [bezier82Path addLineToPoint: CGPointMake(17.22, 72.09)];
            [bezier82Path addLineToPoint: CGPointMake(17.09, 72.09)];
            [bezier82Path closePath];
            [color100 setFill];
            [bezier82Path fill];
        }
            break;
        case 24:
            //// BlackSquare
        {
            //// Bezier 80 Drawing
            UIBezierPath* bezier80Path = [UIBezierPath bezierPath];
            [bezier80Path moveToPoint: CGPointMake(32.83, 42.12)];
            [bezier80Path addCurveToPoint: CGPointMake(34.46, 40.49) controlPoint1: CGPointMake(32.83, 41.19) controlPoint2: CGPointMake(33.54, 40.49)];
            [bezier80Path addLineToPoint: CGPointMake(41.08, 40.49)];
            [bezier80Path addCurveToPoint: CGPointMake(45.89, 42.12) controlPoint1: CGPointMake(43.18, 40.49) controlPoint2: CGPointMake(44.84, 41.06)];
            [bezier80Path addCurveToPoint: CGPointMake(47.13, 45.16) controlPoint1: CGPointMake(46.71, 42.93) controlPoint2: CGPointMake(47.13, 43.93)];
            [bezier80Path addLineToPoint: CGPointMake(47.13, 45.22)];
            [bezier80Path addCurveToPoint: CGPointMake(44.5, 49.32) controlPoint1: CGPointMake(47.13, 47.42) controlPoint2: CGPointMake(45.87, 48.61)];
            [bezier80Path addCurveToPoint: CGPointMake(48.15, 53.79) controlPoint1: CGPointMake(46.65, 50.05) controlPoint2: CGPointMake(48.15, 51.29)];
            [bezier80Path addLineToPoint: CGPointMake(48.15, 53.84)];
            [bezier80Path addCurveToPoint: CGPointMake(41.34, 58.89) controlPoint1: CGPointMake(48.15, 57.13) controlPoint2: CGPointMake(45.44, 58.89)];
            [bezier80Path addLineToPoint: CGPointMake(34.46, 58.89)];
            [bezier80Path addCurveToPoint: CGPointMake(32.83, 57.26) controlPoint1: CGPointMake(33.54, 58.89) controlPoint2: CGPointMake(32.83, 58.18)];
            [bezier80Path addLineToPoint: CGPointMake(32.83, 42.12)];
            [bezier80Path closePath];
            [bezier80Path moveToPoint: CGPointMake(40.42, 48.24)];
            [bezier80Path addCurveToPoint: CGPointMake(43.9, 45.74) controlPoint1: CGPointMake(42.5, 48.24) controlPoint2: CGPointMake(43.9, 47.43)];
            [bezier80Path addLineToPoint: CGPointMake(43.9, 45.69)];
            [bezier80Path addCurveToPoint: CGPointMake(40.66, 43.35) controlPoint1: CGPointMake(43.9, 44.24) controlPoint2: CGPointMake(42.74, 43.35)];
            [bezier80Path addLineToPoint: CGPointMake(36.01, 43.35)];
            [bezier80Path addLineToPoint: CGPointMake(36.01, 48.24)];
            [bezier80Path addLineToPoint: CGPointMake(40.42, 48.24)];
            [bezier80Path addLineToPoint: CGPointMake(40.42, 48.24)];
            [bezier80Path closePath];
            [bezier80Path moveToPoint: CGPointMake(41.37, 56.02)];
            [bezier80Path addCurveToPoint: CGPointMake(44.92, 53.5) controlPoint1: CGPointMake(43.58, 56.02) controlPoint2: CGPointMake(44.92, 55.15)];
            [bezier80Path addLineToPoint: CGPointMake(44.92, 53.44)];
            [bezier80Path addCurveToPoint: CGPointMake(41.13, 50.97) controlPoint1: CGPointMake(44.92, 51.89) controlPoint2: CGPointMake(43.68, 50.97)];
            [bezier80Path addLineToPoint: CGPointMake(36.01, 50.97)];
            [bezier80Path addLineToPoint: CGPointMake(36.01, 56.02)];
            [bezier80Path addLineToPoint: CGPointMake(41.37, 56.02)];
            [bezier80Path closePath];
            [color100 setFill];
            [bezier80Path fill];
            
            
            //// Bezier 83 Drawing
            UIBezierPath* bezier83Path = [UIBezierPath bezierPath];
            [bezier83Path moveToPoint: CGPointMake(62.31, 27.6)];
            [bezier83Path addLineToPoint: CGPointMake(62.4, 27.6)];
            [bezier83Path addLineToPoint: CGPointMake(62.4, 72.4)];
            [bezier83Path addLineToPoint: CGPointMake(17.73, 72.4)];
            [bezier83Path addLineToPoint: CGPointMake(12.81, 77.34)];
            [bezier83Path addLineToPoint: CGPointMake(67.34, 77.34)];
            [bezier83Path addLineToPoint: CGPointMake(67.34, 22.66)];
            [bezier83Path addLineToPoint: CGPointMake(67.23, 22.66)];
            [bezier83Path addLineToPoint: CGPointMake(62.31, 27.6)];
            [bezier83Path closePath];
            [color103 setFill];
            [bezier83Path fill];
            
            
            //// Bezier 84 Drawing
            UIBezierPath* bezier84Path = [UIBezierPath bezierPath];
            [bezier84Path moveToPoint: CGPointMake(17.6, 72.4)];
            [bezier84Path addLineToPoint: CGPointMake(17.6, 27.6)];
            [bezier84Path addLineToPoint: CGPointMake(62.31, 27.6)];
            [bezier84Path addLineToPoint: CGPointMake(67.23, 22.66)];
            [bezier84Path addLineToPoint: CGPointMake(12.66, 22.66)];
            [bezier84Path addLineToPoint: CGPointMake(12.66, 77.34)];
            [bezier84Path addLineToPoint: CGPointMake(12.81, 77.34)];
            [bezier84Path addLineToPoint: CGPointMake(17.73, 72.4)];
            [bezier84Path addLineToPoint: CGPointMake(17.6, 72.4)];
            [bezier84Path closePath];
            [color100 setFill];
            [bezier84Path fill];
        }
            break;
        case 25:
            //// ColorSquare
        {
            //// C Drawing
            CGRect cRect = CGRectMake(28, 35, 25, 30);
            [color100 setFill];
            [@"C" drawInRect: cRect withFont: [UIFont fontWithName: @"Helvetica" size: 25.29]];
            
            
            //// Bezier 85 Drawing
            UIBezierPath* bezier85Path = [UIBezierPath bezierPath];
            [bezier85Path moveToPoint: CGPointMake(67.34, 77.34)];
            [bezier85Path addLineToPoint: CGPointMake(67.34, 22.66)];
            [bezier85Path addLineToPoint: CGPointMake(67.23, 22.66)];
            [bezier85Path addLineToPoint: CGPointMake(62.31, 27.6)];
            [bezier85Path addLineToPoint: CGPointMake(62.4, 27.6)];
            [bezier85Path addLineToPoint: CGPointMake(62.4, 72.34)];
            [bezier85Path addLineToPoint: CGPointMake(67.3, 77.34)];
            [bezier85Path addLineToPoint: CGPointMake(67.34, 77.34)];
            [bezier85Path closePath];
            [color105 setFill];
            [bezier85Path fill];
            
            
            //// Bezier 86 Drawing
            UIBezierPath* bezier86Path = [UIBezierPath bezierPath];
            [bezier86Path moveToPoint: CGPointMake(62.4, 72.34)];
            [bezier86Path addLineToPoint: CGPointMake(62.4, 72.4)];
            [bezier86Path addLineToPoint: CGPointMake(17.73, 72.4)];
            [bezier86Path addLineToPoint: CGPointMake(12.81, 77.34)];
            [bezier86Path addLineToPoint: CGPointMake(67.3, 77.34)];
            [bezier86Path addLineToPoint: CGPointMake(62.4, 72.34)];
            [bezier86Path closePath];
            [color101 setFill];
            [bezier86Path fill];
            
            
            //// Bezier 87 Drawing
            UIBezierPath* bezier87Path = [UIBezierPath bezierPath];
            [bezier87Path moveToPoint: CGPointMake(67.23, 22.66)];
            [bezier87Path addLineToPoint: CGPointMake(12.77, 22.66)];
            [bezier87Path addLineToPoint: CGPointMake(17.66, 27.6)];
            [bezier87Path addLineToPoint: CGPointMake(62.31, 27.6)];
            [bezier87Path addLineToPoint: CGPointMake(67.23, 22.66)];
            [bezier87Path closePath];
            [color102 setFill];
            [bezier87Path fill];
            
            
            //// Bezier 108 Drawing
            UIBezierPath* bezier108Path = [UIBezierPath bezierPath];
            [bezier108Path moveToPoint: CGPointMake(12.66, 22.66)];
            [bezier108Path addLineToPoint: CGPointMake(12.66, 77.34)];
            [bezier108Path addLineToPoint: CGPointMake(12.81, 77.34)];
            [bezier108Path addLineToPoint: CGPointMake(17.73, 72.4)];
            [bezier108Path addLineToPoint: CGPointMake(17.6, 72.4)];
            [bezier108Path addLineToPoint: CGPointMake(17.6, 27.6)];
            [bezier108Path addLineToPoint: CGPointMake(17.66, 27.6)];
            [bezier108Path addLineToPoint: CGPointMake(12.77, 22.66)];
            [bezier108Path addLineToPoint: CGPointMake(12.66, 22.66)];
            [bezier108Path closePath];
            [color104 setFill];
            [bezier108Path fill];
        }
            break;
        case 26:
            //// Facebook
        {
            //// Bezier 114 Drawing
            UIBezierPath* bezier114Path = [UIBezierPath bezierPath];
            [bezier114Path moveToPoint: CGPointMake(24.93, 8.82)];
            [bezier114Path addCurveToPoint: CGPointMake(25.55, 8.51) controlPoint1: CGPointMake(25.12, 8.7) controlPoint2: CGPointMake(25.33, 8.6)];
            [bezier114Path addCurveToPoint: CGPointMake(26.24, 8.28) controlPoint1: CGPointMake(25.75, 8.43) controlPoint2: CGPointMake(25.99, 8.35)];
            [bezier114Path addLineToPoint: CGPointMake(27.66, 8)];
            [bezier114Path addLineToPoint: CGPointMake(28.58, 8)];
            [bezier114Path addLineToPoint: CGPointMake(35.12, 8.52)];
            [bezier114Path addLineToPoint: CGPointMake(35.15, 8.52)];
            [bezier114Path addLineToPoint: CGPointMake(34.48, 14.59)];
            [bezier114Path addLineToPoint: CGPointMake(34.45, 14.59)];
            [bezier114Path addLineToPoint: CGPointMake(30.85, 14.2)];
            [bezier114Path addLineToPoint: CGPointMake(30.75, 14.2)];
            [bezier114Path addLineToPoint: CGPointMake(30.39, 14.25)];
            [bezier114Path addLineToPoint: CGPointMake(30.26, 14.3)];
            [bezier114Path addLineToPoint: CGPointMake(29.85, 14.51)];
            [bezier114Path addCurveToPoint: CGPointMake(29.64, 14.64) controlPoint1: CGPointMake(29.76, 14.53) controlPoint2: CGPointMake(29.69, 14.57)];
            [bezier114Path addLineToPoint: CGPointMake(29.33, 14.97)];
            [bezier114Path addCurveToPoint: CGPointMake(29.15, 15.28) controlPoint1: CGPointMake(29.26, 15.06) controlPoint2: CGPointMake(29.2, 15.16)];
            [bezier114Path addCurveToPoint: CGPointMake(29.02, 15.62) controlPoint1: CGPointMake(29.1, 15.39) controlPoint2: CGPointMake(29.06, 15.5)];
            [bezier114Path addCurveToPoint: CGPointMake(28.94, 16) controlPoint1: CGPointMake(28.99, 15.74) controlPoint2: CGPointMake(28.96, 15.87)];
            [bezier114Path addCurveToPoint: CGPointMake(28.92, 16.39) controlPoint1: CGPointMake(28.93, 16.12) controlPoint2: CGPointMake(28.92, 16.25)];
            [bezier114Path addLineToPoint: CGPointMake(28.97, 20.2)];
            [bezier114Path addLineToPoint: CGPointMake(34.27, 20.25)];
            [bezier114Path addLineToPoint: CGPointMake(33.5, 26.27)];
            [bezier114Path addLineToPoint: CGPointMake(28.92, 26.45)];
            [bezier114Path addLineToPoint: CGPointMake(28.92, 43.97)];
            [bezier114Path addLineToPoint: CGPointMake(28.89, 44)];
            [bezier114Path addLineToPoint: CGPointMake(21.74, 44)];
            [bezier114Path addLineToPoint: CGPointMake(21.74, 26.3)];
            [bezier114Path addLineToPoint: CGPointMake(17.88, 26.3)];
            [bezier114Path addLineToPoint: CGPointMake(17.88, 20.25)];
            [bezier114Path addLineToPoint: CGPointMake(21.59, 20.25)];
            [bezier114Path addLineToPoint: CGPointMake(21.59, 20.2)];
            [bezier114Path addLineToPoint: CGPointMake(21.61, 20.12)];
            [bezier114Path addLineToPoint: CGPointMake(21.74, 13.66)];
            [bezier114Path addLineToPoint: CGPointMake(21.79, 13.3)];
            [bezier114Path addLineToPoint: CGPointMake(21.79, 13.12)];
            [bezier114Path addLineToPoint: CGPointMake(21.84, 12.94)];
            [bezier114Path addCurveToPoint: CGPointMake(21.95, 12.55) controlPoint1: CGPointMake(21.86, 12.8) controlPoint2: CGPointMake(21.89, 12.67)];
            [bezier114Path addCurveToPoint: CGPointMake(22.1, 12.22) controlPoint1: CGPointMake(21.98, 12.43) controlPoint2: CGPointMake(22.03, 12.32)];
            [bezier114Path addCurveToPoint: CGPointMake(22.38, 11.53) controlPoint1: CGPointMake(22.17, 11.96) controlPoint2: CGPointMake(22.26, 11.73)];
            [bezier114Path addCurveToPoint: CGPointMake(22.77, 10.88) controlPoint1: CGPointMake(22.49, 11.3) controlPoint2: CGPointMake(22.61, 11.09)];
            [bezier114Path addCurveToPoint: CGPointMake(23.21, 10.34) controlPoint1: CGPointMake(22.89, 10.69) controlPoint2: CGPointMake(23.03, 10.51)];
            [bezier114Path addCurveToPoint: CGPointMake(23.69, 9.83) controlPoint1: CGPointMake(23.36, 10.15) controlPoint2: CGPointMake(23.52, 9.98)];
            [bezier114Path addLineToPoint: CGPointMake(23.69, 9.8)];
            [bezier114Path addLineToPoint: CGPointMake(24.93, 8.82)];
            [bezier114Path closePath];
            [color setFill];
            [bezier114Path fill];
        }
            break;
        case 27:
            //// Twitter
        {
            //// Bezier 113 Drawing
            UIBezierPath* bezier113Path = [UIBezierPath bezierPath];
            [bezier113Path moveToPoint: CGPointMake(12.71, 15.56)];
            [bezier113Path addCurveToPoint: CGPointMake(22.86, 20.14) controlPoint1: CGPointMake(16.22, 16.9) controlPoint2: CGPointMake(19.6, 18.42)];
            [bezier113Path addCurveToPoint: CGPointMake(24.25, 21.02) controlPoint1: CGPointMake(23.35, 20.39) controlPoint2: CGPointMake(23.81, 20.68)];
            [bezier113Path addCurveToPoint: CGPointMake(25.92, 22.47) controlPoint1: CGPointMake(24.81, 21.5) controlPoint2: CGPointMake(25.36, 21.98)];
            [bezier113Path addCurveToPoint: CGPointMake(28.57, 17.08) controlPoint1: CGPointMake(26.67, 20.59) controlPoint2: CGPointMake(27.55, 18.79)];
            [bezier113Path addCurveToPoint: CGPointMake(30.31, 14.68) controlPoint1: CGPointMake(29.06, 16.21) controlPoint2: CGPointMake(29.64, 15.41)];
            [bezier113Path addCurveToPoint: CGPointMake(32.12, 12.89) controlPoint1: CGPointMake(30.86, 14.04) controlPoint2: CGPointMake(31.46, 13.44)];
            [bezier113Path addLineToPoint: CGPointMake(31.53, 14.04)];
            [bezier113Path addCurveToPoint: CGPointMake(34.64, 12.59) controlPoint1: CGPointMake(32.41, 13.3) controlPoint2: CGPointMake(33.45, 12.82)];
            [bezier113Path addCurveToPoint: CGPointMake(34.35, 13.18) controlPoint1: CGPointMake(34.62, 12.84) controlPoint2: CGPointMake(34.53, 13.03)];
            [bezier113Path addCurveToPoint: CGPointMake(34.15, 13.38) controlPoint1: CGPointMake(34.28, 13.25) controlPoint2: CGPointMake(34.22, 13.31)];
            [bezier113Path addCurveToPoint: CGPointMake(33.91, 13.55) controlPoint1: CGPointMake(34.07, 13.44) controlPoint2: CGPointMake(33.99, 13.5)];
            [bezier113Path addCurveToPoint: CGPointMake(33.59, 13.7) controlPoint1: CGPointMake(33.81, 13.61) controlPoint2: CGPointMake(33.7, 13.66)];
            [bezier113Path addCurveToPoint: CGPointMake(32.83, 14.09) controlPoint1: CGPointMake(33.34, 13.84) controlPoint2: CGPointMake(33.09, 13.97)];
            [bezier113Path addCurveToPoint: CGPointMake(34.57, 13.52) controlPoint1: CGPointMake(33.45, 13.91) controlPoint2: CGPointMake(34.03, 13.72)];
            [bezier113Path addCurveToPoint: CGPointMake(35.3, 13.28) controlPoint1: CGPointMake(34.8, 13.41) controlPoint2: CGPointMake(35.04, 13.33)];
            [bezier113Path addCurveToPoint: CGPointMake(35.62, 13.26) controlPoint1: CGPointMake(35.4, 13.26) controlPoint2: CGPointMake(35.51, 13.26)];
            [bezier113Path addCurveToPoint: CGPointMake(35.84, 13.21) controlPoint1: CGPointMake(35.69, 13.22) controlPoint2: CGPointMake(35.76, 13.21)];
            [bezier113Path addCurveToPoint: CGPointMake(36.23, 13.28) controlPoint1: CGPointMake(35.97, 13.22) controlPoint2: CGPointMake(36.1, 13.25)];
            [bezier113Path addCurveToPoint: CGPointMake(36.41, 13.45) controlPoint1: CGPointMake(36.28, 13.33) controlPoint2: CGPointMake(36.34, 13.39)];
            [bezier113Path addCurveToPoint: CGPointMake(35.97, 14.16) controlPoint1: CGPointMake(36.49, 13.73) controlPoint2: CGPointMake(36.34, 13.97)];
            [bezier113Path addCurveToPoint: CGPointMake(34.91, 14.6) controlPoint1: CGPointMake(35.62, 14.33) controlPoint2: CGPointMake(35.27, 14.47)];
            [bezier113Path addCurveToPoint: CGPointMake(34.13, 14.82) controlPoint1: CGPointMake(34.65, 14.67) controlPoint2: CGPointMake(34.39, 14.74)];
            [bezier113Path addCurveToPoint: CGPointMake(33, 15.19) controlPoint1: CGPointMake(33.75, 14.94) controlPoint2: CGPointMake(33.38, 15.06)];
            [bezier113Path addCurveToPoint: CGPointMake(37.68, 16.39) controlPoint1: CGPointMake(34.72, 15.08) controlPoint2: CGPointMake(36.27, 15.48)];
            [bezier113Path addCurveToPoint: CGPointMake(39.4, 17.91) controlPoint1: CGPointMake(38.32, 16.82) controlPoint2: CGPointMake(38.89, 17.32)];
            [bezier113Path addCurveToPoint: CGPointMake(41.41, 21.78) controlPoint1: CGPointMake(40.36, 19.02) controlPoint2: CGPointMake(41.03, 20.31)];
            [bezier113Path addCurveToPoint: CGPointMake(41.63, 22.69) controlPoint1: CGPointMake(41.49, 22.08) controlPoint2: CGPointMake(41.56, 22.38)];
            [bezier113Path addCurveToPoint: CGPointMake(44.89, 22.71) controlPoint1: CGPointMake(42.69, 22.97) controlPoint2: CGPointMake(43.77, 22.98)];
            [bezier113Path addCurveToPoint: CGPointMake(45.91, 22.32) controlPoint1: CGPointMake(45.23, 22.6) controlPoint2: CGPointMake(45.57, 22.47)];
            [bezier113Path addCurveToPoint: CGPointMake(46.33, 22.15) controlPoint1: CGPointMake(46.06, 22.27) controlPoint2: CGPointMake(46.2, 22.21)];
            [bezier113Path addCurveToPoint: CGPointMake(44.17, 24.16) controlPoint1: CGPointMake(45.87, 23.1) controlPoint2: CGPointMake(45.15, 23.77)];
            [bezier113Path addCurveToPoint: CGPointMake(42.8, 24.55) controlPoint1: CGPointMake(43.73, 24.34) controlPoint2: CGPointMake(43.28, 24.47)];
            [bezier113Path addCurveToPoint: CGPointMake(42.02, 24.75) controlPoint1: CGPointMake(42.54, 24.65) controlPoint2: CGPointMake(42.28, 24.71)];
            [bezier113Path addCurveToPoint: CGPointMake(44.79, 25.29) controlPoint1: CGPointMake(42.9, 25.09) controlPoint2: CGPointMake(43.82, 25.27)];
            [bezier113Path addCurveToPoint: CGPointMake(45.96, 25.29) controlPoint1: CGPointMake(45.18, 25.29) controlPoint2: CGPointMake(45.57, 25.29)];
            [bezier113Path addCurveToPoint: CGPointMake(46.48, 25.19) controlPoint1: CGPointMake(46.13, 25.25) controlPoint2: CGPointMake(46.3, 25.22)];
            [bezier113Path addCurveToPoint: CGPointMake(43.88, 26.78) controlPoint1: CGPointMake(45.78, 25.99) controlPoint2: CGPointMake(44.91, 26.52)];
            [bezier113Path addCurveToPoint: CGPointMake(42.53, 26.98) controlPoint1: CGPointMake(43.42, 26.85) controlPoint2: CGPointMake(42.98, 26.91)];
            [bezier113Path addCurveToPoint: CGPointMake(41.77, 27) controlPoint1: CGPointMake(42.27, 26.98) controlPoint2: CGPointMake(42.02, 26.98)];
            [bezier113Path addCurveToPoint: CGPointMake(38.29, 33.42) controlPoint1: CGPointMake(41.19, 29.47) controlPoint2: CGPointMake(40.03, 31.61)];
            [bezier113Path addCurveToPoint: CGPointMake(35.31, 35.99) controlPoint1: CGPointMake(37.38, 34.38) controlPoint2: CGPointMake(36.38, 35.24)];
            [bezier113Path addCurveToPoint: CGPointMake(28.2, 39.28) controlPoint1: CGPointMake(33.15, 37.55) controlPoint2: CGPointMake(30.78, 38.64)];
            [bezier113Path addCurveToPoint: CGPointMake(19.99, 39.79) controlPoint1: CGPointMake(25.51, 39.96) controlPoint2: CGPointMake(22.77, 40.13)];
            [bezier113Path addCurveToPoint: CGPointMake(9.82, 35.28) controlPoint1: CGPointMake(16.17, 39.27) controlPoint2: CGPointMake(12.78, 37.77)];
            [bezier113Path addCurveToPoint: CGPointMake(6.78, 32.05) controlPoint1: CGPointMake(8.66, 34.32) controlPoint2: CGPointMake(7.65, 33.24)];
            [bezier113Path addCurveToPoint: CGPointMake(11.98, 34.69) controlPoint1: CGPointMake(8.24, 33.45) controlPoint2: CGPointMake(9.97, 34.34)];
            [bezier113Path addCurveToPoint: CGPointMake(15.11, 34.82) controlPoint1: CGPointMake(13.02, 34.87) controlPoint2: CGPointMake(14.07, 34.92)];
            [bezier113Path addCurveToPoint: CGPointMake(19.48, 33.35) controlPoint1: CGPointMake(16.73, 34.69) controlPoint2: CGPointMake(18.19, 34.2)];
            [bezier113Path addCurveToPoint: CGPointMake(21.53, 31.63) controlPoint1: CGPointMake(20.21, 32.86) controlPoint2: CGPointMake(20.9, 32.28)];
            [bezier113Path addCurveToPoint: CGPointMake(19.3, 31.16) controlPoint1: CGPointMake(20.73, 31.84) controlPoint2: CGPointMake(19.99, 31.69)];
            [bezier113Path addCurveToPoint: CGPointMake(18.79, 30.26) controlPoint1: CGPointMake(19.04, 30.94) controlPoint2: CGPointMake(18.87, 30.63)];
            [bezier113Path addCurveToPoint: CGPointMake(19.4, 28.79) controlPoint1: CGPointMake(18.66, 29.62) controlPoint2: CGPointMake(18.86, 29.13)];
            [bezier113Path addCurveToPoint: CGPointMake(20.28, 28.27) controlPoint1: CGPointMake(19.7, 28.61) controlPoint2: CGPointMake(19.99, 28.44)];
            [bezier113Path addCurveToPoint: CGPointMake(16.63, 27.24) controlPoint1: CGPointMake(18.9, 28.45) controlPoint2: CGPointMake(17.68, 28.11)];
            [bezier113Path addCurveToPoint: CGPointMake(15.78, 26.41) controlPoint1: CGPointMake(16.32, 27) controlPoint2: CGPointMake(16.04, 26.72)];
            [bezier113Path addCurveToPoint: CGPointMake(15.38, 25.87) controlPoint1: CGPointMake(15.63, 26.23) controlPoint2: CGPointMake(15.5, 26.05)];
            [bezier113Path addCurveToPoint: CGPointMake(17.22, 24.92) controlPoint1: CGPointMake(15.91, 25.33) controlPoint2: CGPointMake(16.52, 25.01)];
            [bezier113Path addCurveToPoint: CGPointMake(18.13, 24.79) controlPoint1: CGPointMake(17.52, 24.87) controlPoint2: CGPointMake(17.82, 24.83)];
            [bezier113Path addCurveToPoint: CGPointMake(14.94, 23.2) controlPoint1: CGPointMake(16.95, 24.56) controlPoint2: CGPointMake(15.89, 24.03)];
            [bezier113Path addCurveToPoint: CGPointMake(13.86, 21.53) controlPoint1: CGPointMake(14.42, 22.74) controlPoint2: CGPointMake(14.06, 22.19)];
            [bezier113Path addCurveToPoint: CGPointMake(13.67, 20.82) controlPoint1: CGPointMake(13.8, 21.29) controlPoint2: CGPointMake(13.73, 21.05)];
            [bezier113Path addLineToPoint: CGPointMake(16.12, 20.55)];
            [bezier113Path addCurveToPoint: CGPointMake(13.37, 18.13) controlPoint1: CGPointMake(14.97, 20.02) controlPoint2: CGPointMake(14.06, 19.21)];
            [bezier113Path addCurveToPoint: CGPointMake(13.32, 18.03) controlPoint1: CGPointMake(13.36, 18.09) controlPoint2: CGPointMake(13.34, 18.06)];
            [bezier113Path addCurveToPoint: CGPointMake(12.74, 16.19) controlPoint1: CGPointMake(12.97, 17.44) controlPoint2: CGPointMake(12.77, 16.83)];
            [bezier113Path addCurveToPoint: CGPointMake(12.71, 15.56) controlPoint1: CGPointMake(12.72, 15.98) controlPoint2: CGPointMake(12.71, 15.77)];
            [bezier113Path closePath];
            [color setFill];
            [bezier113Path fill];
        }
            break;
        case 28:
            //// Instagram
        {
            //// Bezier 111 Drawing
            UIBezierPath* bezier111Path = [UIBezierPath bezierPath];
            [bezier111Path moveToPoint: CGPointMake(34.52, 10.53)];
            [bezier111Path addLineToPoint: CGPointMake(18.97, 10.53)];
            [bezier111Path addCurveToPoint: CGPointMake(11.2, 18.3) controlPoint1: CGPointMake(14.68, 10.53) controlPoint2: CGPointMake(11.2, 14.01)];
            [bezier111Path addLineToPoint: CGPointMake(11.2, 33.97)];
            [bezier111Path addCurveToPoint: CGPointMake(18.97, 41.74) controlPoint1: CGPointMake(11.2, 38.26) controlPoint2: CGPointMake(14.68, 41.74)];
            [bezier111Path addLineToPoint: CGPointMake(34.52, 41.74)];
            [bezier111Path addCurveToPoint: CGPointMake(42.28, 33.97) controlPoint1: CGPointMake(38.8, 41.74) controlPoint2: CGPointMake(42.28, 38.26)];
            [bezier111Path addLineToPoint: CGPointMake(42.28, 18.3)];
            [bezier111Path addCurveToPoint: CGPointMake(34.52, 10.53) controlPoint1: CGPointMake(42.28, 14.01) controlPoint2: CGPointMake(38.8, 10.53)];
            [bezier111Path closePath];
            [bezier111Path moveToPoint: CGPointMake(18.97, 13.41)];
            [bezier111Path addLineToPoint: CGPointMake(34.52, 13.41)];
            [bezier111Path addCurveToPoint: CGPointMake(39.41, 18.3) controlPoint1: CGPointMake(37.21, 13.41) controlPoint2: CGPointMake(39.41, 15.6)];
            [bezier111Path addLineToPoint: CGPointMake(39.41, 20.97)];
            [bezier111Path addLineToPoint: CGPointMake(31.17, 20.97)];
            [bezier111Path addCurveToPoint: CGPointMake(26.9, 19.61) controlPoint1: CGPointMake(29.96, 20.11) controlPoint2: CGPointMake(28.49, 19.61)];
            [bezier111Path addCurveToPoint: CGPointMake(22.63, 20.97) controlPoint1: CGPointMake(25.31, 19.61) controlPoint2: CGPointMake(23.84, 20.11)];
            [bezier111Path addLineToPoint: CGPointMake(14.08, 20.97)];
            [bezier111Path addLineToPoint: CGPointMake(14.08, 18.3)];
            [bezier111Path addCurveToPoint: CGPointMake(18.97, 13.41) controlPoint1: CGPointMake(14.08, 15.6) controlPoint2: CGPointMake(16.27, 13.41)];
            [bezier111Path closePath];
            [bezier111Path moveToPoint: CGPointMake(29.96, 26.98)];
            [bezier111Path addCurveToPoint: CGPointMake(26.9, 30.05) controlPoint1: CGPointMake(29.96, 28.67) controlPoint2: CGPointMake(28.59, 30.05)];
            [bezier111Path addCurveToPoint: CGPointMake(23.84, 26.98) controlPoint1: CGPointMake(25.21, 30.05) controlPoint2: CGPointMake(23.84, 28.67)];
            [bezier111Path addCurveToPoint: CGPointMake(26.9, 23.92) controlPoint1: CGPointMake(23.84, 25.3) controlPoint2: CGPointMake(25.21, 23.92)];
            [bezier111Path addCurveToPoint: CGPointMake(29.96, 26.98) controlPoint1: CGPointMake(28.59, 23.92) controlPoint2: CGPointMake(29.96, 25.3)];
            [bezier111Path closePath];
            [bezier111Path moveToPoint: CGPointMake(34.52, 38.86)];
            [bezier111Path addLineToPoint: CGPointMake(18.97, 38.86)];
            [bezier111Path addCurveToPoint: CGPointMake(14.08, 33.97) controlPoint1: CGPointMake(16.27, 38.86) controlPoint2: CGPointMake(14.08, 36.67)];
            [bezier111Path addLineToPoint: CGPointMake(14.08, 23.85)];
            [bezier111Path addLineToPoint: CGPointMake(20.22, 23.85)];
            [bezier111Path addCurveToPoint: CGPointMake(19.52, 26.98) controlPoint1: CGPointMake(19.77, 24.8) controlPoint2: CGPointMake(19.52, 25.86)];
            [bezier111Path addCurveToPoint: CGPointMake(26.9, 34.36) controlPoint1: CGPointMake(19.52, 31.05) controlPoint2: CGPointMake(22.83, 34.36)];
            [bezier111Path addCurveToPoint: CGPointMake(34.28, 26.98) controlPoint1: CGPointMake(30.97, 34.36) controlPoint2: CGPointMake(34.28, 31.05)];
            [bezier111Path addCurveToPoint: CGPointMake(33.58, 23.85) controlPoint1: CGPointMake(34.28, 25.86) controlPoint2: CGPointMake(34.03, 24.8)];
            [bezier111Path addLineToPoint: CGPointMake(39.41, 23.85)];
            [bezier111Path addLineToPoint: CGPointMake(39.41, 33.97)];
            [bezier111Path addCurveToPoint: CGPointMake(34.52, 38.86) controlPoint1: CGPointMake(39.41, 36.67) controlPoint2: CGPointMake(37.21, 38.86)];
            [bezier111Path closePath];
            [color setFill];
            [bezier111Path fill];
            
            
            //// Bezier 112 Drawing
            UIBezierPath* bezier112Path = [UIBezierPath bezierPath];
            [bezier112Path moveToPoint: CGPointMake(37.15, 18.68)];
            [bezier112Path addCurveToPoint: CGPointMake(36.29, 19.55) controlPoint1: CGPointMake(37.15, 19.16) controlPoint2: CGPointMake(36.76, 19.55)];
            [bezier112Path addLineToPoint: CGPointMake(33.62, 19.55)];
            [bezier112Path addCurveToPoint: CGPointMake(32.76, 18.68) controlPoint1: CGPointMake(33.15, 19.55) controlPoint2: CGPointMake(32.76, 19.16)];
            [bezier112Path addLineToPoint: CGPointMake(32.76, 16.01)];
            [bezier112Path addCurveToPoint: CGPointMake(33.62, 15.15) controlPoint1: CGPointMake(32.76, 15.54) controlPoint2: CGPointMake(33.15, 15.15)];
            [bezier112Path addLineToPoint: CGPointMake(36.29, 15.15)];
            [bezier112Path addCurveToPoint: CGPointMake(37.15, 16.01) controlPoint1: CGPointMake(36.76, 15.15) controlPoint2: CGPointMake(37.15, 15.54)];
            [bezier112Path addLineToPoint: CGPointMake(37.15, 18.68)];
            [bezier112Path closePath];
            [color setFill];
            [bezier112Path fill];
        }
            break;
        case 29:
            //// CameraRoll
        {
            //// Bezier 115 Drawing
            UIBezierPath* bezier115Path = [UIBezierPath bezierPath];
            [bezier115Path moveToPoint: CGPointMake(35.8, 21.58)];
            [bezier115Path addLineToPoint: CGPointMake(35.8, 25.25)];
            [bezier115Path addLineToPoint: CGPointMake(38.97, 25.25)];
            [bezier115Path addLineToPoint: CGPointMake(38.97, 37.21)];
            [bezier115Path addLineToPoint: CGPointMake(21.95, 37.21)];
            [bezier115Path addLineToPoint: CGPointMake(21.95, 34.25)];
            [bezier115Path addLineToPoint: CGPointMake(18.27, 34.25)];
            [bezier115Path addLineToPoint: CGPointMake(18.27, 40.89)];
            [bezier115Path addLineToPoint: CGPointMake(42.64, 40.89)];
            [bezier115Path addLineToPoint: CGPointMake(42.64, 21.58)];
            [bezier115Path addLineToPoint: CGPointMake(35.8, 21.58)];
            [bezier115Path closePath];
            [color setFill];
            [bezier115Path fill];
            
            
            //// Bezier 116 Drawing
            UIBezierPath* bezier116Path = [UIBezierPath bezierPath];
            [bezier116Path moveToPoint: CGPointMake(33.44, 31.49)];
            [bezier116Path addLineToPoint: CGPointMake(9.07, 31.49)];
            [bezier116Path addLineToPoint: CGPointMake(9.07, 12.18)];
            [bezier116Path addLineToPoint: CGPointMake(33.44, 12.18)];
            [bezier116Path addLineToPoint: CGPointMake(33.44, 31.49)];
            [bezier116Path closePath];
            [bezier116Path moveToPoint: CGPointMake(12.75, 27.81)];
            [bezier116Path addLineToPoint: CGPointMake(29.76, 27.81)];
            [bezier116Path addLineToPoint: CGPointMake(29.76, 15.86)];
            [bezier116Path addLineToPoint: CGPointMake(12.75, 15.86)];
            [bezier116Path addLineToPoint: CGPointMake(12.75, 27.81)];
            [bezier116Path closePath];
            [color setFill];
            [bezier116Path fill];
        }
            break;
        case 30:
            //// Trash
        {
            //// Bezier 117 Drawing
            UIBezierPath* bezier117Path = [UIBezierPath bezierPath];
            [bezier117Path moveToPoint: CGPointMake(32.94, 42.33)];
            [bezier117Path addLineToPoint: CGPointMake(19.01, 42.33)];
            [bezier117Path addLineToPoint: CGPointMake(16.18, 17.26)];
            [bezier117Path addLineToPoint: CGPointMake(35.76, 17.26)];
            [bezier117Path addLineToPoint: CGPointMake(32.94, 42.33)];
            [bezier117Path closePath];
            [color setFill];
            [bezier117Path fill];
            
            
            //// Bezier 118 Drawing
            UIBezierPath* bezier118Path = [UIBezierPath bezierPath];
            [bezier118Path moveToPoint: CGPointMake(35.71, 11.87)];
            [bezier118Path addLineToPoint: CGPointMake(27.89, 11.87)];
            [bezier118Path addCurveToPoint: CGPointMake(27.96, 11.47) controlPoint1: CGPointMake(27.93, 11.74) controlPoint2: CGPointMake(27.96, 11.61)];
            [bezier118Path addCurveToPoint: CGPointMake(26.72, 10.23) controlPoint1: CGPointMake(27.96, 10.78) controlPoint2: CGPointMake(27.4, 10.23)];
            [bezier118Path addLineToPoint: CGPointMake(25.22, 10.23)];
            [bezier118Path addCurveToPoint: CGPointMake(23.99, 11.47) controlPoint1: CGPointMake(24.54, 10.23) controlPoint2: CGPointMake(23.99, 10.78)];
            [bezier118Path addCurveToPoint: CGPointMake(24.06, 11.87) controlPoint1: CGPointMake(23.99, 11.61) controlPoint2: CGPointMake(24.02, 11.74)];
            [bezier118Path addLineToPoint: CGPointMake(16.24, 11.87)];
            [bezier118Path addCurveToPoint: CGPointMake(14.82, 13.28) controlPoint1: CGPointMake(15.46, 11.87) controlPoint2: CGPointMake(14.82, 12.5)];
            [bezier118Path addCurveToPoint: CGPointMake(16.24, 14.69) controlPoint1: CGPointMake(14.82, 14.06) controlPoint2: CGPointMake(15.46, 14.69)];
            [bezier118Path addLineToPoint: CGPointMake(35.71, 14.69)];
            [bezier118Path addCurveToPoint: CGPointMake(37.12, 13.28) controlPoint1: CGPointMake(36.49, 14.69) controlPoint2: CGPointMake(37.12, 14.06)];
            [bezier118Path addCurveToPoint: CGPointMake(35.71, 11.87) controlPoint1: CGPointMake(37.12, 12.5) controlPoint2: CGPointMake(36.49, 11.87)];
            [bezier118Path closePath];
            [color setFill];
            [bezier118Path fill];
        }
            break;
        case 31:
            //// Camera Flash
        {
            //// Color Declarations
            UIColor* color0 = [UIColor colorWithRed: 0.427 green: 0.431 blue: 0.443 alpha: 1];
            
            //// Abstracted Attributes
            NSString* textContent = @"OFF";
            
            
            //// FlashOff
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(29.05, 24.27)];
                [bezierPath addCurveToPoint: CGPointMake(29.05, 35.58) controlPoint1: CGPointMake(32.01, 27.39) controlPoint2: CGPointMake(32.01, 32.46)];
                [bezierPath addCurveToPoint: CGPointMake(18.33, 35.58) controlPoint1: CGPointMake(26.09, 38.7) controlPoint2: CGPointMake(21.29, 38.7)];
                [bezierPath addCurveToPoint: CGPointMake(18.33, 24.27) controlPoint1: CGPointMake(15.37, 32.46) controlPoint2: CGPointMake(15.37, 27.39)];
                [bezierPath addCurveToPoint: CGPointMake(29.05, 24.27) controlPoint1: CGPointMake(21.29, 21.15) controlPoint2: CGPointMake(26.09, 21.15)];
                [bezierPath closePath];
                [color0 setStroke];
                bezierPath.lineWidth = 3.8;
                [bezierPath stroke];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint: CGPointMake(23.9, 46.34)];
                [bezier2Path addLineToPoint: CGPointMake(23.9, 51.49)];
                [color0 setStroke];
                bezier2Path.lineWidth = 3.3;
                [bezier2Path stroke];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
                [bezier3Path moveToPoint: CGPointMake(23.48, 13.51)];
                [bezier3Path addLineToPoint: CGPointMake(23.48, 8.36)];
                [color0 setStroke];
                bezier3Path.lineWidth = 3.3;
                [bezier3Path stroke];
                
                
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
                [bezier4Path moveToPoint: CGPointMake(12.54, 18.48)];
                [bezier4Path addLineToPoint: CGPointMake(9.08, 14.83)];
                [color0 setStroke];
                bezier4Path.lineWidth = 3.3;
                [bezier4Path stroke];
                
                
                //// Bezier 5 Drawing
                UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
                [bezier5Path moveToPoint: CGPointMake(8.13, 30.15)];
                [bezier5Path addLineToPoint: CGPointMake(3.24, 30.15)];
                [color0 setStroke];
                bezier5Path.lineWidth = 3.3;
                [bezier5Path stroke];
                
                
                //// Bezier 6 Drawing
                UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
                [bezier6Path moveToPoint: CGPointMake(12.84, 41.69)];
                [bezier6Path addLineToPoint: CGPointMake(9.38, 45.34)];
                [color0 setStroke];
                bezier6Path.lineWidth = 3.3;
                [bezier6Path stroke];
                
                
                //// Text Drawing
                CGRect textRect = CGRectMake(36, 24, 20, 20);
                [color0 setFill];
                [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Helvetica" size: 10]];
            }
            
            
            
        }
            break;
        case 32:
            //// SwitchCam
        {
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(75.13, 35.09)];
            [bezier4Path addLineToPoint: CGPointMake(70.98, 39.1)];
            [bezier4Path addLineToPoint: CGPointMake(67.29, 35.09)];
            [color setStroke];
            bezier4Path.lineWidth = 3.32;
            [bezier4Path stroke];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(71.21, 9.9)];
            [bezier5Path addLineToPoint: CGPointMake(71.21, 37.5)];
            [color setStroke];
            bezier5Path.lineWidth = 3.32;
            [bezier5Path stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(28.87, 13.91)];
            [bezier6Path addLineToPoint: CGPointMake(33.02, 9.9)];
            [bezier6Path addLineToPoint: CGPointMake(36.71, 13.91)];
            [color setStroke];
            bezier6Path.lineWidth = 3.32;
            [bezier6Path stroke];
            
            
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(32.79, 39.1)];
            [bezier7Path addLineToPoint: CGPointMake(32.79, 11.5)];
            [color setStroke];
            bezier7Path.lineWidth = 3.32;
            [bezier7Path stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(54.44, 22.27)];
            [bezier2Path addCurveToPoint: CGPointMake(54.44, 26.84) controlPoint1: CGPointMake(55.79, 23.53) controlPoint2: CGPointMake(55.79, 25.58)];
            [bezier2Path addCurveToPoint: CGPointMake(49.56, 26.84) controlPoint1: CGPointMake(53.09, 28.1) controlPoint2: CGPointMake(50.91, 28.1)];
            [bezier2Path addCurveToPoint: CGPointMake(49.56, 22.27) controlPoint1: CGPointMake(48.21, 25.58) controlPoint2: CGPointMake(48.21, 23.53)];
            [bezier2Path addCurveToPoint: CGPointMake(54.44, 22.27) controlPoint1: CGPointMake(50.91, 21.01) controlPoint2: CGPointMake(53.09, 21.01)];
            [bezier2Path closePath];
            [color setStroke];
            bezier2Path.lineWidth = 2.5;
            [bezier2Path stroke];
            
            
            //// Rectangle 2 Drawing
            UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(39.75, 17.33, 24.5, 14.55)];
            [color setStroke];
            rectangle2Path.lineWidth = 2.5;
            [rectangle2Path stroke];
        }
            break;
        case 33:
            //// Check
        {
            //// Color Declarations
            UIColor* color7 = [UIColor colorWithRed: 0.224 green: 0.71 blue: 0.29 alpha: 1];
            
            //// Check Drawing
            UIBezierPath* checkPath = [UIBezierPath bezierPath];
            [checkPath moveToPoint: CGPointMake(11.18, 20.47)];
            [checkPath addLineToPoint: CGPointMake(23.56, 37.76)];
            [checkPath addLineToPoint: CGPointMake(41.94, 6.8)];
            [color7 setStroke];
            checkPath.lineWidth = 6.75;
            [checkPath stroke];
        }
            break;
        case 34:
            //// Cross
        {
            //// Color Declarations
            UIColor* color8 = [UIColor colorWithRed: 0.929 green: 0.136 blue: 0.141 alpha: 1];
            {
                //// Bezier 24 Drawing
                UIBezierPath* bezier24Path = [UIBezierPath bezierPath];
                [bezier24Path moveToPoint: CGPointMake(12.17, 41.89)];
                [bezier24Path addLineToPoint: CGPointMake(40.62, 13.44)];
                [color8 setStroke];
                bezier24Path.lineWidth = 6.75;
                [bezier24Path stroke];
                
                
                //// Bezier 25 Drawing
                UIBezierPath* bezier25Path = [UIBezierPath bezierPath];
                [bezier25Path moveToPoint: CGPointMake(40.62, 41.89)];
                [bezier25Path addLineToPoint: CGPointMake(12.17, 13.44)];
                [color8 setStroke];
                bezier25Path.lineWidth = 6.75;
                [bezier25Path stroke];
            }
            
        }
            break;
        case 35:
            //// Cart
        {
            //// Color Declarations
            UIColor* color11 = [UIColor colorWithRed: 0.427 green: 0.431 blue: 0.443 alpha: 1];
            
            //// Bezier 23 Drawing
            UIBezierPath* bezier23Path = [UIBezierPath bezierPath];
            [bezier23Path moveToPoint: CGPointMake(48.85, 16.62)];
            [bezier23Path addLineToPoint: CGPointMake(48.85, 14.49)];
            [bezier23Path addLineToPoint: CGPointMake(45.69, 13.5)];
            [bezier23Path addLineToPoint: CGPointMake(45.69, 15.85)];
            [bezier23Path addLineToPoint: CGPointMake(45.69, 34.41)];
            [bezier23Path addLineToPoint: CGPointMake(45.69, 34.46)];
            [bezier23Path addLineToPoint: CGPointMake(74.32, 34.46)];
            [bezier23Path addLineToPoint: CGPointMake(74.32, 22.81)];
            [bezier23Path addLineToPoint: CGPointMake(48.85, 16.62)];
            [bezier23Path closePath];
            [bezier23Path moveToPoint: CGPointMake(71.15, 31.3)];
            [bezier23Path addLineToPoint: CGPointMake(48.85, 31.3)];
            [bezier23Path addLineToPoint: CGPointMake(48.85, 19.88)];
            [bezier23Path addLineToPoint: CGPointMake(71.16, 25.3)];
            [bezier23Path addLineToPoint: CGPointMake(71.16, 31.3)];
            [bezier23Path addLineToPoint: CGPointMake(71.15, 31.3)];
            [bezier23Path closePath];
            [color11 setFill];
            [bezier23Path fill];
            
            
            //// Bezier 28 Drawing
            UIBezierPath* bezier28Path = [UIBezierPath bezierPath];
            [bezier28Path moveToPoint: CGPointMake(45.7, 37.47)];
            [bezier28Path addLineToPoint: CGPointMake(74.3, 37.47)];
            [bezier28Path addLineToPoint: CGPointMake(74.3, 39.67)];
            [bezier28Path addLineToPoint: CGPointMake(45.7, 39.67)];
            [bezier28Path addLineToPoint: CGPointMake(45.7, 37.47)];
            [bezier28Path closePath];
            [color11 setFill];
            [bezier28Path fill];
            
            
            //// Bezier 29 Drawing
            UIBezierPath* bezier29Path = [UIBezierPath bezierPath];
            [bezier29Path moveToPoint: CGPointMake(52.08, 42.91)];
            [bezier29Path addCurveToPoint: CGPointMake(52.08, 45.88) controlPoint1: CGPointMake(52.9, 43.73) controlPoint2: CGPointMake(52.9, 45.06)];
            [bezier29Path addCurveToPoint: CGPointMake(49.1, 45.88) controlPoint1: CGPointMake(51.26, 46.71) controlPoint2: CGPointMake(49.92, 46.71)];
            [bezier29Path addCurveToPoint: CGPointMake(49.1, 42.91) controlPoint1: CGPointMake(48.28, 45.06) controlPoint2: CGPointMake(48.28, 43.73)];
            [bezier29Path addCurveToPoint: CGPointMake(52.08, 42.91) controlPoint1: CGPointMake(49.92, 42.09) controlPoint2: CGPointMake(51.26, 42.09)];
            [bezier29Path closePath];
            [color11 setFill];
            [bezier29Path fill];
            
            
            //// Bezier 30 Drawing
            UIBezierPath* bezier30Path = [UIBezierPath bezierPath];
            [bezier30Path moveToPoint: CGPointMake(71.1, 42.91)];
            [bezier30Path addCurveToPoint: CGPointMake(71.1, 45.88) controlPoint1: CGPointMake(71.92, 43.73) controlPoint2: CGPointMake(71.92, 45.06)];
            [bezier30Path addCurveToPoint: CGPointMake(68.13, 45.88) controlPoint1: CGPointMake(70.28, 46.71) controlPoint2: CGPointMake(68.95, 46.71)];
            [bezier30Path addCurveToPoint: CGPointMake(68.13, 42.91) controlPoint1: CGPointMake(67.3, 45.06) controlPoint2: CGPointMake(67.3, 43.73)];
            [bezier30Path addCurveToPoint: CGPointMake(71.1, 42.91) controlPoint1: CGPointMake(68.95, 42.09) controlPoint2: CGPointMake(70.28, 42.09)];
            [bezier30Path closePath];
            [color11 setFill];
            [bezier30Path fill];
        }
            break;
        case 36:
            //// Gallery TopBar
        {
            //// Color Declarations
            UIColor* color11 = [UIColor colorWithRed: 0.427 green: 0.431 blue: 0.443 alpha: 1];
            
            //// Gallery
            {
                //// Bezier 26 Drawing
                UIBezierPath* bezier26Path = [UIBezierPath bezierPath];
                [bezier26Path moveToPoint: CGPointMake(70.58, 25.93)];
                [bezier26Path addLineToPoint: CGPointMake(70.58, 29.69)];
                [bezier26Path addLineToPoint: CGPointMake(73.82, 29.69)];
                [bezier26Path addLineToPoint: CGPointMake(73.82, 41.93)];
                [bezier26Path addLineToPoint: CGPointMake(56.4, 41.93)];
                [bezier26Path addLineToPoint: CGPointMake(56.4, 38.9)];
                [bezier26Path addLineToPoint: CGPointMake(52.64, 38.9)];
                [bezier26Path addLineToPoint: CGPointMake(52.64, 45.69)];
                [bezier26Path addLineToPoint: CGPointMake(77.58, 45.69)];
                [bezier26Path addLineToPoint: CGPointMake(77.58, 25.93)];
                [bezier26Path addLineToPoint: CGPointMake(70.58, 25.93)];
                [bezier26Path closePath];
                [color11 setFill];
                [bezier26Path fill];
                
                
                //// Bezier 27 Drawing
                UIBezierPath* bezier27Path = [UIBezierPath bezierPath];
                [bezier27Path moveToPoint: CGPointMake(68.17, 36.07)];
                [bezier27Path addLineToPoint: CGPointMake(43.22, 36.07)];
                [bezier27Path addLineToPoint: CGPointMake(43.22, 16.31)];
                [bezier27Path addLineToPoint: CGPointMake(68.17, 16.31)];
                [bezier27Path addLineToPoint: CGPointMake(68.17, 36.07)];
                [bezier27Path closePath];
                [bezier27Path moveToPoint: CGPointMake(46.98, 32.31)];
                [bezier27Path addLineToPoint: CGPointMake(64.4, 32.31)];
                [bezier27Path addLineToPoint: CGPointMake(64.4, 20.07)];
                [bezier27Path addLineToPoint: CGPointMake(46.98, 20.07)];
                [bezier27Path addLineToPoint: CGPointMake(46.98, 32.31)];
                [bezier27Path closePath];
                [color11 setFill];
                [bezier27Path fill];
            }
            
            
            
        }
            break;
        case 37:
            //// Settings TopBar
        {
            //// Color Declarations
            UIColor* color11 = [UIColor colorWithRed: 0.427 green: 0.431 blue: 0.443 alpha: 1];
            
            //// Settings Drawing
            UIBezierPath* settingsPath = [UIBezierPath bezierPath];
            [settingsPath moveToPoint: CGPointMake(60.39, 25.28)];
            [settingsPath addLineToPoint: CGPointMake(61.76, 25.61)];
            [settingsPath addCurveToPoint: CGPointMake(63.22, 26.21) controlPoint1: CGPointMake(62.27, 25.74) controlPoint2: CGPointMake(62.77, 25.94)];
            [settingsPath addLineToPoint: CGPointMake(64.43, 26.92)];
            [settingsPath addLineToPoint: CGPointMake(65.15, 28.14)];
            [settingsPath addCurveToPoint: CGPointMake(65.75, 29.59) controlPoint1: CGPointMake(65.42, 28.59) controlPoint2: CGPointMake(65.62, 29.08)];
            [settingsPath addLineToPoint: CGPointMake(66.09, 30.96)];
            [settingsPath addLineToPoint: CGPointMake(65.73, 32.32)];
            [settingsPath addCurveToPoint: CGPointMake(65.13, 33.73) controlPoint1: CGPointMake(65.6, 32.81) controlPoint2: CGPointMake(65.4, 33.29)];
            [settingsPath addLineToPoint: CGPointMake(64.4, 34.94)];
            [settingsPath addLineToPoint: CGPointMake(63.17, 35.65)];
            [settingsPath addCurveToPoint: CGPointMake(61.81, 36.2) controlPoint1: CGPointMake(62.74, 35.89) controlPoint2: CGPointMake(62.28, 36.08)];
            [settingsPath addLineToPoint: CGPointMake(60.43, 36.55)];
            [settingsPath addLineToPoint: CGPointMake(59.04, 36.18)];
            [settingsPath addCurveToPoint: CGPointMake(57.72, 35.64) controlPoint1: CGPointMake(58.58, 36.06) controlPoint2: CGPointMake(58.14, 35.88)];
            [settingsPath addLineToPoint: CGPointMake(56.49, 34.92)];
            [settingsPath addLineToPoint: CGPointMake(55.76, 33.69)];
            [settingsPath addCurveToPoint: CGPointMake(55.19, 32.36) controlPoint1: CGPointMake(55.51, 33.28) controlPoint2: CGPointMake(55.32, 32.83)];
            [settingsPath addLineToPoint: CGPointMake(54.82, 31)];
            [settingsPath addLineToPoint: CGPointMake(55.16, 29.61)];
            [settingsPath addCurveToPoint: CGPointMake(55.71, 28.23) controlPoint1: CGPointMake(55.28, 29.12) controlPoint2: CGPointMake(55.46, 28.66)];
            [settingsPath addLineToPoint: CGPointMake(56.4, 27)];
            [settingsPath addLineToPoint: CGPointMake(57.62, 26.25)];
            [settingsPath addCurveToPoint: CGPointMake(59.03, 25.64) controlPoint1: CGPointMake(58.06, 25.98) controlPoint2: CGPointMake(58.53, 25.78)];
            [settingsPath addLineToPoint: CGPointMake(60.39, 25.28)];
            [settingsPath closePath];
            [settingsPath moveToPoint: CGPointMake(62.19, 20.89)];
            [settingsPath addLineToPoint: CGPointMake(58.54, 20.89)];
            [settingsPath addLineToPoint: CGPointMake(58.27, 22.85)];
            [settingsPath addCurveToPoint: CGPointMake(56.1, 23.78) controlPoint1: CGPointMake(57.5, 23.05) controlPoint2: CGPointMake(56.77, 23.37)];
            [settingsPath addLineToPoint: CGPointMake(54.51, 22.58)];
            [settingsPath addLineToPoint: CGPointMake(51.93, 25.16)];
            [settingsPath addLineToPoint: CGPointMake(53.18, 26.8)];
            [settingsPath addCurveToPoint: CGPointMake(52.34, 28.92) controlPoint1: CGPointMake(52.81, 27.45) controlPoint2: CGPointMake(52.52, 28.17)];
            [settingsPath addLineToPoint: CGPointMake(50.28, 29.2)];
            [settingsPath addLineToPoint: CGPointMake(50.28, 32.85)];
            [settingsPath addLineToPoint: CGPointMake(52.4, 33.13)];
            [settingsPath addCurveToPoint: CGPointMake(53.26, 35.17) controlPoint1: CGPointMake(52.6, 33.86) controlPoint2: CGPointMake(52.89, 34.54)];
            [settingsPath addLineToPoint: CGPointMake(51.96, 36.87)];
            [settingsPath addLineToPoint: CGPointMake(54.55, 39.46)];
            [settingsPath addLineToPoint: CGPointMake(56.27, 38.14)];
            [settingsPath addCurveToPoint: CGPointMake(58.3, 38.99) controlPoint1: CGPointMake(56.9, 38.51) controlPoint2: CGPointMake(57.58, 38.79)];
            [settingsPath addLineToPoint: CGPointMake(58.58, 41.11)];
            [settingsPath addLineToPoint: CGPointMake(62.24, 41.11)];
            [settingsPath addLineToPoint: CGPointMake(62.52, 39.01)];
            [settingsPath addCurveToPoint: CGPointMake(64.61, 38.16) controlPoint1: CGPointMake(63.26, 38.82) controlPoint2: CGPointMake(63.96, 38.53)];
            [settingsPath addLineToPoint: CGPointMake(66.26, 39.42)];
            [settingsPath addLineToPoint: CGPointMake(68.84, 36.84)];
            [settingsPath addLineToPoint: CGPointMake(67.61, 35.22)];
            [settingsPath addCurveToPoint: CGPointMake(68.52, 33.07) controlPoint1: CGPointMake(68.01, 34.56) controlPoint2: CGPointMake(68.32, 33.83)];
            [settingsPath addLineToPoint: CGPointMake(70.5, 32.8)];
            [settingsPath addLineToPoint: CGPointMake(70.5, 29.15)];
            [settingsPath addLineToPoint: CGPointMake(68.56, 28.89)];
            [settingsPath addCurveToPoint: CGPointMake(67.64, 26.66) controlPoint1: CGPointMake(68.36, 28.09) controlPoint2: CGPointMake(68.05, 27.34)];
            [settingsPath addLineToPoint: CGPointMake(68.81, 25.12)];
            [settingsPath addLineToPoint: CGPointMake(66.23, 22.54)];
            [settingsPath addLineToPoint: CGPointMake(64.69, 23.71)];
            [settingsPath addCurveToPoint: CGPointMake(62.45, 22.8) controlPoint1: CGPointMake(64, 23.31) controlPoint2: CGPointMake(63.25, 22.99)];
            [settingsPath addLineToPoint: CGPointMake(62.19, 20.89)];
            [settingsPath addLineToPoint: CGPointMake(62.19, 20.89)];
            [settingsPath closePath];
            [color11 setFill];
            [settingsPath fill];
            
            
            
        }
            break;
        case 38:
            //// ChangeShapeSetButton
        {
            //// Bezier 119 Drawing
            UIBezierPath* bezier119Path = [UIBezierPath bezierPath];
            [bezier119Path moveToPoint: CGPointMake(63.45, 16.02)];
            [bezier119Path addCurveToPoint: CGPointMake(63.45, 32.54) controlPoint1: CGPointMake(68.02, 20.58) controlPoint2: CGPointMake(68.02, 27.98)];
            [bezier119Path addCurveToPoint: CGPointMake(46.93, 32.54) controlPoint1: CGPointMake(58.89, 37.1) controlPoint2: CGPointMake(51.5, 37.1)];
            [bezier119Path addCurveToPoint: CGPointMake(46.93, 16.02) controlPoint1: CGPointMake(42.37, 27.98) controlPoint2: CGPointMake(42.37, 20.58)];
            [bezier119Path addCurveToPoint: CGPointMake(63.45, 16.02) controlPoint1: CGPointMake(51.5, 11.46) controlPoint2: CGPointMake(58.89, 11.46)];
            [bezier119Path closePath];
            [color setStroke];
            bezier119Path.lineWidth = 3.32;
            [bezier119Path stroke];
            
            
            //// Bezier 120 Drawing
            UIBezierPath* bezier120Path = [UIBezierPath bezierPath];
            [bezier120Path moveToPoint: CGPointMake(76.2, 34.57)];
            [bezier120Path addLineToPoint: CGPointMake(72.4, 38.19)];
            [bezier120Path addLineToPoint: CGPointMake(69.01, 34.57)];
            [color setStroke];
            bezier120Path.lineWidth = 3.32;
            [bezier120Path stroke];
            
            
            //// Bezier 121 Drawing
            UIBezierPath* bezier121Path = [UIBezierPath bezierPath];
            [bezier121Path moveToPoint: CGPointMake(72.61, 11.81)];
            [bezier121Path addLineToPoint: CGPointMake(72.61, 36.74)];
            [color setStroke];
            bezier121Path.lineWidth = 3.32;
            [bezier121Path stroke];
            
            
            //// Bezier 122 Drawing
            UIBezierPath* bezier122Path = [UIBezierPath bezierPath];
            [bezier122Path moveToPoint: CGPointMake(33.8, 15.43)];
            [bezier122Path addLineToPoint: CGPointMake(37.6, 11.81)];
            [bezier122Path addLineToPoint: CGPointMake(40.99, 15.43)];
            [color setStroke];
            bezier122Path.lineWidth = 3.32;
            [bezier122Path stroke];
            
            
            //// Bezier 123 Drawing
            UIBezierPath* bezier123Path = [UIBezierPath bezierPath];
            [bezier123Path moveToPoint: CGPointMake(37.39, 38.19)];
            [bezier123Path addLineToPoint: CGPointMake(37.39, 13.26)];
            [color setStroke];
            bezier123Path.lineWidth = 3.32;
            [bezier123Path stroke];
        }
            break;
        case 39:
            //// ChangeBackgroundSet
        {
            //// Bezier 125 Drawing
            UIBezierPath* bezier125Path = [UIBezierPath bezierPath];
            [bezier125Path moveToPoint: CGPointMake(54.2, 58.57)];
            [bezier125Path addLineToPoint: CGPointMake(50.4, 62.19)];
            [bezier125Path addLineToPoint: CGPointMake(47.01, 58.57)];
            [color setStroke];
            bezier125Path.lineWidth = 3.32;
            [bezier125Path stroke];
            
            
            //// Bezier 126 Drawing
            UIBezierPath* bezier126Path = [UIBezierPath bezierPath];
            [bezier126Path moveToPoint: CGPointMake(50.61, 35.81)];
            [bezier126Path addLineToPoint: CGPointMake(50.61, 60.74)];
            [color setStroke];
            bezier126Path.lineWidth = 3.32;
            [bezier126Path stroke];
            
            
            //// Bezier 127 Drawing
            UIBezierPath* bezier127Path = [UIBezierPath bezierPath];
            [bezier127Path moveToPoint: CGPointMake(26.8, 39.43)];
            [bezier127Path addLineToPoint: CGPointMake(30.6, 35.81)];
            [bezier127Path addLineToPoint: CGPointMake(33.99, 39.43)];
            [color setStroke];
            bezier127Path.lineWidth = 3.32;
            [bezier127Path stroke];
            
            
            //// Bezier 128 Drawing
            UIBezierPath* bezier128Path = [UIBezierPath bezierPath];
            [bezier128Path moveToPoint: CGPointMake(30.39, 62.19)];
            [bezier128Path addLineToPoint: CGPointMake(30.39, 37.26)];
            [color setStroke];
            bezier128Path.lineWidth = 3.32;
            [bezier128Path stroke];
            
            
            //// Bezier 129 Drawing
            UIBezierPath* bezier129Path = [UIBezierPath bezierPath];
            [bezier129Path moveToPoint: CGPointMake(61.81, 27.29)];
            [bezier129Path addLineToPoint: CGPointMake(61.89, 27.29)];
            [bezier129Path addLineToPoint: CGPointMake(61.89, 72.09)];
            [bezier129Path addLineToPoint: CGPointMake(17.22, 72.09)];
            [bezier129Path addLineToPoint: CGPointMake(12.3, 77.03)];
            [bezier129Path addLineToPoint: CGPointMake(66.83, 77.03)];
            [bezier129Path addLineToPoint: CGPointMake(66.83, 22.34)];
            [bezier129Path addLineToPoint: CGPointMake(66.72, 22.34)];
            [bezier129Path addLineToPoint: CGPointMake(61.81, 27.29)];
            [bezier129Path closePath];
            [color setFill];
            [bezier129Path fill];
            
            
            //// Bezier 130 Drawing
            UIBezierPath* bezier130Path = [UIBezierPath bezierPath];
            [bezier130Path moveToPoint: CGPointMake(17.09, 72.09)];
            [bezier130Path addLineToPoint: CGPointMake(17.09, 27.29)];
            [bezier130Path addLineToPoint: CGPointMake(61.81, 27.29)];
            [bezier130Path addLineToPoint: CGPointMake(66.72, 22.34)];
            [bezier130Path addLineToPoint: CGPointMake(12.15, 22.34)];
            [bezier130Path addLineToPoint: CGPointMake(12.15, 77.03)];
            [bezier130Path addLineToPoint: CGPointMake(12.3, 77.03)];
            [bezier130Path addLineToPoint: CGPointMake(17.22, 72.09)];
            [bezier130Path addLineToPoint: CGPointMake(17.09, 72.09)];
            [bezier130Path closePath];
            [color setFill];
            [bezier130Path fill];
        }
            break;
        case 103:
            //// treeFilled Drawing
        {
            UIBezierPath* treeFilledPath = [UIBezierPath bezierPath];
            [treeFilledPath moveToPoint: CGPointMake(98, 92.7)];
            [treeFilledPath addLineToPoint: CGPointMake(75.27, 64.55)];
            [treeFilledPath addLineToPoint: CGPointMake(89.56, 64.55)];
            [treeFilledPath addLineToPoint: CGPointMake(66.19, 35.6)];
            [treeFilledPath addLineToPoint: CGPointMake(78.75, 35.6)];
            [treeFilledPath addLineToPoint: CGPointMake(50, -0)];
            [treeFilledPath addLineToPoint: CGPointMake(21.25, 35.6)];
            [treeFilledPath addLineToPoint: CGPointMake(33.81, 35.6)];
            [treeFilledPath addLineToPoint: CGPointMake(10.44, 64.55)];
            [treeFilledPath addLineToPoint: CGPointMake(24.73, 64.55)];
            [treeFilledPath addLineToPoint: CGPointMake(2, 92.7)];
            [treeFilledPath addLineToPoint: CGPointMake(41.56, 92.7)];
            [treeFilledPath addLineToPoint: CGPointMake(41.56, 100)];
            [treeFilledPath addLineToPoint: CGPointMake(58.7, 100)];
            [treeFilledPath addLineToPoint: CGPointMake(58.7, 92.7)];
            [treeFilledPath addLineToPoint: CGPointMake(98, 92.7)];
            [treeFilledPath closePath];
            [color setFill];
            [treeFilledPath fill];
        }
            break;
        case 104:
            //// treeCutout Drawing
        {
            UIBezierPath* treeCutoutPath = [UIBezierPath bezierPath];
            [treeCutoutPath moveToPoint: CGPointMake(50, 20.09)];
            [treeCutoutPath addLineToPoint: CGPointMake(68.81, 43.27)];
            [treeCutoutPath addLineToPoint: CGPointMake(60.59, 43.27)];
            [treeCutoutPath addLineToPoint: CGPointMake(75.89, 62.11)];
            [treeCutoutPath addLineToPoint: CGPointMake(66.54, 62.11)];
            [treeCutoutPath addLineToPoint: CGPointMake(81.41, 80.44)];
            [treeCutoutPath addLineToPoint: CGPointMake(55.7, 80.44)];
            [treeCutoutPath addLineToPoint: CGPointMake(55.7, 85.19)];
            [treeCutoutPath addLineToPoint: CGPointMake(44.48, 85.19)];
            [treeCutoutPath addLineToPoint: CGPointMake(44.48, 80.44)];
            [treeCutoutPath addLineToPoint: CGPointMake(18.58, 80.44)];
            [treeCutoutPath addLineToPoint: CGPointMake(33.46, 62.11)];
            [treeCutoutPath addLineToPoint: CGPointMake(24.11, 62.11)];
            [treeCutoutPath addLineToPoint: CGPointMake(39.4, 43.27)];
            [treeCutoutPath addLineToPoint: CGPointMake(31.18, 43.27)];
            [treeCutoutPath addLineToPoint: CGPointMake(50, 20.09)];
            [treeCutoutPath closePath];
            [treeCutoutPath moveToPoint: CGPointMake(50, 6)];
            [treeCutoutPath addLineToPoint: CGPointMake(43.04, 14.58)];
            [treeCutoutPath addLineToPoint: CGPointMake(24.22, 37.75)];
            [treeCutoutPath addLineToPoint: CGPointMake(12.6, 52.08)];
            [treeCutoutPath addLineToPoint: CGPointMake(20.82, 52.08)];
            [treeCutoutPath addLineToPoint: CGPointMake(17.15, 56.6)];
            [treeCutoutPath addLineToPoint: CGPointMake(5.52, 70.92)];
            [treeCutoutPath addLineToPoint: CGPointMake(14.88, 70.92)];
            [treeCutoutPath addLineToPoint: CGPointMake(11.62, 74.93)];
            [treeCutoutPath addLineToPoint: CGPointMake(0, 89.25)];
            [treeCutoutPath addLineToPoint: CGPointMake(18.59, 89.25)];
            [treeCutoutPath addLineToPoint: CGPointMake(35.55, 89.25)];
            [treeCutoutPath addLineToPoint: CGPointMake(35.55, 94)];
            [treeCutoutPath addLineToPoint: CGPointMake(44.48, 94)];
            [treeCutoutPath addLineToPoint: CGPointMake(55.7, 94)];
            [treeCutoutPath addLineToPoint: CGPointMake(64.62, 94)];
            [treeCutoutPath addLineToPoint: CGPointMake(64.62, 89.25)];
            [treeCutoutPath addLineToPoint: CGPointMake(81.41, 89.25)];
            [treeCutoutPath addLineToPoint: CGPointMake(100, 89.25)];
            [treeCutoutPath addLineToPoint: CGPointMake(88.38, 74.93)];
            [treeCutoutPath addLineToPoint: CGPointMake(85.12, 70.92)];
            [treeCutoutPath addLineToPoint: CGPointMake(94.48, 70.92)];
            [treeCutoutPath addLineToPoint: CGPointMake(82.85, 56.6)];
            [treeCutoutPath addLineToPoint: CGPointMake(79.18, 52.08)];
            [treeCutoutPath addLineToPoint: CGPointMake(87.4, 52.08)];
            [treeCutoutPath addLineToPoint: CGPointMake(75.78, 37.75)];
            [treeCutoutPath addLineToPoint: CGPointMake(56.96, 14.58)];
            [treeCutoutPath addLineToPoint: CGPointMake(50, 6)];
            [treeCutoutPath addLineToPoint: CGPointMake(50, 6)];
            [treeCutoutPath closePath];
            [color setFill];
            [treeCutoutPath fill];
        }
            break;
        case 105:
            //// starFilled Drawing
        {
            UIBezierPath* starFilledPath = [UIBezierPath bezierPath];
            [starFilledPath moveToPoint: CGPointMake(50, 2.5)];
            [starFilledPath addLineToPoint: CGPointMake(65.93, 33.11)];
            [starFilledPath addLineToPoint: CGPointMake(100, 38.79)];
            [starFilledPath addLineToPoint: CGPointMake(75.78, 63.38)];
            [starFilledPath addLineToPoint: CGPointMake(80.9, 97.5)];
            [starFilledPath addLineToPoint: CGPointMake(50, 82.09)];
            [starFilledPath addLineToPoint: CGPointMake(19.1, 97.5)];
            [starFilledPath addLineToPoint: CGPointMake(24.22, 63.38)];
            [starFilledPath addLineToPoint: CGPointMake(0, 38.79)];
            [starFilledPath addLineToPoint: CGPointMake(34.07, 33.11)];
            [starFilledPath addLineToPoint: CGPointMake(50, 2.5)];
            [starFilledPath closePath];
            [color setFill];
            [starFilledPath fill];
        }
            break;
        case 106:
            //// starCutout Drawing
        {
            UIBezierPath* starCutoutPath = [UIBezierPath bezierPath];
            [starCutoutPath moveToPoint: CGPointMake(80.9, 98)];
            [starCutoutPath addLineToPoint: CGPointMake(50, 82.43)];
            [starCutoutPath addLineToPoint: CGPointMake(19.1, 98)];
            [starCutoutPath addLineToPoint: CGPointMake(24.22, 63.52)];
            [starCutoutPath addLineToPoint: CGPointMake(0, 38.67)];
            [starCutoutPath addLineToPoint: CGPointMake(34.07, 32.93)];
            [starCutoutPath addLineToPoint: CGPointMake(50, 2)];
            [starCutoutPath addLineToPoint: CGPointMake(65.93, 32.93)];
            [starCutoutPath addLineToPoint: CGPointMake(100, 38.67)];
            [starCutoutPath addLineToPoint: CGPointMake(75.78, 63.52)];
            [starCutoutPath addLineToPoint: CGPointMake(80.9, 98)];
            [starCutoutPath closePath];
            [starCutoutPath moveToPoint: CGPointMake(50, 70.22)];
            [starCutoutPath addLineToPoint: CGPointMake(67.11, 78.84)];
            [starCutoutPath addLineToPoint: CGPointMake(64.27, 59.75)];
            [starCutoutPath addLineToPoint: CGPointMake(77.69, 45.98)];
            [starCutoutPath addLineToPoint: CGPointMake(58.82, 42.81)];
            [starCutoutPath addLineToPoint: CGPointMake(50, 25.68)];
            [starCutoutPath addLineToPoint: CGPointMake(41.18, 42.81)];
            [starCutoutPath addLineToPoint: CGPointMake(22.31, 45.98)];
            [starCutoutPath addLineToPoint: CGPointMake(35.72, 59.75)];
            [starCutoutPath addLineToPoint: CGPointMake(32.89, 78.84)];
            [starCutoutPath addLineToPoint: CGPointMake(50, 70.22)];
            [starCutoutPath closePath];
            [color setFill];
            [starCutoutPath fill];
        }
            break;
        case 107:
            //// ornamentCutout Drawing
        {
            UIBezierPath* ornamentCutoutPath = [UIBezierPath bezierPath];
            [ornamentCutoutPath moveToPoint: CGPointMake(60.24, 20.62)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(60.24, 19.38)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(61.26, 19.38)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(61.26, 15.75)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(59.99, 14.47) controlPoint1: CGPointMake(61.26, 15.04) controlPoint2: CGPointMake(60.69, 14.47)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(51.57, 14.47)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(51.64, 13.78) controlPoint1: CGPointMake(51.59, 13.99) controlPoint2: CGPointMake(51.63, 13.82)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(51.68, 13.76) controlPoint1: CGPointMake(51.64, 13.78) controlPoint2: CGPointMake(51.65, 13.77)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(52.04, 13.64) controlPoint1: CGPointMake(51.8, 13.72) controlPoint2: CGPointMake(51.92, 13.68)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(52.13, 13.61) controlPoint1: CGPointMake(52.07, 13.63) controlPoint2: CGPointMake(52.1, 13.62)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(52.13, 13.61)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(56.92, 6.98) controlPoint1: CGPointMake(55.06, 12.56) controlPoint2: CGPointMake(56.92, 10.05)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(50, -0) controlPoint1: CGPointMake(56.92, 3.13) controlPoint2: CGPointMake(53.82, -0)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(43.08, 6.98) controlPoint1: CGPointMake(46.18, -0) controlPoint2: CGPointMake(43.08, 3.13)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(44.81, 8.73) controlPoint1: CGPointMake(43.08, 7.95) controlPoint2: CGPointMake(43.85, 8.73)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(46.54, 6.98) controlPoint1: CGPointMake(45.76, 8.73) controlPoint2: CGPointMake(46.54, 7.95)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(50, 3.49) controlPoint1: CGPointMake(46.54, 5.06) controlPoint2: CGPointMake(48.09, 3.49)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(53.46, 6.98) controlPoint1: CGPointMake(51.91, 3.49) controlPoint2: CGPointMake(53.46, 5.06)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(51.14, 10.27) controlPoint1: CGPointMake(53.46, 8.72) controlPoint2: CGPointMake(52.35, 9.78)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(50.28, 10.57) controlPoint1: CGPointMake(50.83, 10.35) controlPoint2: CGPointMake(50.54, 10.45)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(50.14, 10.64) controlPoint1: CGPointMake(50.23, 10.59) controlPoint2: CGPointMake(50.19, 10.61)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(48.11, 14.47) controlPoint1: CGPointMake(48.29, 11.58) controlPoint2: CGPointMake(48.12, 13.41)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(40.01, 14.47)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(38.74, 15.75) controlPoint1: CGPointMake(39.31, 14.47) controlPoint2: CGPointMake(38.74, 15.04)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(38.74, 19.38)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(39.76, 19.38)];
            [ornamentCutoutPath addLineToPoint: CGPointMake(39.76, 20.62)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(10, 59.64) controlPoint1: CGPointMake(22.63, 25.18) controlPoint2: CGPointMake(10, 40.92)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(50, 100) controlPoint1: CGPointMake(10, 81.93) controlPoint2: CGPointMake(27.91, 100)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(90, 59.64) controlPoint1: CGPointMake(72.09, 100) controlPoint2: CGPointMake(90, 81.93)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(60.24, 20.62) controlPoint1: CGPointMake(90, 40.92) controlPoint2: CGPointMake(77.37, 25.18)];
            [ornamentCutoutPath closePath];
            [ornamentCutoutPath moveToPoint: CGPointMake(50.09, 87.7)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(21.9, 59.25) controlPoint1: CGPointMake(34.52, 87.7) controlPoint2: CGPointMake(21.9, 74.96)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(50.09, 30.8) controlPoint1: CGPointMake(21.9, 43.53) controlPoint2: CGPointMake(34.52, 30.8)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(78.29, 59.25) controlPoint1: CGPointMake(65.67, 30.8) controlPoint2: CGPointMake(78.29, 43.53)];
            [ornamentCutoutPath addCurveToPoint: CGPointMake(50.09, 87.7) controlPoint1: CGPointMake(78.29, 74.96) controlPoint2: CGPointMake(65.67, 87.7)];
            [ornamentCutoutPath closePath];
            [color setFill];
            [ornamentCutoutPath fill];
        }
            break;
        case 108:
            //// ornamentFilled Drawing
        {
            UIBezierPath* ornamentFilledPath = [UIBezierPath bezierPath];
            [ornamentFilledPath moveToPoint: CGPointMake(60.24, 20.62)];
            [ornamentFilledPath addLineToPoint: CGPointMake(60.24, 19.38)];
            [ornamentFilledPath addLineToPoint: CGPointMake(61.26, 19.38)];
            [ornamentFilledPath addLineToPoint: CGPointMake(61.26, 15.75)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(59.99, 14.47) controlPoint1: CGPointMake(61.26, 15.04) controlPoint2: CGPointMake(60.7, 14.47)];
            [ornamentFilledPath addLineToPoint: CGPointMake(51.58, 14.47)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(51.64, 13.78) controlPoint1: CGPointMake(51.59, 13.99) controlPoint2: CGPointMake(51.63, 13.82)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(51.68, 13.76) controlPoint1: CGPointMake(51.64, 13.78) controlPoint2: CGPointMake(51.65, 13.78)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(52.04, 13.64) controlPoint1: CGPointMake(51.8, 13.73) controlPoint2: CGPointMake(51.92, 13.68)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(52.13, 13.61) controlPoint1: CGPointMake(52.07, 13.63) controlPoint2: CGPointMake(52.1, 13.62)];
            [ornamentFilledPath addLineToPoint: CGPointMake(52.13, 13.61)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(56.93, 6.98) controlPoint1: CGPointMake(55.06, 12.56) controlPoint2: CGPointMake(56.93, 10.05)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(50, -0) controlPoint1: CGPointMake(56.93, 3.13) controlPoint2: CGPointMake(53.82, -0)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(43.08, 6.98) controlPoint1: CGPointMake(46.18, -0) controlPoint2: CGPointMake(43.08, 3.13)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(44.81, 8.73) controlPoint1: CGPointMake(43.08, 7.95) controlPoint2: CGPointMake(43.85, 8.73)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(46.54, 6.98) controlPoint1: CGPointMake(45.77, 8.73) controlPoint2: CGPointMake(46.54, 7.95)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(50, 3.49) controlPoint1: CGPointMake(46.54, 5.06) controlPoint2: CGPointMake(48.09, 3.49)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(53.46, 6.98) controlPoint1: CGPointMake(51.91, 3.49) controlPoint2: CGPointMake(53.46, 5.06)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(51.14, 10.27) controlPoint1: CGPointMake(53.46, 8.72) controlPoint2: CGPointMake(52.35, 9.78)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(50.28, 10.57) controlPoint1: CGPointMake(50.82, 10.35) controlPoint2: CGPointMake(50.54, 10.45)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(50.14, 10.64) controlPoint1: CGPointMake(50.23, 10.59) controlPoint2: CGPointMake(50.19, 10.61)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(48.11, 14.47) controlPoint1: CGPointMake(48.29, 11.59) controlPoint2: CGPointMake(48.12, 13.41)];
            [ornamentFilledPath addLineToPoint: CGPointMake(40.01, 14.47)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(38.74, 15.75) controlPoint1: CGPointMake(39.3, 14.47) controlPoint2: CGPointMake(38.74, 15.04)];
            [ornamentFilledPath addLineToPoint: CGPointMake(38.74, 19.38)];
            [ornamentFilledPath addLineToPoint: CGPointMake(39.76, 19.38)];
            [ornamentFilledPath addLineToPoint: CGPointMake(39.76, 20.62)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(10, 59.64) controlPoint1: CGPointMake(22.63, 25.18) controlPoint2: CGPointMake(10, 40.92)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(50, 100) controlPoint1: CGPointMake(10, 81.93) controlPoint2: CGPointMake(27.91, 100)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(90, 59.64) controlPoint1: CGPointMake(72.09, 100) controlPoint2: CGPointMake(90, 81.93)];
            [ornamentFilledPath addCurveToPoint: CGPointMake(60.24, 20.62) controlPoint1: CGPointMake(90, 40.92) controlPoint2: CGPointMake(77.37, 25.18)];
            [ornamentFilledPath closePath];
            [color setFill];
            [ornamentFilledPath fill];
        }
            break;
        case 53:
            //// treeFilledButton Drawing
        {
            UIBezierPath* treeFilledButtonPath = [UIBezierPath bezierPath];
            [treeFilledButtonPath moveToPoint: CGPointMake(55, 46.35)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(43.63, 32.28)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(50.78, 32.28)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(39.09, 17.8)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(45.37, 17.8)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(31, -0)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(16.63, 17.8)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(22.91, 17.8)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(11.22, 32.28)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(18.37, 32.28)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(7, 46.35)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(26.78, 46.35)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(26.78, 50)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(35.35, 50)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(35.35, 46.35)];
            [treeFilledButtonPath addLineToPoint: CGPointMake(55, 46.35)];
            [treeFilledButtonPath closePath];
            [color setFill];
            [treeFilledButtonPath fill];
        }
            break;
        case 54:
            //// treeCutoutButton Drawing
        {
            UIBezierPath* treeCutoutButtonPath = [UIBezierPath bezierPath];
            [treeCutoutButtonPath moveToPoint: CGPointMake(32, 10.04)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(41.41, 21.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(37.3, 21.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(44.95, 31.06)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(40.27, 31.06)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(47.71, 40.22)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(34.85, 40.22)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(34.85, 42.59)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(29.24, 42.59)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(29.24, 40.22)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(16.29, 40.22)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(23.73, 31.06)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(19.05, 31.06)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(26.7, 21.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(22.59, 21.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(32, 10.04)];
            [treeCutoutButtonPath closePath];
            [treeCutoutButtonPath moveToPoint: CGPointMake(32, 3)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(28.52, 7.29)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(19.11, 18.88)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(13.3, 26.04)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(17.41, 26.04)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(15.57, 28.3)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(9.76, 35.46)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(14.44, 35.46)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(12.81, 37.46)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(7, 44.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(16.29, 44.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(24.78, 44.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(24.78, 47)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(29.24, 47)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(34.85, 47)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(39.31, 47)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(39.31, 44.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(47.71, 44.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(57, 44.63)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(51.19, 37.46)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(49.56, 35.46)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(54.24, 35.46)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(48.43, 28.3)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(46.59, 26.04)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(50.7, 26.04)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(44.89, 18.88)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(35.48, 7.29)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(32, 3)];
            [treeCutoutButtonPath addLineToPoint: CGPointMake(32, 3)];
            [treeCutoutButtonPath closePath];
            [color setFill];
            [treeCutoutButtonPath fill];
        }
            break;
        case 55:
            //// starFilledButton Drawing
        {
            UIBezierPath* starFilledButtonPath = [UIBezierPath bezierPath];
            [starFilledButtonPath moveToPoint: CGPointMake(32, 1)];
            [starFilledButtonPath addLineToPoint: CGPointMake(39.97, 16.47)];
            [starFilledButtonPath addLineToPoint: CGPointMake(57, 19.33)];
            [starFilledButtonPath addLineToPoint: CGPointMake(44.89, 31.76)];
            [starFilledButtonPath addLineToPoint: CGPointMake(47.45, 49)];
            [starFilledButtonPath addLineToPoint: CGPointMake(32, 41.21)];
            [starFilledButtonPath addLineToPoint: CGPointMake(16.55, 49)];
            [starFilledButtonPath addLineToPoint: CGPointMake(19.11, 31.76)];
            [starFilledButtonPath addLineToPoint: CGPointMake(7, 19.33)];
            [starFilledButtonPath addLineToPoint: CGPointMake(24.03, 16.47)];
            [starFilledButtonPath addLineToPoint: CGPointMake(32, 1)];
            [starFilledButtonPath closePath];
            [color setFill];
            [starFilledButtonPath fill];
        }
            break;
        case 56:
            //// starCutoutButton Drawing
        {
            UIBezierPath* starCutoutButtonPath = [UIBezierPath bezierPath];
            [starCutoutButtonPath moveToPoint: CGPointMake(47.45, 49)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(32, 41.21)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(16.55, 49)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(19.11, 31.76)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(7, 19.33)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(24.03, 16.47)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(32, 1)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(39.97, 16.47)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(57, 19.33)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(44.89, 31.76)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(47.45, 49)];
            [starCutoutButtonPath closePath];
            [starCutoutButtonPath moveToPoint: CGPointMake(32, 35.11)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(40.56, 39.42)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(39.14, 29.87)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(45.84, 22.99)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(36.41, 21.4)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(32, 12.84)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(27.59, 21.4)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(18.16, 22.99)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(24.86, 29.87)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(23.44, 39.42)];
            [starCutoutButtonPath addLineToPoint: CGPointMake(32, 35.11)];
            [starCutoutButtonPath closePath];
            [color setFill];
            [starCutoutButtonPath fill];
        }
            break;
        case 57:
            //// ornamentCutoutButton Drawing
        {
            UIBezierPath* ornamentCutoutButtonPath = [UIBezierPath bezierPath];
            [ornamentCutoutButtonPath moveToPoint: CGPointMake(36.86, 10.31)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(36.86, 9.69)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(37.35, 9.69)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(37.35, 7.87)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(36.75, 7.23) controlPoint1: CGPointMake(37.35, 7.52) controlPoint2: CGPointMake(37.08, 7.23)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(32.75, 7.23)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.78, 6.89) controlPoint1: CGPointMake(32.75, 7) controlPoint2: CGPointMake(32.77, 6.91)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.8, 6.88) controlPoint1: CGPointMake(32.78, 6.89) controlPoint2: CGPointMake(32.79, 6.89)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.97, 6.82) controlPoint1: CGPointMake(32.86, 6.86) controlPoint2: CGPointMake(32.91, 6.84)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(33.01, 6.81) controlPoint1: CGPointMake(32.99, 6.81) controlPoint2: CGPointMake(33, 6.81)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(33.01, 6.8)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(35.29, 3.49) controlPoint1: CGPointMake(34.4, 6.28) controlPoint2: CGPointMake(35.29, 5.02)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32, -0) controlPoint1: CGPointMake(35.29, 1.57) controlPoint2: CGPointMake(33.81, -0)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(28.71, 3.49) controlPoint1: CGPointMake(30.19, -0) controlPoint2: CGPointMake(28.71, 1.57)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(29.53, 4.37) controlPoint1: CGPointMake(28.71, 3.97) controlPoint2: CGPointMake(29.08, 4.37)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(30.36, 3.49) controlPoint1: CGPointMake(29.99, 4.37) controlPoint2: CGPointMake(30.36, 3.97)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32, 1.75) controlPoint1: CGPointMake(30.36, 2.53) controlPoint2: CGPointMake(31.09, 1.75)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(33.64, 3.49) controlPoint1: CGPointMake(32.91, 1.75) controlPoint2: CGPointMake(33.64, 2.53)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.54, 5.13) controlPoint1: CGPointMake(33.64, 4.36) controlPoint2: CGPointMake(33.12, 4.89)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.14, 5.28) controlPoint1: CGPointMake(32.39, 5.17) controlPoint2: CGPointMake(32.26, 5.22)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.07, 5.32) controlPoint1: CGPointMake(32.11, 5.29) controlPoint2: CGPointMake(32.09, 5.31)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(31.1, 7.23) controlPoint1: CGPointMake(31.19, 5.79) controlPoint2: CGPointMake(31.11, 6.7)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(27.25, 7.23)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(26.65, 7.87) controlPoint1: CGPointMake(26.92, 7.23) controlPoint2: CGPointMake(26.65, 7.52)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(26.65, 9.69)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(27.14, 9.69)];
            [ornamentCutoutButtonPath addLineToPoint: CGPointMake(27.14, 10.31)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(13, 29.82) controlPoint1: CGPointMake(19, 12.59) controlPoint2: CGPointMake(13, 20.46)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32, 50) controlPoint1: CGPointMake(13, 40.96) controlPoint2: CGPointMake(21.51, 50)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(51, 29.82) controlPoint1: CGPointMake(42.49, 50) controlPoint2: CGPointMake(51, 40.97)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(36.86, 10.31) controlPoint1: CGPointMake(51, 20.46) controlPoint2: CGPointMake(45, 12.59)];
            [ornamentCutoutButtonPath closePath];
            [ornamentCutoutButtonPath moveToPoint: CGPointMake(32.04, 43.85)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(18.65, 29.62) controlPoint1: CGPointMake(24.65, 43.85) controlPoint2: CGPointMake(18.65, 37.48)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.04, 15.4) controlPoint1: CGPointMake(18.65, 21.77) controlPoint2: CGPointMake(24.65, 15.4)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(45.44, 29.62) controlPoint1: CGPointMake(39.44, 15.4) controlPoint2: CGPointMake(45.44, 21.77)];
            [ornamentCutoutButtonPath addCurveToPoint: CGPointMake(32.04, 43.85) controlPoint1: CGPointMake(45.44, 37.48) controlPoint2: CGPointMake(39.44, 43.85)];
            [ornamentCutoutButtonPath closePath];
            [color setFill];
            [ornamentCutoutButtonPath fill];        }
            break;
        case 58:
            //// ornamentFilledButton Drawing
        {
            UIBezierPath* ornamentFilledButtonPath = [UIBezierPath bezierPath];
            [ornamentFilledButtonPath moveToPoint: CGPointMake(36.86, 10.31)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(36.86, 9.69)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(37.35, 9.69)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(37.35, 7.87)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(36.75, 7.23) controlPoint1: CGPointMake(37.35, 7.52) controlPoint2: CGPointMake(37.08, 7.23)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(32.75, 7.23)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32.78, 6.89) controlPoint1: CGPointMake(32.76, 7) controlPoint2: CGPointMake(32.77, 6.91)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32.8, 6.88) controlPoint1: CGPointMake(32.78, 6.89) controlPoint2: CGPointMake(32.79, 6.89)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32.97, 6.82) controlPoint1: CGPointMake(32.86, 6.86) controlPoint2: CGPointMake(32.91, 6.84)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(33.01, 6.81) controlPoint1: CGPointMake(32.99, 6.81) controlPoint2: CGPointMake(33, 6.81)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(33.01, 6.8)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(35.29, 3.49) controlPoint1: CGPointMake(34.4, 6.28) controlPoint2: CGPointMake(35.29, 5.02)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32, -0) controlPoint1: CGPointMake(35.29, 1.57) controlPoint2: CGPointMake(33.81, -0)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(28.71, 3.49) controlPoint1: CGPointMake(30.19, -0) controlPoint2: CGPointMake(28.71, 1.57)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(29.53, 4.37) controlPoint1: CGPointMake(28.71, 3.98) controlPoint2: CGPointMake(29.08, 4.37)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(30.36, 3.49) controlPoint1: CGPointMake(29.99, 4.37) controlPoint2: CGPointMake(30.36, 3.97)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32, 1.75) controlPoint1: CGPointMake(30.36, 2.53) controlPoint2: CGPointMake(31.09, 1.75)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(33.64, 3.49) controlPoint1: CGPointMake(32.91, 1.75) controlPoint2: CGPointMake(33.64, 2.53)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32.54, 5.13) controlPoint1: CGPointMake(33.64, 4.36) controlPoint2: CGPointMake(33.12, 4.89)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32.13, 5.28) controlPoint1: CGPointMake(32.39, 5.18) controlPoint2: CGPointMake(32.25, 5.22)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32.07, 5.32) controlPoint1: CGPointMake(32.11, 5.29) controlPoint2: CGPointMake(32.09, 5.31)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(31.1, 7.23) controlPoint1: CGPointMake(31.19, 5.79) controlPoint2: CGPointMake(31.11, 6.7)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(27.25, 7.23)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(26.65, 7.87) controlPoint1: CGPointMake(26.92, 7.23) controlPoint2: CGPointMake(26.65, 7.52)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(26.65, 9.69)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(27.14, 9.69)];
            [ornamentFilledButtonPath addLineToPoint: CGPointMake(27.14, 10.31)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(13, 29.82) controlPoint1: CGPointMake(19, 12.59) controlPoint2: CGPointMake(13, 20.46)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(32, 50) controlPoint1: CGPointMake(13, 40.97) controlPoint2: CGPointMake(21.51, 50)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(51, 29.82) controlPoint1: CGPointMake(42.49, 50) controlPoint2: CGPointMake(51, 40.97)];
            [ornamentFilledButtonPath addCurveToPoint: CGPointMake(36.86, 10.31) controlPoint1: CGPointMake(51, 20.46) controlPoint2: CGPointMake(45, 12.59)];
            [ornamentFilledButtonPath closePath];
            [color setFill];
            [ornamentFilledButtonPath fill];
        }
            break;
        case 123:
            //// XmasCC
        {
            //// XmasCCFrame
            {
                CGContextSaveGState(context);
                
                //// Clip Bezier 142
                UIBezierPath* bezier142Path = [UIBezierPath bezierPath];
                [bezier142Path moveToPoint: CGPointMake(62.86, 27.05)];
                [bezier142Path addLineToPoint: CGPointMake(62.95, 27.05)];
                [bezier142Path addLineToPoint: CGPointMake(62.95, 72.82)];
                [bezier142Path addLineToPoint: CGPointMake(17.31, 72.82)];
                [bezier142Path addLineToPoint: CGPointMake(12.29, 77.87)];
                [bezier142Path addLineToPoint: CGPointMake(68, 77.87)];
                [bezier142Path addLineToPoint: CGPointMake(68, 22)];
                [bezier142Path addLineToPoint: CGPointMake(67.89, 22)];
                [bezier142Path addLineToPoint: CGPointMake(62.86, 27.05)];
                [bezier142Path closePath];
                [bezier142Path addClip];
                
                
                //// CCClipping
                {
                    //// Bezier 138 Drawing
                    UIBezierPath* bezier138Path = [UIBezierPath bezierPath];
                    [bezier138Path moveToPoint: CGPointMake(62.86, 27.05)];
                    [bezier138Path addLineToPoint: CGPointMake(62.95, 27.05)];
                    [bezier138Path addLineToPoint: CGPointMake(62.95, 72.82)];
                    [bezier138Path addLineToPoint: CGPointMake(17.31, 72.82)];
                    [bezier138Path addLineToPoint: CGPointMake(12.29, 77.87)];
                    [bezier138Path addLineToPoint: CGPointMake(68, 77.87)];
                    [bezier138Path addLineToPoint: CGPointMake(68, 22)];
                    [bezier138Path addLineToPoint: CGPointMake(67.89, 22)];
                    [bezier138Path addLineToPoint: CGPointMake(62.86, 27.05)];
                    [bezier138Path closePath];
                    [color115 setFill];
                    [bezier138Path fill];
                }
                
                
                //// Bezier 143 Drawing
                UIBezierPath* bezier143Path = [UIBezierPath bezierPath];
                [bezier143Path moveToPoint: CGPointMake(0.29, 60.13)];
                [bezier143Path addLineToPoint: CGPointMake(4.14, 56.28)];
                [bezier143Path addLineToPoint: CGPointMake(48.31, 100.46)];
                [bezier143Path addLineToPoint: CGPointMake(44.46, 104.31)];
                [bezier143Path addLineToPoint: CGPointMake(0.29, 60.13)];
                [bezier143Path closePath];
                [color117 setFill];
                [bezier143Path fill];
                
                
                //// Bezier 144 Drawing
                UIBezierPath* bezier144Path = [UIBezierPath bezierPath];
                [bezier144Path moveToPoint: CGPointMake(9.78, 50.64)];
                [bezier144Path addLineToPoint: CGPointMake(13.63, 46.8)];
                [bezier144Path addLineToPoint: CGPointMake(57.81, 90.96)];
                [bezier144Path addLineToPoint: CGPointMake(53.96, 94.81)];
                [bezier144Path addLineToPoint: CGPointMake(9.78, 50.64)];
                [bezier144Path closePath];
                [color117 setFill];
                [bezier144Path fill];
                
                
                //// Bezier 145 Drawing
                UIBezierPath* bezier145Path = [UIBezierPath bezierPath];
                [bezier145Path moveToPoint: CGPointMake(19.27, 41.16)];
                [bezier145Path addLineToPoint: CGPointMake(23.11, 37.31)];
                [bezier145Path addLineToPoint: CGPointMake(67.29, 81.48)];
                [bezier145Path addLineToPoint: CGPointMake(63.45, 85.33)];
                [bezier145Path addLineToPoint: CGPointMake(19.27, 41.16)];
                [bezier145Path closePath];
                [color117 setFill];
                [bezier145Path fill];
                
                
                //// Bezier 146 Drawing
                UIBezierPath* bezier146Path = [UIBezierPath bezierPath];
                [bezier146Path moveToPoint: CGPointMake(28.75, 31.67)];
                [bezier146Path addLineToPoint: CGPointMake(32.6, 27.82)];
                [bezier146Path addLineToPoint: CGPointMake(76.78, 71.99)];
                [bezier146Path addLineToPoint: CGPointMake(72.93, 75.84)];
                [bezier146Path addLineToPoint: CGPointMake(28.75, 31.67)];
                [bezier146Path closePath];
                [color117 setFill];
                [bezier146Path fill];
                
                
                //// Bezier 147 Drawing
                UIBezierPath* bezier147Path = [UIBezierPath bezierPath];
                [bezier147Path moveToPoint: CGPointMake(38.24, 22.18)];
                [bezier147Path addLineToPoint: CGPointMake(42.09, 18.33)];
                [bezier147Path addLineToPoint: CGPointMake(86.27, 62.5)];
                [bezier147Path addLineToPoint: CGPointMake(82.42, 66.35)];
                [bezier147Path addLineToPoint: CGPointMake(38.24, 22.18)];
                [bezier147Path closePath];
                [color117 setFill];
                [bezier147Path fill];
                
                
                //// Bezier 148 Drawing
                UIBezierPath* bezier148Path = [UIBezierPath bezierPath];
                [bezier148Path moveToPoint: CGPointMake(47.73, 12.69)];
                [bezier148Path addLineToPoint: CGPointMake(51.58, 8.84)];
                [bezier148Path addLineToPoint: CGPointMake(95.76, 53.01)];
                [bezier148Path addLineToPoint: CGPointMake(91.91, 56.86)];
                [bezier148Path addLineToPoint: CGPointMake(47.73, 12.69)];
                [bezier148Path closePath];
                [color117 setFill];
                [bezier148Path fill];
                
                
                CGContextRestoreGState(context);
            }
            
            
            //// Bezier 139 Drawing
            UIBezierPath* bezier139Path = [UIBezierPath bezierPath];
            [bezier139Path moveToPoint: CGPointMake(17.05, 72.82)];
            [bezier139Path addLineToPoint: CGPointMake(17.05, 27.05)];
            [bezier139Path addLineToPoint: CGPointMake(62.73, 27.05)];
            [bezier139Path addLineToPoint: CGPointMake(67.75, 22)];
            [bezier139Path addLineToPoint: CGPointMake(12, 22)];
            [bezier139Path addLineToPoint: CGPointMake(12, 77.87)];
            [bezier139Path addLineToPoint: CGPointMake(12.15, 77.87)];
            [bezier139Path addLineToPoint: CGPointMake(17.18, 72.82)];
            [bezier139Path addLineToPoint: CGPointMake(17.05, 72.82)];
            [bezier139Path closePath];
            [color115 setFill];
            [bezier139Path fill];
            
            
            //// Bezier 140 Drawing
            UIBezierPath* bezier140Path = [UIBezierPath bezierPath];
            [bezier140Path moveToPoint: CGPointMake(23.22, 50.98)];
            [bezier140Path addLineToPoint: CGPointMake(23.22, 50.93)];
            [bezier140Path addCurveToPoint: CGPointMake(32.05, 42.18) controlPoint1: CGPointMake(23.22, 46.12) controlPoint2: CGPointMake(26.84, 42.18)];
            [bezier140Path addCurveToPoint: CGPointMake(37.7, 43.89) controlPoint1: CGPointMake(34.59, 42.18) controlPoint2: CGPointMake(36.3, 42.85)];
            [bezier140Path addCurveToPoint: CGPointMake(38.43, 45.37) controlPoint1: CGPointMake(38.09, 44.18) controlPoint2: CGPointMake(38.43, 44.71)];
            [bezier140Path addCurveToPoint: CGPointMake(36.59, 47.18) controlPoint1: CGPointMake(38.43, 46.38) controlPoint2: CGPointMake(37.61, 47.18)];
            [bezier140Path addCurveToPoint: CGPointMake(35.48, 46.82) controlPoint1: CGPointMake(36.08, 47.18) controlPoint2: CGPointMake(35.75, 46.99)];
            [bezier140Path addCurveToPoint: CGPointMake(32.02, 45.61) controlPoint1: CGPointMake(34.44, 46.05) controlPoint2: CGPointMake(33.35, 45.61)];
            [bezier140Path addCurveToPoint: CGPointMake(27.11, 50.88) controlPoint1: CGPointMake(29.17, 45.61) controlPoint2: CGPointMake(27.11, 47.98)];
            [bezier140Path addLineToPoint: CGPointMake(27.11, 50.93)];
            [bezier140Path addCurveToPoint: CGPointMake(32.02, 56.25) controlPoint1: CGPointMake(27.11, 53.83) controlPoint2: CGPointMake(29.12, 56.25)];
            [bezier140Path addCurveToPoint: CGPointMake(35.7, 54.92) controlPoint1: CGPointMake(33.59, 56.25) controlPoint2: CGPointMake(34.63, 55.77)];
            [bezier140Path addCurveToPoint: CGPointMake(36.81, 54.51) controlPoint1: CGPointMake(35.99, 54.68) controlPoint2: CGPointMake(36.37, 54.51)];
            [bezier140Path addCurveToPoint: CGPointMake(38.55, 56.23) controlPoint1: CGPointMake(37.75, 54.51) controlPoint2: CGPointMake(38.55, 55.29)];
            [bezier140Path addCurveToPoint: CGPointMake(37.92, 57.56) controlPoint1: CGPointMake(38.55, 56.81) controlPoint2: CGPointMake(38.26, 57.27)];
            [bezier140Path addCurveToPoint: CGPointMake(31.9, 59.69) controlPoint1: CGPointMake(36.4, 58.89) controlPoint2: CGPointMake(34.61, 59.69)];
            [bezier140Path addCurveToPoint: CGPointMake(23.22, 50.98) controlPoint1: CGPointMake(26.92, 59.69) controlPoint2: CGPointMake(23.22, 55.84)];
            [bezier140Path closePath];
            [color115 setFill];
            [bezier140Path fill];
            
            
            //// Bezier 141 Drawing
            UIBezierPath* bezier141Path = [UIBezierPath bezierPath];
            [bezier141Path moveToPoint: CGPointMake(40.58, 50.98)];
            [bezier141Path addLineToPoint: CGPointMake(40.58, 50.93)];
            [bezier141Path addCurveToPoint: CGPointMake(49.41, 42.18) controlPoint1: CGPointMake(40.58, 46.12) controlPoint2: CGPointMake(44.21, 42.18)];
            [bezier141Path addCurveToPoint: CGPointMake(55.07, 43.89) controlPoint1: CGPointMake(51.95, 42.18) controlPoint2: CGPointMake(53.67, 42.85)];
            [bezier141Path addCurveToPoint: CGPointMake(55.8, 45.37) controlPoint1: CGPointMake(55.46, 44.18) controlPoint2: CGPointMake(55.8, 44.71)];
            [bezier141Path addCurveToPoint: CGPointMake(53.96, 47.18) controlPoint1: CGPointMake(55.8, 46.38) controlPoint2: CGPointMake(54.98, 47.18)];
            [bezier141Path addCurveToPoint: CGPointMake(52.85, 46.82) controlPoint1: CGPointMake(53.45, 47.18) controlPoint2: CGPointMake(53.11, 46.99)];
            [bezier141Path addCurveToPoint: CGPointMake(49.39, 45.61) controlPoint1: CGPointMake(51.81, 46.05) controlPoint2: CGPointMake(50.72, 45.61)];
            [bezier141Path addCurveToPoint: CGPointMake(44.48, 50.88) controlPoint1: CGPointMake(46.54, 45.61) controlPoint2: CGPointMake(44.48, 47.98)];
            [bezier141Path addLineToPoint: CGPointMake(44.48, 50.93)];
            [bezier141Path addCurveToPoint: CGPointMake(49.39, 56.25) controlPoint1: CGPointMake(44.48, 53.83) controlPoint2: CGPointMake(46.49, 56.25)];
            [bezier141Path addCurveToPoint: CGPointMake(53.06, 54.92) controlPoint1: CGPointMake(50.96, 56.25) controlPoint2: CGPointMake(52, 55.77)];
            [bezier141Path addCurveToPoint: CGPointMake(54.18, 54.51) controlPoint1: CGPointMake(53.36, 54.68) controlPoint2: CGPointMake(53.74, 54.51)];
            [bezier141Path addCurveToPoint: CGPointMake(55.92, 56.23) controlPoint1: CGPointMake(55.12, 54.51) controlPoint2: CGPointMake(55.92, 55.29)];
            [bezier141Path addCurveToPoint: CGPointMake(55.29, 57.56) controlPoint1: CGPointMake(55.92, 56.81) controlPoint2: CGPointMake(55.63, 57.27)];
            [bezier141Path addCurveToPoint: CGPointMake(49.27, 59.69) controlPoint1: CGPointMake(53.77, 58.89) controlPoint2: CGPointMake(51.98, 59.69)];
            [bezier141Path addCurveToPoint: CGPointMake(40.58, 50.98) controlPoint1: CGPointMake(44.28, 59.69) controlPoint2: CGPointMake(40.58, 55.84)];
            [bezier141Path closePath];
            [color115 setFill];
            [bezier141Path fill];
        }
            
            
            //// Cleanup
            CGGradientRelease(sVGID_1_);
            CGColorSpaceRelease(colorSpace);

            break;
        case 124:
            //// XmasCT
        {
            //// Bezier 124 Drawing
            UIBezierPath* bezier124Path = [UIBezierPath bezierPath];
            [bezier124Path moveToPoint: CGPointMake(62.86, 27.05)];
            [bezier124Path addLineToPoint: CGPointMake(62.95, 27.05)];
            [bezier124Path addLineToPoint: CGPointMake(62.95, 72.82)];
            [bezier124Path addLineToPoint: CGPointMake(17.31, 72.82)];
            [bezier124Path addLineToPoint: CGPointMake(12.29, 77.87)];
            [bezier124Path addLineToPoint: CGPointMake(68, 77.87)];
            [bezier124Path addLineToPoint: CGPointMake(68, 22)];
            [bezier124Path addLineToPoint: CGPointMake(67.89, 22)];
            [bezier124Path addLineToPoint: CGPointMake(62.86, 27.05)];
            [bezier124Path closePath];
            [color119 setFill];
            [bezier124Path fill];
            
            
            //// Bezier 131 Drawing
            UIBezierPath* bezier131Path = [UIBezierPath bezierPath];
            [bezier131Path moveToPoint: CGPointMake(17.05, 72.82)];
            [bezier131Path addLineToPoint: CGPointMake(17.05, 27.05)];
            [bezier131Path addLineToPoint: CGPointMake(62.73, 27.05)];
            [bezier131Path addLineToPoint: CGPointMake(67.75, 22)];
            [bezier131Path addLineToPoint: CGPointMake(12, 22)];
            [bezier131Path addLineToPoint: CGPointMake(12, 77.87)];
            [bezier131Path addLineToPoint: CGPointMake(12.15, 77.87)];
            [bezier131Path addLineToPoint: CGPointMake(17.18, 72.82)];
            [bezier131Path addLineToPoint: CGPointMake(17.05, 72.82)];
            [bezier131Path closePath];
            [color115 setFill];
            [bezier131Path fill];
            
            
            //// Bezier 132 Drawing
            UIBezierPath* bezier132Path = [UIBezierPath bezierPath];
            [bezier132Path moveToPoint: CGPointMake(24.25, 50.98)];
            [bezier132Path addLineToPoint: CGPointMake(24.25, 50.93)];
            [bezier132Path addCurveToPoint: CGPointMake(33.08, 42.18) controlPoint1: CGPointMake(24.25, 46.12) controlPoint2: CGPointMake(27.88, 42.18)];
            [bezier132Path addCurveToPoint: CGPointMake(38.73, 43.89) controlPoint1: CGPointMake(35.62, 42.18) controlPoint2: CGPointMake(37.33, 42.85)];
            [bezier132Path addCurveToPoint: CGPointMake(39.46, 45.37) controlPoint1: CGPointMake(39.12, 44.18) controlPoint2: CGPointMake(39.46, 44.71)];
            [bezier132Path addCurveToPoint: CGPointMake(37.62, 47.18) controlPoint1: CGPointMake(39.46, 46.38) controlPoint2: CGPointMake(38.64, 47.18)];
            [bezier132Path addCurveToPoint: CGPointMake(36.51, 46.82) controlPoint1: CGPointMake(37.11, 47.18) controlPoint2: CGPointMake(36.78, 46.99)];
            [bezier132Path addCurveToPoint: CGPointMake(33.05, 45.61) controlPoint1: CGPointMake(35.47, 46.05) controlPoint2: CGPointMake(34.38, 45.61)];
            [bezier132Path addCurveToPoint: CGPointMake(28.14, 50.88) controlPoint1: CGPointMake(30.2, 45.61) controlPoint2: CGPointMake(28.14, 47.98)];
            [bezier132Path addLineToPoint: CGPointMake(28.14, 50.93)];
            [bezier132Path addCurveToPoint: CGPointMake(33.05, 56.25) controlPoint1: CGPointMake(28.14, 53.83) controlPoint2: CGPointMake(30.15, 56.25)];
            [bezier132Path addCurveToPoint: CGPointMake(36.73, 54.92) controlPoint1: CGPointMake(34.62, 56.25) controlPoint2: CGPointMake(35.66, 55.77)];
            [bezier132Path addCurveToPoint: CGPointMake(37.84, 54.51) controlPoint1: CGPointMake(37.02, 54.68) controlPoint2: CGPointMake(37.4, 54.51)];
            [bezier132Path addCurveToPoint: CGPointMake(39.58, 56.23) controlPoint1: CGPointMake(38.78, 54.51) controlPoint2: CGPointMake(39.58, 55.29)];
            [bezier132Path addCurveToPoint: CGPointMake(38.95, 57.56) controlPoint1: CGPointMake(39.58, 56.81) controlPoint2: CGPointMake(39.29, 57.27)];
            [bezier132Path addCurveToPoint: CGPointMake(32.93, 59.69) controlPoint1: CGPointMake(37.43, 58.89) controlPoint2: CGPointMake(35.64, 59.69)];
            [bezier132Path addCurveToPoint: CGPointMake(24.25, 50.98) controlPoint1: CGPointMake(27.95, 59.69) controlPoint2: CGPointMake(24.25, 55.84)];
            [bezier132Path closePath];
            [color115 setFill];
            [bezier132Path fill];
            
            
            //// Bezier 133 Drawing
            UIBezierPath* bezier133Path = [UIBezierPath bezierPath];
            [bezier133Path moveToPoint: CGPointMake(46.79, 45.9)];
            [bezier133Path addLineToPoint: CGPointMake(43.21, 45.9)];
            [bezier133Path addCurveToPoint: CGPointMake(41.49, 44.18) controlPoint1: CGPointMake(42.27, 45.9) controlPoint2: CGPointMake(41.49, 45.12)];
            [bezier133Path addCurveToPoint: CGPointMake(43.21, 42.46) controlPoint1: CGPointMake(41.49, 43.24) controlPoint2: CGPointMake(42.27, 42.46)];
            [bezier133Path addLineToPoint: CGPointMake(54.09, 42.46)];
            [bezier133Path addCurveToPoint: CGPointMake(55.81, 44.18) controlPoint1: CGPointMake(55.04, 42.46) controlPoint2: CGPointMake(55.81, 43.24)];
            [bezier133Path addCurveToPoint: CGPointMake(54.09, 45.9) controlPoint1: CGPointMake(55.81, 45.12) controlPoint2: CGPointMake(55.04, 45.9)];
            [bezier133Path addLineToPoint: CGPointMake(50.52, 45.9)];
            [bezier133Path addLineToPoint: CGPointMake(50.52, 57.68)];
            [bezier133Path addCurveToPoint: CGPointMake(48.65, 59.54) controlPoint1: CGPointMake(50.52, 58.72) controlPoint2: CGPointMake(49.69, 59.54)];
            [bezier133Path addCurveToPoint: CGPointMake(46.79, 57.68) controlPoint1: CGPointMake(47.61, 59.54) controlPoint2: CGPointMake(46.79, 58.72)];
            [bezier133Path addLineToPoint: CGPointMake(46.79, 45.9)];
            [bezier133Path closePath];
            [color115 setFill];
            [bezier133Path fill];
        }
            break;
        case 125:
            //// XmasWP
        {
            //// Bezier 134 Drawing
            UIBezierPath* bezier134Path = [UIBezierPath bezierPath];
            [bezier134Path moveToPoint: CGPointMake(62.87, 27.05)];
            [bezier134Path addLineToPoint: CGPointMake(62.95, 27.05)];
            [bezier134Path addLineToPoint: CGPointMake(62.95, 72.79)];
            [bezier134Path addLineToPoint: CGPointMake(17.34, 72.79)];
            [bezier134Path addLineToPoint: CGPointMake(12.32, 77.84)];
            [bezier134Path addLineToPoint: CGPointMake(68, 77.84)];
            [bezier134Path addLineToPoint: CGPointMake(68, 22)];
            [bezier134Path addLineToPoint: CGPointMake(67.89, 22)];
            [bezier134Path addLineToPoint: CGPointMake(62.87, 27.05)];
            [bezier134Path closePath];
            CGContextSaveGState(context);
            [bezier134Path addClip];
            CGContextDrawLinearGradient(context, sVGID_1_,
                                        CGPointMake(12.32, 49.92),
                                        CGPointMake(68, 49.92),
                                        kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            
            
            //// Bezier 135 Drawing
            UIBezierPath* bezier135Path = [UIBezierPath bezierPath];
            [bezier135Path moveToPoint: CGPointMake(17.05, 72.79)];
            [bezier135Path addLineToPoint: CGPointMake(17.05, 27.05)];
            [bezier135Path addLineToPoint: CGPointMake(62.7, 27.05)];
            [bezier135Path addLineToPoint: CGPointMake(67.72, 22)];
            [bezier135Path addLineToPoint: CGPointMake(12, 22)];
            [bezier135Path addLineToPoint: CGPointMake(12, 77.84)];
            [bezier135Path addLineToPoint: CGPointMake(12.15, 77.84)];
            [bezier135Path addLineToPoint: CGPointMake(17.18, 72.79)];
            [bezier135Path addLineToPoint: CGPointMake(17.05, 72.79)];
            [bezier135Path closePath];
            [color115 setFill];
            [bezier135Path fill];
            
            
            //// Bezier 136 Drawing
            UIBezierPath* bezier136Path = [UIBezierPath bezierPath];
            [bezier136Path moveToPoint: CGPointMake(19.43, 44.82)];
            [bezier136Path addCurveToPoint: CGPointMake(19.29, 44.12) controlPoint1: CGPointMake(19.36, 44.6) controlPoint2: CGPointMake(19.29, 44.34)];
            [bezier136Path addCurveToPoint: CGPointMake(21.2, 42.31) controlPoint1: CGPointMake(19.29, 43.08) controlPoint2: CGPointMake(20.16, 42.31)];
            [bezier136Path addCurveToPoint: CGPointMake(23.01, 43.64) controlPoint1: CGPointMake(22.07, 42.31) controlPoint2: CGPointMake(22.77, 42.86)];
            [bezier136Path addLineToPoint: CGPointMake(26.37, 54.01)];
            [bezier136Path addLineToPoint: CGPointMake(29.76, 43.73)];
            [bezier136Path addCurveToPoint: CGPointMake(31.64, 42.26) controlPoint1: CGPointMake(30.05, 42.86) controlPoint2: CGPointMake(30.7, 42.26)];
            [bezier136Path addLineToPoint: CGPointMake(31.93, 42.26)];
            [bezier136Path addCurveToPoint: CGPointMake(33.82, 43.73) controlPoint1: CGPointMake(32.87, 42.26) controlPoint2: CGPointMake(33.53, 42.84)];
            [bezier136Path addLineToPoint: CGPointMake(37.2, 54.01)];
            [bezier136Path addLineToPoint: CGPointMake(40.56, 43.64)];
            [bezier136Path addCurveToPoint: CGPointMake(42.35, 42.31) controlPoint1: CGPointMake(40.8, 42.91) controlPoint2: CGPointMake(41.43, 42.31)];
            [bezier136Path addCurveToPoint: CGPointMake(44.19, 44.1) controlPoint1: CGPointMake(43.37, 42.31) controlPoint2: CGPointMake(44.19, 43.08)];
            [bezier136Path addCurveToPoint: CGPointMake(44.04, 44.82) controlPoint1: CGPointMake(44.19, 44.31) controlPoint2: CGPointMake(44.12, 44.6)];
            [bezier136Path addLineToPoint: CGPointMake(39.3, 58.12)];
            [bezier136Path addCurveToPoint: CGPointMake(37.37, 59.64) controlPoint1: CGPointMake(38.97, 59.06) controlPoint2: CGPointMake(38.26, 59.64)];
            [bezier136Path addLineToPoint: CGPointMake(36.98, 59.64)];
            [bezier136Path addCurveToPoint: CGPointMake(35.07, 58.12) controlPoint1: CGPointMake(36.09, 59.64) controlPoint2: CGPointMake(35.41, 59.08)];
            [bezier136Path addLineToPoint: CGPointMake(31.74, 48.43)];
            [bezier136Path addLineToPoint: CGPointMake(28.4, 58.12)];
            [bezier136Path addCurveToPoint: CGPointMake(26.49, 59.64) controlPoint1: CGPointMake(28.06, 59.08) controlPoint2: CGPointMake(27.39, 59.64)];
            [bezier136Path addLineToPoint: CGPointMake(26.11, 59.64)];
            [bezier136Path addCurveToPoint: CGPointMake(24.17, 58.12) controlPoint1: CGPointMake(25.21, 59.64) controlPoint2: CGPointMake(24.51, 59.06)];
            [bezier136Path addLineToPoint: CGPointMake(19.43, 44.82)];
            [bezier136Path closePath];
            [color115 setFill];
            [bezier136Path fill];
            
            
            //// Bezier 137 Drawing
            UIBezierPath* bezier137Path = [UIBezierPath bezierPath];
            [bezier137Path moveToPoint: CGPointMake(47.04, 44.31)];
            [bezier137Path addCurveToPoint: CGPointMake(48.9, 42.45) controlPoint1: CGPointMake(47.04, 43.27) controlPoint2: CGPointMake(47.86, 42.45)];
            [bezier137Path addLineToPoint: CGPointMake(53.96, 42.45)];
            [bezier137Path addCurveToPoint: CGPointMake(60.43, 48.3) controlPoint1: CGPointMake(57.99, 42.45) controlPoint2: CGPointMake(60.43, 44.85)];
            [bezier137Path addLineToPoint: CGPointMake(60.43, 48.35)];
            [bezier137Path addCurveToPoint: CGPointMake(53.59, 54.3) controlPoint1: CGPointMake(60.43, 52.27) controlPoint2: CGPointMake(57.39, 54.3)];
            [bezier137Path addLineToPoint: CGPointMake(50.76, 54.3)];
            [bezier137Path addLineToPoint: CGPointMake(50.76, 57.66)];
            [bezier137Path addCurveToPoint: CGPointMake(48.9, 59.52) controlPoint1: CGPointMake(50.76, 58.7) controlPoint2: CGPointMake(49.94, 59.52)];
            [bezier137Path addCurveToPoint: CGPointMake(47.04, 57.66) controlPoint1: CGPointMake(47.86, 59.52) controlPoint2: CGPointMake(47.04, 58.7)];
            [bezier137Path addLineToPoint: CGPointMake(47.04, 44.31)];
            [bezier137Path closePath];
            [bezier137Path moveToPoint: CGPointMake(53.71, 50.99)];
            [bezier137Path addCurveToPoint: CGPointMake(56.66, 48.43) controlPoint1: CGPointMake(55.58, 50.99) controlPoint2: CGPointMake(56.66, 49.88)];
            [bezier137Path addLineToPoint: CGPointMake(56.66, 48.38)];
            [bezier137Path addCurveToPoint: CGPointMake(53.64, 45.81) controlPoint1: CGPointMake(56.66, 46.71) controlPoint2: CGPointMake(55.5, 45.81)];
            [bezier137Path addLineToPoint: CGPointMake(50.76, 45.81)];
            [bezier137Path addLineToPoint: CGPointMake(50.76, 50.99)];
            [bezier137Path addLineToPoint: CGPointMake(53.71, 50.99)];
            [bezier137Path addLineToPoint: CGPointMake(53.71, 50.99)];
            [bezier137Path closePath];
            [color115 setFill];
            [bezier137Path fill];
        }
            break;
        case 138:
            //// ChangeShapeSetButton
        {
            //// Bezier 119 Drawing
            UIBezierPath* bezier119Path = [UIBezierPath bezierPath];
            [bezier119Path moveToPoint: CGPointMake(63.45, 16.02)];
            [bezier119Path addCurveToPoint: CGPointMake(63.45, 32.54) controlPoint1: CGPointMake(68.02, 20.58) controlPoint2: CGPointMake(68.02, 27.98)];
            [bezier119Path addCurveToPoint: CGPointMake(46.93, 32.54) controlPoint1: CGPointMake(58.89, 37.1) controlPoint2: CGPointMake(51.5, 37.1)];
            [bezier119Path addCurveToPoint: CGPointMake(46.93, 16.02) controlPoint1: CGPointMake(42.37, 27.98) controlPoint2: CGPointMake(42.37, 20.58)];
            [bezier119Path addCurveToPoint: CGPointMake(63.45, 16.02) controlPoint1: CGPointMake(51.5, 11.46) controlPoint2: CGPointMake(58.89, 11.46)];
            [bezier119Path closePath];
            [color setStroke];
            bezier119Path.lineWidth = 3.32;
            [bezier119Path stroke];
            
            
            //// Bezier 120 Drawing
            UIBezierPath* bezier120Path = [UIBezierPath bezierPath];
            [bezier120Path moveToPoint: CGPointMake(76.2, 34.57)];
            [bezier120Path addLineToPoint: CGPointMake(72.4, 38.19)];
            [bezier120Path addLineToPoint: CGPointMake(69.01, 34.57)];
            [color setStroke];
            bezier120Path.lineWidth = 3.32;
            [bezier120Path stroke];
            
            
            //// Bezier 121 Drawing
            UIBezierPath* bezier121Path = [UIBezierPath bezierPath];
            [bezier121Path moveToPoint: CGPointMake(72.61, 11.81)];
            [bezier121Path addLineToPoint: CGPointMake(72.61, 36.74)];
            [color setStroke];
            bezier121Path.lineWidth = 3.32;
            [bezier121Path stroke];
            
            
            //// Bezier 122 Drawing
            UIBezierPath* bezier122Path = [UIBezierPath bezierPath];
            [bezier122Path moveToPoint: CGPointMake(33.8, 15.43)];
            [bezier122Path addLineToPoint: CGPointMake(37.6, 11.81)];
            [bezier122Path addLineToPoint: CGPointMake(40.99, 15.43)];
            [color setStroke];
            bezier122Path.lineWidth = 3.32;
            [bezier122Path stroke];
            
            
            //// Bezier 123 Drawing
            UIBezierPath* bezier123Path = [UIBezierPath bezierPath];
            [bezier123Path moveToPoint: CGPointMake(37.39, 38.19)];
            [bezier123Path addLineToPoint: CGPointMake(37.39, 13.26)];
            [color setStroke];
            bezier123Path.lineWidth = 3.32;
            [bezier123Path stroke];
        }
            break;
        case 139:
            //// ChangeBackgroundSet
        {
            //// Bezier 125 Drawing
            UIBezierPath* bezier125Path = [UIBezierPath bezierPath];
            [bezier125Path moveToPoint: CGPointMake(54.2, 58.57)];
            [bezier125Path addLineToPoint: CGPointMake(50.4, 62.19)];
            [bezier125Path addLineToPoint: CGPointMake(47.01, 58.57)];
            [color setStroke];
            bezier125Path.lineWidth = 3.32;
            [bezier125Path stroke];
            
            
            //// Bezier 126 Drawing
            UIBezierPath* bezier126Path = [UIBezierPath bezierPath];
            [bezier126Path moveToPoint: CGPointMake(50.61, 35.81)];
            [bezier126Path addLineToPoint: CGPointMake(50.61, 60.74)];
            [color setStroke];
            bezier126Path.lineWidth = 3.32;
            [bezier126Path stroke];
            
            
            //// Bezier 127 Drawing
            UIBezierPath* bezier127Path = [UIBezierPath bezierPath];
            [bezier127Path moveToPoint: CGPointMake(26.8, 39.43)];
            [bezier127Path addLineToPoint: CGPointMake(30.6, 35.81)];
            [bezier127Path addLineToPoint: CGPointMake(33.99, 39.43)];
            [color setStroke];
            bezier127Path.lineWidth = 3.32;
            [bezier127Path stroke];
            
            
            //// Bezier 128 Drawing
            UIBezierPath* bezier128Path = [UIBezierPath bezierPath];
            [bezier128Path moveToPoint: CGPointMake(30.39, 62.19)];
            [bezier128Path addLineToPoint: CGPointMake(30.39, 37.26)];
            [color setStroke];
            bezier128Path.lineWidth = 3.32;
            [bezier128Path stroke];
            
            
            //// Bezier 129 Drawing
            UIBezierPath* bezier129Path = [UIBezierPath bezierPath];
            [bezier129Path moveToPoint: CGPointMake(61.81, 27.29)];
            [bezier129Path addLineToPoint: CGPointMake(61.89, 27.29)];
            [bezier129Path addLineToPoint: CGPointMake(61.89, 72.09)];
            [bezier129Path addLineToPoint: CGPointMake(17.22, 72.09)];
            [bezier129Path addLineToPoint: CGPointMake(12.3, 77.03)];
            [bezier129Path addLineToPoint: CGPointMake(66.83, 77.03)];
            [bezier129Path addLineToPoint: CGPointMake(66.83, 22.34)];
            [bezier129Path addLineToPoint: CGPointMake(66.72, 22.34)];
            [bezier129Path addLineToPoint: CGPointMake(61.81, 27.29)];
            [bezier129Path closePath];
            [color setFill];
            [bezier129Path fill];
            
            
            //// Bezier 130 Drawing
            UIBezierPath* bezier130Path = [UIBezierPath bezierPath];
            [bezier130Path moveToPoint: CGPointMake(17.09, 72.09)];
            [bezier130Path addLineToPoint: CGPointMake(17.09, 27.29)];
            [bezier130Path addLineToPoint: CGPointMake(61.81, 27.29)];
            [bezier130Path addLineToPoint: CGPointMake(66.72, 22.34)];
            [bezier130Path addLineToPoint: CGPointMake(12.15, 22.34)];
            [bezier130Path addLineToPoint: CGPointMake(12.15, 77.03)];
            [bezier130Path addLineToPoint: CGPointMake(12.3, 77.03)];
            [bezier130Path addLineToPoint: CGPointMake(17.22, 72.09)];
            [bezier130Path addLineToPoint: CGPointMake(17.09, 72.09)];
            [bezier130Path closePath];
            [color setFill];
            [bezier130Path fill];
        }
            break;
        default:
            break;
    }
    
    [self setShowsTouchWhenHighlighted:YES];
}

@end
