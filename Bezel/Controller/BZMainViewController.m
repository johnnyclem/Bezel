//
//  BZMainViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <Accounts/Accounts.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Social/Social.h>

// View controllers
#import "BZMainViewController.h"
#import "BZTutorialViewController.h"
#import "BZCaptureViewController.h"
#import "BZShapesViewController.h"
#import "BZFiltersAdjustmentsController.h"
#import "BZBackgroundViewController.h"
#import "BZShareViewController.h"

// View related
#import "SVProgressHUD.h"
#import "HMSegmentedControl.h"
#import "UIImage+Utils.h"
#import "UIImage+Resize.h"
#import "UIImage+Storage.h"
#import "BZTabBarController.h"
#import "BZImageView.h"
#import "BZConfirmView.h"

// Capturing
#import "BZCaptureManager.h"
#import "BZSession.h"

// Adjustments
#import "BZAdjustmentProcessor.h"
#import "BZBackgroundAdjustment.h"
#import "BZBrightnessContrastAdjustment.h"
#import "BZFilterAdjustment.h"
#import "BZMaskAdjustment.h"
//#import "BZScaleAdjustment.h"

@interface BZMainViewController ()

@property (weak, nonatomic) IBOutlet BZTabBarController *tabBarController;
@property (weak, nonatomic) BZCaptureViewController *captureViewController;
@property (weak, nonatomic) BZShapesViewController *shapesViewController;
@property (weak, nonatomic) BZFiltersAdjustmentsController *filterViewController;
@property (weak, nonatomic) BZBackgroundViewController *backgroundViewController;
@property (weak, nonatomic) BZShareViewController *shareViewController;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIDocumentInteractionController *docController;
@property (strong, nonatomic) ALAssetsLibrary* library;

@property (strong, nonatomic) BZSession *session;
@property (strong, nonatomic) BZAdjustmentProcessor *adjustmentProcessor;

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) BZConfirmView *confirmView;

@property (weak, nonatomic) IBOutlet UIView *cameraPreview;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet BZImageView *imageCanvas;

@end

@implementation BZMainViewController

