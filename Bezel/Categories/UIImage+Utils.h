//
//  UIImage+Utils.h
//  Loupe
//
//  Created by John Clem on 11/5/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
+ (UIImage *)imageWithColor:(UIColor *)color atSize:(CGSize)size;
+ (UIImage*)loadImageFromDocs:(NSString *)fileName;
+ (void)saveImage:(UIImage*)image ToDocs:(NSString *)fileName;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)targetSize;

@end
