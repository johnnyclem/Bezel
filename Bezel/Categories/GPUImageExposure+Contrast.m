//
//  GPUImageExposure+Contrast.m
//  Loupe
//
//  Created by John Clem on 11/5/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "GPUImageExposure+Contrast.h"

NSString *const kGPUImageCustomColorFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate; 
 uniform sampler2D inputImageTexture;
 
 uniform lowp float contrast;
 uniform lowp float exposure;
 
 void main()
 {
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     lowp vec4 exposed = vec4(textureColor.rgb * pow(2.0, exposure), textureColor.w);
     gl_FragColor = vec4(((exposed.rgb - vec3(0.5)) * contrast + vec3(0.5)), exposed.w);
     
 }
 
 );

@implementation GPUImageExposure_Contrast

@synthesize contrast = _contrast;
@synthesize exposure = _exposure;

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageCustomColorFragmentShaderString]))
    {
        return nil;
    }
    
    contrastUniform = [filterProgram uniformIndex:@"contrast"];
    self.contrast = 1.0;
    exposureUniform = [filterProgram uniformIndex:@"exposure"];
    self.exposure = 0.0;
    
    return self;
}

- (id)initWithContrast:(CGFloat)contrast andExposure:(CGFloat)exposure {
    
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageCustomColorFragmentShaderString]))
    {
        return nil;
    }
    
    contrastUniform = [filterProgram uniformIndex:@"contrast"];
    self.contrast = contrast;
    exposureUniform = [filterProgram uniformIndex:@"exposure"];
    self.exposure = exposure;
    
    return self;

}

#pragma mark -
#pragma mark Accessors

- (CGFloat)getContrast:(CGFloat)contrast
{
    return _contrast;
}

- (CGFloat)getExposure:(CGFloat)exposure
{
    return _exposure;
}

- (void)setContrast:(CGFloat)newValue;
{
    _contrast = newValue;
    
    [GPUImageOpenGLESContext useImageProcessingContext];
    [filterProgram use];
    glUniform1f(contrastUniform, _contrast);
}

- (void)setExposure:(CGFloat)newValue;
{
    _exposure = newValue;
    
    [GPUImageOpenGLESContext useImageProcessingContext];
    [filterProgram use];
    glUniform1f(exposureUniform, _exposure);
}


@end