#define kDefaultCameraPreviewSize CGSizeMake(320.0, 320.0)
#define kDefaultThumbnailSize CGSizeMake(640.0, 640.0)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController = [self.childViewControllers objectAtIndex:0];
    
    self.captureViewController = [self.tabBarController.viewControllers objectAtIndex: BZ_CAPTURE_VIEW_CONTROLLER_INDEX];
    self.shapesViewController = [self.tabBarController.viewControllers objectAtIndex: BZ_SHAPES_VIEW_CONTROLLER_INDEX];
    self.filterViewController = [self.tabBarController.viewControllers objectAtIndex: BZ_FILTERS_ADJUSTMENTS_VIEW_CONTROLLER_INDEX];
    self.backgroundViewController = [self.tabBarController.viewControllers objectAtIndex: BZ_BACKGROUNDS_VIEW_CONTROLLER_INDEX];
    self.shareViewController = [self.tabBarController.viewControllers objectAtIndex: BZ_SHARE_VIEW_CONTROLLER_INDEX];

    // Used for blocks
    __weak BZMainViewController *weakSelf = self;
    
    // Initialization
    self.session = [[BZSession alloc] init];
    self.library = [[ALAssetsLibrary alloc] init];
    self.confirmView = [[BZConfirmView alloc] init];
    self.adjustmentProcessor = [[BZAdjustmentProcessor alloc] initWithSession: self.session];
    
    NSArray *icons = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"Capture"],
                      [UIImage imageNamed:@"Shapes"],
                      [UIImage imageNamed:@"Filters"],
                      [UIImage imageNamed:@"Backgrounds"],
                      [UIImage imageNamed:@"Share"], nil];
    
    NSArray *selectedIcons = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"Capture-selected"],
                              [UIImage imageNamed:@"Shapes-selected"],
                              [UIImage imageNamed:@"Filters-selected"],
                              [UIImage imageNamed:@"Backgrounds-selected"],
                              [UIImage imageNamed:@"Share-selected"], nil];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionIcons: icons highlight: selectedIcons];
    self.segmentedControl.textColor = [UIColor whiteColor];
    self.segmentedControl.backgroundColor = [UIColor blackColor];
    self.segmentedControl.frame = CGRectMake(0, 0, 320, 60);
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"selecting index %d", index);
        UITabBarController *tc = [weakSelf.childViewControllers objectAtIndex:0];
        
        UIView * fromView = tc.selectedViewController.view;
        UIView * toView = [[tc.viewControllers objectAtIndex:index] view];
        
        CGRect viewSize = fromView.frame;
        BOOL scrollRight = index > tc.selectedIndex;
        
        [fromView.superview addSubview:toView];
        toView.frame = CGRectMake((scrollRight ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
        
        [UIView animateWithDuration:0.3
                         animations: ^{
                             fromView.frame =CGRectMake((scrollRight ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
                             toView.frame =CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [fromView removeFromSuperview];
                                 tc.selectedIndex = index;
                             }
                         }];
    }];
    
    [self.view addSubview: self.segmentedControl];
    
    // View defaults
    self.cameraPreview.clipsToBounds = YES;
    self.imageCanvas.clipsToBounds = YES;
    self.imageCanvas.contentMode = UIViewContentModeScaleAspectFit;
    
//    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(handlePinch:)];
//    pinchGesture.delegate = self;
//    [self.imageCanvas addGestureRecognizer: pinchGesture];
//    self.imageCanvas.userInteractionEnabled = TRUE;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self setUpButtonTargets];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:BZ_SETTINGS_FIRST_LAUNCH_KEY] == FALSE)
    {
        // If there isn't currently an image, setup the camera. Otherwise, get confirmation from user.
        if (!self.session.thumbnailImage || !self.session.fullResolutionImage)
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [self setupCamera];
            }
            else
            {
                // We should inform the user to import at this point: or set the imageCanvas image to
                // an informative image.
            }
        }
        else
        {
            self.imageCanvas.image = self.session.thumbnailImage;
        }
    }
    else
    {
        BZTutorialViewController *tutorialView = [[BZTutorialViewController alloc] init];
        [self presentViewController:tutorialView animated:YES completion:^(void)
        {
            [defaults setBool: FALSE forKey: BZ_SETTINGS_FIRST_LAUNCH_KEY];
            [defaults synchronize];
            LogTrace(@"%@", [defaults boolForKey: BZ_SETTINGS_FIRST_LAUNCH_KEY] ? @"FIRST LAUNCH." : @"NOT FIRST LAUNCH.");
        }];
    }
}

#pragma mark -
#pragma mark Camera methods

-(void)setupCamera
{
    self.imageCanvas.hidden = TRUE;

    [self startUpdatingPreviewLayer];
}

- (void)startUpdatingPreviewLayer
{
    [[BZCaptureManager sharedManager] performSelectorInBackground:@selector(setPreviewLayerWithView:) withObject: self.cameraPreview];
    self.cameraPreview.hidden = FALSE;
}

- (void)stopUpdatingPreviewLayer
{
    [[BZCaptureManager sharedManager] setPreviewLayerWithView: nil];
    self.cameraPreview.hidden = TRUE;
}

