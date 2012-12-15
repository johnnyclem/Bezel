//
//  bz_ImagePickerViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ImagePickerViewController.h"
#import "UIImage+Resize.h"
#import "UIImage+Storage.h"
#import "YLProgressBar.h"
#define CAMERA_TRANSFORM 1.12412


@interface bz_ImagePickerViewController ()
{
    GPUImageCropFilter  *filter;
    GPUImageView *filterView;
    
    NSTimer *progressTimer;
    YLProgressBar* progressView;
    UILabel*       progressValueLabel;
}

@property (nonatomic) BOOL simulateCamera;

@end

@implementation bz_ImagePickerViewController

@synthesize imagePickerController   = _imagePickerController;
@synthesize overlay                 = _overlay;
@synthesize simulateCamera          = _simulateCamera;
@synthesize stillCamera;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    [self setupCamera];
    
}

- (void)setupCamera {

    _simulateCamera = NO;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        stillCamera = [[GPUImageStillCamera alloc] init];
        stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        
        // Set the capture preset based on the user preference key here
        stillCamera.captureSessionPreset = AVCaptureSessionPreset640x480;
        
        filter = [[GPUImageCropFilter alloc] init];
        [stillCamera addTarget:filter];
        filterView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        
        [filter addTarget:filterView];
        [self.view addSubview:filterView];
        
        [filter setCropRegion:CGRectMake(0, 0, .83660130, .62745098)];

        [stillCamera startCameraCapture];
    } else {
        _simulateCamera = YES;
    }    
}

- (void) takePicture
{
    [self takeSimulatorSafePhoto];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    int quality = [[NSUserDefaults standardUserDefaults] integerForKey:@"photoQuality"];
    UIImage *newImage;
    
    switch (quality) {
        case 0: // User wants highest res image
            newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            break;
        case 1: // User wants 1024x1024 res image
            newImage = [[info objectForKey:UIImagePickerControllerOriginalImage] resizedImage:CGSizeMake(1024.f, 1024.f) interpolationQuality:kCGInterpolationDefault];
            break;
        case 2: // User wants 640x640 res image
            newImage = [[info objectForKey:UIImagePickerControllerOriginalImage] resizedImage:CGSizeMake(640.f, 640.f) interpolationQuality:kCGInterpolationDefault];
            break;
        default:
            break;
    }

    NSDictionary* dict = [NSDictionary dictionaryWithObject:newImage forKey:@"newImageKey"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newImageFromLibrary" object:self userInfo:dict];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePickerController dismissViewControllerAnimated:YES completion:^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelledPicker" object:nil];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"bz_ImagePickerViewController received memory warning");
}


#pragma mark -
#pragma mark - Camera Simulator

-(void)takeSimulatorSafePhoto {

    if (_simulateCamera) {
        UIImage *simulatorImage = [UIImage imageNamed:@"test.jpg"];
        UIImage *thumb = [simulatorImage resizedImage:CGSizeMake(640.f, 640.f) interpolationQuality:kCGInterpolationDefault];
        NSDictionary* dict = [NSDictionary dictionaryWithObject:thumb forKey:@"newImageKey"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newImage" object:self userInfo:dict];
    } else {
        [self capturePhotoFromCamera];
    }
    
}

-(void)capturePhotoFromCamera
{
    [stillCamera capturePhotoAsJPEGProcessedUpToFilter:filter withCompletionHandler:^(NSData *processedImage, NSError *error)
     {
         
         UIImage *thumb      = [[UIImage imageWithData:processedImage] resizedImage:CGSizeMake(640.f, 640.f) interpolationQuality:kCGInterpolationDefault];
         NSDictionary* dict = [NSDictionary dictionaryWithObject:thumb forKey:@"newImageKey"];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"newImage" object:self userInfo:dict];

     }];

}

@end
