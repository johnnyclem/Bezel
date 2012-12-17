//
//  bz_CaptureManager.m
//  Bezel
//
//  Created by Josh Buchacher on 12/16/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_CaptureManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation bz_CaptureManager

- (id)init
{
    if (self = [super init])
    {
        // Setup the still image file output
        AVCaptureStillImageOutput *newStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        AVVideoCodecJPEG, AVVideoCodecKey,
                                        nil];
        [newStillImageOutput setOutputSettings:outputSettings];
        
        
        // Create session (use default AVCaptureSessionPresetHigh)
        AVCaptureSession *newCaptureSession = [[AVCaptureSession alloc] init];
        
        if ([newCaptureSession canAddOutput:newStillImageOutput]) {
            [newCaptureSession addOutput:newStillImageOutput];
        }
    }
    
    return self;
}

-(void)takePicture
{
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType: AVMediaTypeVideo];
    if ([stillImageConnection isVideoOrientationSupported])
        [stillImageConnection setVideoOrientation: AVCaptureVideoOrientationPortrait];
    
    [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:stillImageConnection
                                                         completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
															 
															 ALAssetsLibraryWriteImageCompletionBlock completionBlock = ^(NSURL *assetURL, NSError *error) {
																 if (error) {
                                                                     
                                                                 }
															 };
															 
															 if (imageDataSampleBuffer != NULL) {
																 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
																 ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
																 
                                                                 UIImage *image = [[UIImage alloc] initWithData:imageData];
																 [library writeImageToSavedPhotosAlbum:[image CGImage]
																						   orientation:(ALAssetOrientation)[image imageOrientation]
																					   completionBlock:completionBlock];
															 }
															 else
																 completionBlock(nil, error);
                                                             
                                                             //handle success
                                                         }];
}

@end