-(void)takePhoto
{
    [SVProgressHUD showWithStatus:@"Saving Image"];
    
    void (^successBlock)(id obj) = ^(id obj)
    {
        if ([obj isKindOfClass:[UIImage class]])
        {
            UIImage *img = (UIImage *)obj;
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            
            if ([df boolForKey:BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY] == TRUE)
            {
                int quality = [df integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY];
                LogInfo(@"Image quality is set to: %i", quality);
                
                CGSize outputSize;
                switch (quality)
                {
                    case 2: // User wants highest res image
                        outputSize = CGSizeMake(2048, 2048);
                        break;
                    case 1: // User wants 1024x1024 res image
                        outputSize = CGSizeMake(1024, 1024);
                        break;
                    case 0: // User wants 640x640 res image
                        outputSize = CGSizeMake(640, 640);
                        break;
                    default:
                        break;
                }
                
                // Scale down per user's settings.
                img = [UIImage scaleImage: img toSize: outputSize];
                
                [self.library writeImageToSavedPhotosAlbum: [img CGImage] orientation: img.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
                    if (error!=nil)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Image" message:@"Bezel encountered an error while attempting to save image to Photo Library.  Please try saving again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                }];
            }
            
            UIImage *thumb = [UIImage scaleImage: img toSize: kDefaultThumbnailSize];
            
            [self stopUpdatingPreviewLayer];
            
            self.imageCanvas.hidden = FALSE;
            
            self.imageCanvas.layer.mask = [(BZMaskAdjustment *)[self.session adjustmentWithIdentifier: kAdjustmentTypeMask] layerMaskForSize: kDefaultCameraPreviewSize];
            self.imageCanvas.image = thumb;
            
            __weak BZMainViewController *weakSelf = self;
            
            self.confirmView.completionBlock = ^(BOOL response)
            {
                if (response == TRUE)
                {
                    [weakSelf.session setThumbnailImage: thumb];
                    [weakSelf.session setFullResolutionImage: img];
                    
                    weakSelf.imageCanvas.layer.mask = nil;
                    weakSelf.imageCanvas.image = [weakSelf.adjustmentProcessor processedThumbnailImage];
                }
                else
                {
                    [weakSelf startUpdatingPreviewLayer];
                    weakSelf.imageCanvas.layer.mask = nil;
                    weakSelf.imageCanvas.image = nil;
                    weakSelf.imageCanvas.hidden = TRUE;
                }
            };
            
            [SVProgressHUD dismiss];
            [self.confirmView presentConfirmationFromEdge: CGRectMaxYEdge forViewController: self];
        }
    };
    
    void (^failureBlock)(NSError *err) = ^(NSError *err)
    {
        LogError(@"Failed to take photo.");
    };
    
    [self stopUpdatingPreviewLayer];
    [[BZCaptureManager sharedManager] captureMediaWithType: BZCaptureTypePhoto
                                              successBlock: successBlock
                                              failureBlock: failureBlock];
}

-(void)switchCamera
{
    LogTrace(@"Switching camera");
    [[BZCaptureManager sharedManager] toggleCamera];
}

-(void)toggleFlash
{
    switch ([[BZCaptureManager sharedManager] flashMode]) {
        case AVCaptureFlashModeAuto:
        {
            
        }
            
            break;
        case AVCaptureFlashModeOff:
        {
            
        }
            break;
        case AVCaptureFlashModeOn:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - Shapes

-(void)switchShape:(BZMaskAdjustment *)adj
{
//    [self presentCameraControls];
    
    adj.identifier = kAdjustmentTypeMask;
    
    [self.session addAdjustment: adj];
    
    self.cameraPreview.layer.mask = [adj layerMaskForSize: self.cameraPreview.frame.size];
    self.imageCanvas.layer.mask = [adj layerMaskForSize: self.cameraPreview.frame.size];
    
    self.imageCanvas.image = [self.adjustmentProcessor processedThumbnailImage];
}

#pragma mark - Adjustments

-(void)switchBackground:(BZButton *)button
{    
    BZBackgroundAdjustment *backgroundAdjustment = [[BZBackgroundAdjustment alloc] init];

    NSString *value = button.buttonIdentifier;
    
    if ([value isEqualToString: kButtonIdentifierBlackBackground])
    {
        backgroundAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys:
                                      button.buttonIdentifier, kButtonIdentifier,
                                      [UIColor blackColor], kAdjustmentTypeBackgroundColor, nil];
        backgroundAdjustment.identifier = kAdjustmentTypeBackgroundColor;
    }
    else if ([value isEqualToString: kButtonIdentifierWhiteBackground])
    {
        backgroundAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys:
                                      button.buttonIdentifier, kButtonIdentifier,
                                      [UIColor whiteColor], kAdjustmentTypeBackgroundColor, nil];
        backgroundAdjustment.identifier = kAdjustmentTypeBackgroundColor;
    }
    else if ([value isEqualToString: kButtonIdentifierClearBackground])
    {
        backgroundAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys:
                                      button.buttonIdentifier, kButtonIdentifier,
                                      [UIColor clearColor], kAdjustmentTypeBackgroundColor, nil];
        backgroundAdjustment.identifier = kAdjustmentTypeBackgroundColor;
    }
    else
    {
        // Haven't implemented background images yet.
    }
    
    [self.session addAdjustment: backgroundAdjustment];

    self.imageCanvas.image = [self.adjustmentProcessor processedThumbnailImage];
}

