//
//  BZCaptureManager.m
//  BZCapture
//
//  Created by Josh Buchacher on 12/20/12.
//  Copyright (c) 2012 jbuchacher. All rights reserved.
//

#import "BZCaptureManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

#pragma mark - Private Properties / Methods
@interface BZCaptureManager()
@property (strong, nonatomic) AVCaptureSession *currentSession;
@property (weak, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureDeviceInput *audioInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@end

@implementation BZCaptureManager

#pragma mark - Media Capture and Control Methods

- (void)captureMediaWithType: (BZCaptureType)captureType
                successBlock: (BZCaptureManagerSuccessBlock)success
                failureBlock: (BZCaptureManagerFailureBlock)failure
{
    switch (captureType) {
        case BZCaptureTypeAudio:
        {
            [self captureAudioWithSuccess: success failure: failure];
        }
            break;
        case BZCaptureTypePhoto:
        {
            [self capturePhotoWithSuccess: success failure: failure];
        }
            break;
        case BZCaptureTypeVideo:
        {
            [self captureVideoWithSuccess: success failure: failure];
        }
            break;
        default:
        {
            NSError *err; // Did not specify type
            @throw err;
        }
            break;
    }
}

- (void)capturePhotoWithSuccess: (BZCaptureManagerSuccessBlock)success
                        failure: (BZCaptureManagerFailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    AVCaptureConnection *stillImageConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self stillImageOutput] connections]];
    
    [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:stillImageConnection
                                                         completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
     {
         if (imageDataSampleBuffer != NULL)
         {
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
             UIImage *image = [[UIImage alloc] initWithData:imageData];
             self.successBlock(image);
         }
     }];
    
}

- (void)captureVideoWithSuccess: (BZCaptureManagerSuccessBlock)success
                        failure: (BZCaptureManagerFailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    
}

- (void)captureAudioWithSuccess: (BZCaptureManagerSuccessBlock)success
                        failure: (BZCaptureManagerFailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    
}

- (BOOL) toggleCamera
{
    BOOL success = NO;
    
    if ([self cameraCount] > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [self.videoInput.device position];
        
        if (position == AVCaptureDevicePositionBack)
        {
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontFacingCamera] error:&error];
        }
        else if (position == AVCaptureDevicePositionFront)
        {
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backFacingCamera] error:&error];
        }
        else
        {
            //bad!
        }
        
        if (newVideoInput != nil)
        {
            [self _removeInput: self.videoInput];
            [self _addInput: newVideoInput];
            self.videoInput = newVideoInput;
            success = YES;
        }
        else if (error)
        {
            
        }
    }
    
    return success;
}

- (void) setPreviewLayerWithView:(UIView *)view
{
    if (view)
    {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession: self.currentSession];
        [self.previewLayer setFrame: view.bounds];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [view.layer setMasksToBounds:YES];
        [view.layer addSublayer: self.previewLayer];
    }
    else
    {
        [self.previewLayer removeFromSuperlayer];
    }
}

#pragma mark - Session Management
- (void)_startRunning
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.currentSession startRunning];
    });
}

- (void)_stopRunning
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.currentSession stopRunning];
    });
}

#pragma mark - Device Input Managment
- (void)_addInput:(AVCaptureDeviceInput *)input
{
    [self.currentSession beginConfiguration];
    if ([self.currentSession canAddInput: input]) {
        [self.currentSession addInput: input];
    }
    [self.currentSession commitConfiguration];

    LogTrace(@"Input: %@ added to current session: %@", input, self.currentSession);
}

- (void)_removeInput:(AVCaptureDeviceInput *)input
{
    [self.currentSession beginConfiguration];
    if ([[self.currentSession inputs] containsObject: input]) {
        [self.currentSession removeInput:input];
    }
    [self.currentSession commitConfiguration];
    
    LogTrace(@"Input: %@ removed from current session: %@", input, self.currentSession);
}

#pragma mark - Device Output Managment

- (void)_addOutput:(AVCaptureOutput *)output
{
    [self.currentSession beginConfiguration];
    if ([self.currentSession canAddOutput: output]) {
        [self.currentSession addOutput: output];
    }
    [self.currentSession commitConfiguration];
    LogTrace(@"Output: %@ added to current session: %@", output, self.currentSession);
}

- (void)_removeOutput:(AVCaptureOutput *)output
{
    [self.currentSession beginConfiguration];
    if ([[self.currentSession outputs] containsObject: output]) {
        [self.currentSession removeOutput: output];
    }
    [self.currentSession commitConfiguration];
    LogTrace(@"Output: %@ removed from current session: %@", output, self.currentSession);
}

- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections
{
	for ( AVCaptureConnection *connection in connections ) {
		for ( AVCaptureInputPort *port in [connection inputPorts] ) {
			if ( [[port mediaType] isEqual:mediaType] ) {
				return connection;
			}
		}
	}
	return nil;
}

#pragma mark - Camera/device-related convenience

- (NSArray *)availableDevices
{
    return [AVCaptureDevice devices];;
}

- (AVCaptureDevice *) audioDevice
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    if ([devices count] > 0) {
        return [devices objectAtIndex:0];
    }
    return nil;
}

- (AVCaptureDevice *) frontFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *) backFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType: AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (NSUInteger) cameraCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}

- (NSUInteger) micCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] count];
}

#pragma mark - Flash / Torch Related

- (BOOL) cameraFlashAvailable
{
    BOOL success = NO;
    
    return success;
}

- (AVCaptureFlashMode) flashMode
{
    return self.videoInput.device.flashMode;
}
- (AVCaptureTorchMode) torchMode
{
    return self.videoInput.device.torchMode;
}

- (void) setFlashMode:(AVCaptureFlashMode)mode
{
    AVCaptureDevice *curDevice = self.videoInput.device;
    
	if ([curDevice hasFlash]) {
		if ([curDevice lockForConfiguration:nil]) {
			if ([curDevice isFlashModeSupported: mode]) {
				[curDevice setFlashMode: mode];
			}
			[curDevice unlockForConfiguration];
		}
    }
}

- (void) setTorchMode:(AVCaptureTorchMode)mode
{
    AVCaptureDevice *curDevice = self.videoInput.device;
    
	if ([curDevice hasTorch]) {
		if ([curDevice lockForConfiguration:nil]) {
			if ([curDevice isTorchModeSupported: mode]) {
				[curDevice setTorchMode: mode];
			}
			[curDevice unlockForConfiguration];
		}
    }
}

#pragma mark - Focus Mode / Focus at Point

- (AVCaptureFocusMode) focusMode
{
    return self.videoInput.device.focusMode;
}

- (void) setFocusMode:(AVCaptureFocusMode)mode
{
    AVCaptureDevice *curDevice = self.videoInput.device;
    
    if ([curDevice lockForConfiguration:nil]) {
        if ([curDevice isFocusModeSupported: mode]) {
            [curDevice setFocusMode: mode];
        }
        [curDevice unlockForConfiguration];
    }
}

- (void) focusAtPoint:(CGPoint)focusPoint
{
    AVCaptureDevice *curDevice = self.videoInput.device;
    if ([curDevice isFocusPointOfInterestSupported])
    {
        NSError *error;
        if ([curDevice lockForConfiguration:&error])
        {
            [curDevice setFocusPointOfInterest: focusPoint];
            [curDevice unlockForConfiguration];
        }
        else
        {
            // Failure to set focal point.
        }
    }
}

- (void) focusAtPoint:(CGPoint)focusPoint withFocusMode:(AVCaptureFocusMode)focusMode
{
    AVCaptureDevice *curDevice = self.videoInput.device;
    if ([curDevice isFocusPointOfInterestSupported] && [curDevice isFocusModeSupported: focusMode])
    {
        NSError *error;
        if ([curDevice lockForConfiguration:&error])
        {
            [curDevice setFocusPointOfInterest: focusPoint];
            [curDevice setFocusMode: focusMode];
            [curDevice unlockForConfiguration];
        }
        else
        {
            // Failure to set focal point.
        }
    }
}

# pragma mark - Initialization / Memory Management

- (id)init
{
    NSError *error;
    if (self = [super init])
    {        
        // Setup the still image file output
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        
        // Initialization of required components.
        self.currentSession = [[AVCaptureSession alloc] init];
        
        // Set the quality of the session -- this should be changed based on the BZCaptureQuality setting
        self.currentSession.sessionPreset = AVCaptureSessionPresetPhoto;

        // Start the session then add the devices
        [self _startRunning];

        // Init the device inputs
        self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backFacingCamera] error:&error];
        self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self audioDevice] error:&error];

        NSArray *inputs = [NSArray arrayWithObjects: self.videoInput, self.audioInput, nil];
        for (AVCaptureDeviceInput *input in inputs) {
            [self _addInput: input];
        }
        
        NSArray *outputs = [NSArray arrayWithObjects: self.stillImageOutput, nil];
        for (AVCaptureOutput *output in outputs) {
            [self _addOutput: output];
        }
        
    }
    
    return self;
}

+ (id)sharedManager
{
    static id singleton = nil;
    static dispatch_once_t pred;
    
    dispatch_once(
                  &pred,
                  ^{ singleton = [[self alloc] init]; }
                  );
    
    return singleton;
}

@end
