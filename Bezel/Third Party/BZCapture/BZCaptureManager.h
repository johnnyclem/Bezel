//
//  BZCaptureManager.h
//  BZCapture
//
//  Created by Josh Buchacher on 12/20/12.
//  Copyright (c) 2012 jbuchacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface BZCaptureManager : NSObject

/********************************************************************************
 ** Enums and Typedefs used for convenience
 *******************************************************************************/
typedef enum {
    BZCaptureTypeAudio,
    BZCaptureTypePhoto,
    BZCaptureTypeVideo
} BZCaptureType;

typedef enum {
    BZCaptureQualityLow,
    BZCaptureQualityMedium,
    BZCaptureQualityHigh,
    BZCaptureQualityOriginal,
} BZCaptureQuality;

typedef void (^BZCaptureManagerSuccessBlock)(id obj);
typedef void (^BZCaptureManagerFailureBlock)(NSError *err);

/********************************************************************************
 ** Block based callbacks for media capture success/failure.
 ** - Can be called on a background thread
 ** - All operations that require being called on the main thread should take 
 **     this into account and be handled explicitly.
 *******************************************************************************/
@property (nonatomic, copy) BZCaptureManagerSuccessBlock successBlock;
@property (nonatomic, copy) BZCaptureManagerFailureBlock failureBlock;


/********************************************************************************
 ** AVFoundation related properties, used primarily for convenience.
 *******************************************************************************/
// Represents the current capture session that is reused
@property (strong, nonatomic, readonly) AVCaptureSession *currentSession;


/********************************************************************************
 ** User Interface related properties, used by view controllers to specify
 ** which views should be used for previewing capture input, etc.
 *******************************************************************************/
@property (weak, nonatomic, readonly) AVCaptureVideoPreviewLayer *previewLayer;


/******************************************************************************** 
 ** Camera/Audio Inputs
 *******************************************************************************/
@property (strong, nonatomic, readonly) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic, readonly) AVCaptureDeviceInput *audioInput;


/********************************************************************************
 ** Camera/Audio Outputs
 *******************************************************************************/
@property (strong, nonatomic, readonly) AVCaptureStillImageOutput *stillImageOutput;


/********************************************************************************
 ** Camera capture settings
 *******************************************************************************/
@property (nonatomic, assign) BZCaptureQuality captureQuality;


/********************************************************************************
 ** Camera/device-related convenience
 *******************************************************************************/
@property (nonatomic, assign) AVCaptureVideoOrientation currentOrientation;

- (NSArray *) availableDevices;
- (AVCaptureDevice *) audioDevice;
- (AVCaptureDevice *) frontFacingCamera;
- (AVCaptureDevice *) backFacingCamera;
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position;
- (NSUInteger) cameraCount;
- (NSUInteger) micCount;

/********************************************************************************
 ** Flash/Torch Setters/Getters
 *******************************************************************************/
- (BOOL) cameraFlashAvailable;
- (AVCaptureFlashMode) flashMode;
- (AVCaptureTorchMode) torchMode;
- (void) setFlashMode:(AVCaptureFlashMode)mode;
- (void) setTorchMode:(AVCaptureTorchMode)mode;

/********************************************************************************
 ** Focus Mode / Focus at Point
 *******************************************************************************/
- (AVCaptureFocusMode) focusMode;
- (void) setFocusMode:(AVCaptureFocusMode)mode;
- (void) focusAtPoint:(CGPoint)focusPoint;
- (void) focusAtPoint:(CGPoint)focusPoint withFocusMode:(AVCaptureFocusMode)focusMode;

/********************************************************************************
 ** Media capture and control methods
 *******************************************************************************/
- (void) captureMediaWithType: (BZCaptureType)captureType
                 successBlock: (BZCaptureManagerSuccessBlock)success
                 failureBlock: (BZCaptureManagerFailureBlock)failure;
- (BOOL) toggleCamera;
- (void) setPreviewLayerWithView:(UIView *)view;

/********************************************************************************
 ** Miscellaneous
 *******************************************************************************/
+ (id)sharedManager;


@end