#pragma mark - jclem Pinch Handling
//#pragma mark - UIGestureRecognizer Pinch Handling
//- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
//{
//    BZScaleAdjustment *scaleAdj = [[BZScaleAdjustment alloc] init];
//    scaleAdj.value = [NSDictionary dictionaryWithObjectsAndKeys:
//                      [NSNumber numberWithFloat: recognizer.scale], kAdjustmentTypeScale, nil];
//
//    [self.session addAdjustment: scaleAdj];
//
//    self.imageCanvas.image = [self.adjustmentProcessor processedThumbnailImage];
//
//    recognizer.scale = 1.0;
//}

-(void)applyFilter:(BZButton *)filterButton
{
    BZFilterAdjustment *filterAdjustment = [[BZFilterAdjustment alloc] init];
    filterAdjustment.identifier = kAdjustmentTypeFilter;
    filterAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: filterButton.buttonIdentifier, kButtonIdentifier, nil];
    
    // set the preview layer mask to the adjusted mask.
    self.imageCanvas.image = [filterAdjustment filteredImageWithImage: [self.adjustmentProcessor processedThumbnailImage]];

    __weak BZMainViewController *weakSelf = self;
    self.confirmView.completionBlock = ^(BOOL response)
    {
        if (response == TRUE)
        {
            [weakSelf.session addAdjustment: filterAdjustment];
        }
        else
        {
            weakSelf.imageCanvas.image = [weakSelf.adjustmentProcessor processedThumbnailImage];
        }
    };
    
    [self.confirmView presentConfirmationFromEdge: CGRectMinYEdge forViewController: self];
}

#pragma mark - jclem adjustImage
- (void)adjustImage:(BZButton *)adjustmentButton
{
    float exposure;
    float contrast;
    
    BZAdjustment *adj = [self.session adjustmentWithIdentifier: kAdjustmentTypeBrightnessOrContrast];
    
    if (adj)
    {
        exposure = [[adj.value valueForKey: kAdjustmentTypeBrightness] floatValue];
        contrast = [[adj.value valueForKey: kAdjustmentTypeContrast] floatValue];
        
        if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierBrightnessUp])
        {
            exposure += kExposureDefaultStep;
        }
        else if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierBrightnessDown])
        {
            exposure -= kExposureDefaultStep;
        }
        else if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierContrastUp])
        {
            contrast += kContrastDefaultStep;
        }
        else if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierContrastDown])
        {
            contrast -= kContrastDefaultStep;
        }
    } else {
        exposure = 0.f;
        contrast = 1.f;
    }

    BZBrightnessContrastAdjustment *brightnessContrastAdjustment = [[BZBrightnessContrastAdjustment alloc] init];
    brightnessContrastAdjustment.identifier = kAdjustmentTypeBrightnessOrContrast;
    brightnessContrastAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys:
                                          kAdjustmentTypeBrightnessOrContrast, kButtonIdentifier,
                                          [NSNumber numberWithFloat: exposure], kAdjustmentTypeBrightness,
                                          [NSNumber numberWithFloat: contrast], kAdjustmentTypeContrast, nil];
    
    NSLog(@"adjusting contrast and exposure to %f and %f", contrast, exposure);
    [self.session addAdjustment: brightnessContrastAdjustment];
    
    // set the preview layer mask to the adjusted mask.
    self.imageCanvas.image = [self.adjustmentProcessor processedThumbnailImage];
}

