//
//  GPUImageExposure+Contrast.h
//  Loupe
//
//  Created by John Clem on 11/5/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "GPUImageFilter.h"

@interface GPUImageExposure_Contrast : GPUImageFilter
{

    GLint contrastUniform;
    GLint exposureUniform;
    
}

@property(readwrite, nonatomic) CGFloat contrast;
@property(readwrite, nonatomic) CGFloat exposure;

- (id)initWithContrast:(CGFloat)contrast andExposure:(CGFloat)exposure;

@end