- (void)undoLastAdjustment
{
    // TODO finish undo
    [self.session removeAdjustment: [self.session.adjustments lastObject]];
}

#pragma mark - Importing

- (void)importFromLibrary
{
    [self stopUpdatingPreviewLayer];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController.allowsEditing = YES;
    _imagePickerController.delegate = self;
    
    [self presentViewController: _imagePickerController animated:YES completion:nil];
}


#pragma mark - Sharing

- (void)sharePhoto:(BZButton *)button
{
    NSString *type = button.buttonIdentifier;
    // Delete photo. Shouldn't be here but not worrying about it right now.
    if ([type isEqualToString: kButtonIdentifierTrash])
    {
        [self deletePhoto];
    }
    
    UIImage *image = [self.adjustmentProcessor processedFullResolutionImage];
    
    [SVProgressHUD showWithStatus:@"Saving Image"];
    
    if ([type isEqualToString: kButtonIdentifierCameraRoll])
    {
        [self.library writeImageToSavedPhotosAlbum: image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error)
        {
            if (error!=nil)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Image" message:@"Bezel encountered an error while attempting to save image to Photo Library.  Please try saving again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [SVProgressHUD dismiss];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Image was saved successfully to your Photo Library" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Start Over", nil];
                alert.tag = 30;
                alert.delegate = self;
                [SVProgressHUD dismiss];
                [alert show];
            }
        }];
    }
    else if ([type isEqualToString: kButtonIdentifierInstagram])
    {
        NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
        {
            NSString *documentsDirectory    = [self applicationDocumentsDirectory];
            NSString *savedImagePath        = [documentsDirectory stringByAppendingPathComponent:@"image.igo"];
            
            // Set processed image here.
            UIImage *img = [self.adjustmentProcessor processedFullResolutionImage];
            NSData   *imageData             = UIImageJPEGRepresentation(img, 0.85);
            
            [imageData writeToFile:savedImagePath atomically:YES];
            NSURL    *imageURL              = [NSURL fileURLWithPath:savedImagePath];
            _docController                   = [[UIDocumentInteractionController alloc] init];
            _docController.delegate          = self;
            _docController.UTI               = @"com.instagram.exclusivegram";
            _docController.URL               = imageURL;
            [_docController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
            
        }
        else
        {
            LogError(@"Instagram not available.");
            UIAlertView *instagramError     = [[UIAlertView alloc] initWithTitle:@"Instagram not available" message:@"To share photos to Instagram, you first need to install Instagram on your iOS device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [instagramError show];
        }
    }
    else
    {
        NSString *svcType;
        if ([type isEqualToString: kButtonIdentifierFacebook]) svcType = SLServiceTypeFacebook;
        else if ([type isEqualToString: kButtonIdentifierTwitter]) svcType = SLServiceTypeTwitter;
        else LogError(@"Share type not provided!");
        
        if ([SLComposeViewController isAvailableForServiceType: svcType])
        {
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType: svcType];
            
            SLComposeViewControllerCompletionHandler completion = ^(SLComposeViewControllerResult result)
            {
                if (result == SLComposeViewControllerResultCancelled)
                {    
                    LogTrace(@"%@ sharing cancelled.", svcType);
                }
                else
                {
                    LogTrace(@"%@ sharing completed successfully", svcType);
                }
                
                [controller dismissViewControllerAnimated:YES completion:Nil];    
            };
            
            controller.completionHandler = completion;
            
            [controller setInitialText:@"Created with Bezel for iOS"];
            [controller addURL: [NSURL URLWithString:@"http://minddiaper.com/bezel"]];
            [controller addImage: image];
            
            [self presentViewController:controller animated:YES completion:Nil];
            
        }
        else
        {
            LogError(@"Facebook Unavailable");
        }
    }
}

- (void)deletePhoto {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Discard Photo?" message:@"Do you really want to discard this photo and lose any unsaved changes?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Discard Photo", nil];
    alert.tag = 10;
    [alert show];
}

- (void)savedSuccessfully {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Photo Saved" message:@"Photo was successfully saved to your camera roll" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = 20;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 10:
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Discard Photo"])
            {
                self.session = nil;
                self.session = [[BZSession alloc] init];
                
                self.adjustmentProcessor = nil;
                self.adjustmentProcessor = [[BZAdjustmentProcessor alloc] initWithSession: self.session];
                
                [self startUpdatingPreviewLayer];
            }
            break;
        case 20:
            break;
        case 30:
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Start Over"])
            {
                self.session = nil;
                self.session = [[BZSession alloc] init];
                [self startUpdatingPreviewLayer];
            }
            break;
        case 50:
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"No Thanks"])
            {
                //TODO
            }
            break;
        default:
            break;
    }
}

#pragma mark - Image Picker Delegate (Library Importing)

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    __block UIImage *fullRes;
    __block UIImage *thumb;
    __weak BZMainViewController *weakSelf = self;
    
    self.confirmView.completionBlock = ^(BOOL response)
    {
        if (response == TRUE)
        {
            [weakSelf.session setFullResolutionImage:fullRes];
            
            weakSelf.imageCanvas.layer.mask = nil;
            weakSelf.imageCanvas.image = [weakSelf.adjustmentProcessor processedThumbnailImage];
        }
        else
        {
            [weakSelf startUpdatingPreviewLayer];
            weakSelf.imageCanvas.layer.mask = nil;
            weakSelf.imageCanvas.image = nil;
            weakSelf.imageCanvas.hidden = TRUE;
        }
    };
    
    [_imagePickerController dismissViewControllerAnimated:YES completion:^(void){
        
        fullRes = [info objectForKey:UIImagePickerControllerEditedImage];
        thumb   = [UIImage scaleImage: fullRes
                               toSize: kDefaultThumbnailSize];
        
        weakSelf.session.thumbnailImage = thumb;
        weakSelf.imageCanvas.hidden = FALSE;
        weakSelf.imageCanvas.image = thumb;
        weakSelf.imageCanvas.layer.mask = [(BZMaskAdjustment *)[self.session adjustmentWithIdentifier: kAdjustmentTypeMask] layerMaskForSize: kDefaultCameraPreviewSize];
        
        [weakSelf.confirmView presentConfirmationFromEdge: CGRectMaxYEdge forViewController: self];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    __weak id weakSelf = self;
    [self dismissViewControllerAnimated:TRUE completion:^(void)
    {
        [weakSelf startUpdatingPreviewLayer];
    }];
}

#pragma mark - Convenience

- (void)setUpButtonTargets
{
    __weak id weakSelf = self;
    
    [self.captureViewController.shootPhotoButton addTarget: self action: @selector(takePhoto) forControlEvents: UIControlEventTouchUpInside];
    [self.captureViewController.switchCameraButton addTarget: self action: @selector(switchCamera) forControlEvents: UIControlEventTouchUpInside];
    [self.captureViewController.importButton addTarget: self action: @selector(importFromLibrary) forControlEvents: UIControlEventTouchUpInside];
    
    self.shapesViewController.switchShapeBlock = ^(BZMaskAdjustment *adj)
    {
        [weakSelf switchShape: adj];
    };
    
//    // Filters
//    for (BZButton *button in self.scrollViewController.filterViewController.filterButtons)
//    {
//        [button addTarget:self action:@selector(applyFilter:) forControlEvents: UIControlEventTouchUpInside];
////    }
//    
//    // Adjustments
//    for (BZButton *button in self.filterViewController.adjustmentButtons)
//    {
//        [button addTarget: self action:@selector(adjustImage:) forControlEvents: UIControlEventTouchUpInside];
//    }
//    
    // Backgrounds
    for (BZButton *button in self.backgroundViewController.backgroundButtons)
    {
        [button addTarget: self action:@selector(switchBackground:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    // Sharing
    for (BZButton *button in self.shareViewController.shareButtons)
    {
        [button addTarget: self action:@selector(sharePhoto:) forControlEvents: UIControlEventTouchUpInside];
    }
}

- (NSString *)applicationDocumentsDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self; //_sharedContainer;
}

@end
