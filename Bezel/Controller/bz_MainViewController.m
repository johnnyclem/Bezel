//
//  bz_MainViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <Accounts/Accounts.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Social/Social.h>

// View controllers
#import "bz_MainViewController.h"
#import "bz_StoreViewController.h"
#import "bz_MaskShapeLayer.h"
#import "bz_ScrollViewController.h"
#import "bz_TutorialViewController.h"

// View related
#import "UIImage+Utils.h"
#import "UIImage+Resize.h"
#import "UIImage+Storage.h"
#import "bz_ImageView.h"
#import "bz_ConfirmView.h"
#import "SVProgressHUD.h"

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

@interface bz_MainViewController ()
{
    UIImagePickerController *imagePickerController;
    
    BOOL colorPickerIsPurchased;
    BOOL holidayPackIsPurchased;
    BOOL proShapePackIsPurchased;
    BOOL keepPhoto;
}

@property (strong, nonatomic) UIDocumentInteractionController *docController;
@property (strong, nonatomic) ALAssetsLibrary* library;

@property (strong, nonatomic) bz_ScrollViewController *scrollViewController;
@property (strong, nonatomic) BZAdjustmentProcessor *adjustmentProcessor;
@property (strong, nonatomic) bz_ConfirmView *confirmView;

@property (assign, nonatomic) BOOL useLibrary;

@end


@implementation bz_MainViewController

@synthesize useLibrary;

#define kDefaultCameraPreviewSize CGSizeMake(320.0, 320.0)
#define kDefaultThumbnailSize CGSizeMake(640.0, 640.0)

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialization
    self.session = [[BZSession alloc] init];
    self.library = [[ALAssetsLibrary alloc] init];
    self.confirmView = [[bz_ConfirmView alloc] init];
    self.adjustmentProcessor = [[BZAdjustmentProcessor alloc] initWithSession: self.session];
    
    // Set up NSUserDefaults values
    [self setUpDefaults];
    
    // Set up scroll view
    self.scrollViewController = [[bz_ScrollViewController alloc] init];
    [self.scrollViewController setupScrollViewChildren];
    [self.view addSubview: self.scrollViewController.scrollView];
    
    // View defaults
    self.cameraPreview.clipsToBounds = YES;
    self.imageCanvas.clipsToBounds = YES;
    
//    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(handlePinch:)];
//    pinchGesture.delegate = self;
//    [self.imageCanvas addGestureRecognizer: pinchGesture];
//    self.imageCanvas.userInteractionEnabled = TRUE;
    
    self.imageCanvas.contentMode = UIViewContentModeCenter;
    
    [self setUpButtonTargets];
}

- (void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];

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
                useLibrary = YES;
            }
        }
        else
        {
            self.imageCanvas.image = self.session.thumbnailImage;
        }
    }
    else
    {
        bz_TutorialViewController *tutorialView = [[bz_TutorialViewController alloc] init];
        [self presentViewController:tutorialView animated:YES completion:^(void)
        {
            [defaults setBool: FALSE forKey: BZ_SETTINGS_FIRST_LAUNCH_KEY];
            [defaults synchronize];
            LogTrace(@"%@", [defaults boolForKey: BZ_SETTINGS_FIRST_LAUNCH_KEY] ? @"FIRST LAUNCH." : @"NOT FIRST LAUNCH.");
        }];
    }
}

- (void)setUpDefaults
{
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    holidayPackIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_HOLIDAY_PACK_PURCHASE_KEY] boolValue];
    proShapePackIsPurchased  = [(NSNumber*)[standard objectForKey: BZ_PRO_SHAPE_PACK_PURCHASE_KEY] boolValue];
    colorPickerIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_COLOR_PICKER_PURCHASE_KEY] boolValue];
}

- (void)setUpButtonTargets
{
    [self.scrollViewController.shapesViewController.takePhotoButton addTarget: self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    // Shape masks
    for (bz_Button *button in self.scrollViewController.shapesViewController.shapeButtons)
    {
        [button addTarget: self action: @selector(switchShape:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    // Filters
    for (bz_Button *button in self.scrollViewController.filterViewController.filterButtons)
    {
        [button addTarget:self action:@selector(applyFilter:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    // Adjustments
    for (bz_Button *button in self.scrollViewController.adjustmentViewController.adjustmentButtons)
    {
        [button addTarget: self action:@selector(adjustImage:) forControlEvents: UIControlEventTouchUpInside];
    } 
    
    // Backgrounds
    for (bz_Button *button in self.scrollViewController.backgroundViewController.backgroundButtons)
    {
        [button addTarget: self action:@selector(switchBackground:) forControlEvents: UIControlEventTouchUpInside];
    }
}

#pragma mark -
#pragma mark Camera methods

-(void)setupCamera
{
    self.imageCanvas.hidden = TRUE;
    
    [self startUpdatingPreviewLayer];
    
    // Default to square mask around preview image.
    BZMaskAdjustment *maskAdjustment = [[BZMaskAdjustment alloc] init];
    maskAdjustment.identifier = kAdjustmentTypeMask;
    maskAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: kButtonIdentifierSquareMask, kButtonIdentifier, nil];
    [self.session addAdjustment: maskAdjustment];
    
    self.cameraPreview.layer.mask = [maskAdjustment layerMaskForSize: kDefaultCameraPreviewSize];
    self.imageCanvas.layer.mask = [maskAdjustment layerMaskForSize: kDefaultCameraPreviewSize];
}

- (void)startUpdatingPreviewLayer
{
    [[BZCaptureManager sharedManager] setPreviewLayerWithView: self.cameraPreview];
    self.cameraPreview.hidden = FALSE;
}

- (void)stopUpdatingPreviewLayer
{
    [[BZCaptureManager sharedManager] setPreviewLayerWithView: nil];
    self.cameraPreview.hidden = TRUE;
}

-(IBAction)importFromLibrary:(id)sender
{    
    [self stopUpdatingPreviewLayer];

    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;

    [self presentViewController:imagePickerController animated:YES completion:nil];
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
            
            UIImage *thumb   = [UIImage scaleImage: img toSize: kDefaultThumbnailSize];
            
            [self stopUpdatingPreviewLayer];
            
            self.imageCanvas.hidden = FALSE;
            self.imageCanvas.image = thumb;
            
            __weak id weakSelf = self;
            
            self.confirmView.completionBlock = ^(BOOL response)
            {
                if (response == TRUE)
                {
                    [self.session setThumbnailImage: thumb];
                    [self.session setFullResolutionImage: img];
                    
                    [self.scrollViewController scrollToViewControllerAtIndex: 1];
                    
                    [weakSelf setupFilterThumbnails];
                }
                else
                {
                    [weakSelf startUpdatingPreviewLayer];
                    self.imageCanvas.image = nil;
                    self.imageCanvas.hidden = TRUE;
                }
            };
            
            [SVProgressHUD dismiss];
            [self.confirmView presentConfirmationFromEdge: CGRectMaxYEdge forViewController: self];
        }
    };
    
    void (^failureBlock)(NSError *err) = ^(NSError *err)
    {
        
    };
    
    [self stopUpdatingPreviewLayer];
    [[BZCaptureManager sharedManager] captureMediaWithType: BZCaptureTypePhoto
                                              successBlock: successBlock
                                              failureBlock: failureBlock];
}

-(void)switchCamera {
    LogTrace(@"switching camera");
    [[BZCaptureManager sharedManager] toggleCamera];
}

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


-(void)switchBackground:(bz_Button *)button
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

-(void)switchShape:(bz_Button *)button
{
    BZMaskAdjustment *maskAdjustment = [[BZMaskAdjustment alloc] init];
    maskAdjustment.identifier = kAdjustmentTypeMask;
    maskAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: button.buttonIdentifier, kButtonIdentifier, nil];
    
    [self.session addAdjustment: maskAdjustment];
    
    self.cameraPreview.layer.mask = [maskAdjustment layerMaskForSize: self.cameraPreview.frame.size];
    self.imageCanvas.layer.mask = [maskAdjustment layerMaskForSize: self.imageCanvas.frame.size];
}

- (void)undoLastAdjustment
{
    // TODO finish undo
    [self.session removeAdjustment: [self.session.adjustments lastObject]];
}

- (void)buyHolidayPack {
    UIAlertView *buyHolidayPack = [[UIAlertView alloc] initWithTitle:@"Buy Holiday Pack?" message:@"The Candy Cane, Christmas Tree and Xmas Wallpaper backgrounds are part of the Bezel Holiday Pack. You can unlock all 3 holiday shapes and 3 holiday backgrounds in the Bezel Store" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Go To Store", nil];
    buyHolidayPack.tag = 50;
    [buyHolidayPack show];
}

- (void)buyColorPicker {
    UIAlertView *buyColorPicker = [[UIAlertView alloc] initWithTitle:@"Buy Color Picker?" message:@"You must purchase the Bezel Color Picker to unlock this feature.  You can purchase the color picker to enable any background color in the Bezel Store" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Go To Store", nil];
    buyColorPicker.tag = 50;
    [buyColorPicker show];
}

-(void)applyFilter:(bz_Button *)filterButton
{
    BZFilterAdjustment *filterAdjustment = [[BZFilterAdjustment alloc] init];
    filterAdjustment.identifier = kAdjustmentTypeFilter;
    filterAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: filterButton.buttonIdentifier, kButtonIdentifier, nil];
    
    // set the preview layer mask to the adjusted mask.
    self.imageCanvas.image = [filterAdjustment filteredImageWithImage: self.session.thumbnailImage];

    self.confirmView.completionBlock = ^(BOOL response)
    {
        if (response == TRUE)
        {
            [self.session addAdjustment: filterAdjustment];
            [self.scrollViewController scrollToViewControllerAtIndex:2];
        }
        else
        {
            self.imageCanvas.image = [self.adjustmentProcessor processedThumbnailImage];
        }
    };
    
    [self.confirmView presentConfirmationFromEdge: CGRectMinYEdge forViewController: self];
}

- (void)adjustImage:(bz_Button *)adjustmentButton
{
    float exposure = 1.0;
    float contrast = 1.0;
    
    BZAdjustment *adj = [self.session adjustmentWithIdentifier: kAdjustmentTypeBrightnessOrContrast];
    
    if (adj)
    {
        if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierBrightnessUp])
        {
            exposure = [[adj.value valueForKey: kAdjustmentTypeBrightness] floatValue] + kExposureDefaultStep;
            contrast = [[adj.value valueForKey: kAdjustmentTypeContrast] floatValue];
        }
        else if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierBrightnessDown])
        {
            exposure = [[adj.value valueForKey: kAdjustmentTypeBrightness] floatValue] - kExposureDefaultStep;
        }
        else if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierContrastUp])
        {
            contrast = [[adj.value valueForKey: kAdjustmentTypeContrast] floatValue] + kContrastDefaultStep;
        }
        else if ([adjustmentButton.buttonIdentifier isEqualToString: kButtonIdentifierContrastDown])
        {
            contrast = [[adj.value valueForKey: kAdjustmentTypeContrast] floatValue] - kContrastDefaultStep;
        }
    }

    BZBrightnessContrastAdjustment *brightnessContrastAdjustment = [[BZBrightnessContrastAdjustment alloc] init];
    brightnessContrastAdjustment.identifier = kAdjustmentTypeBrightnessOrContrast;
    brightnessContrastAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys:
                                          adjustmentButton.buttonIdentifier, kButtonIdentifier,
                                          [NSNumber numberWithFloat: exposure], kAdjustmentTypeBrightness,
                                          [NSNumber numberWithFloat: contrast], kAdjustmentTypeContrast, nil];
    
    [self.session addAdjustment: brightnessContrastAdjustment];
    
    // set the preview layer mask to the adjusted mask.
    self.imageCanvas.image = [self.adjustmentProcessor processedThumbnailImage];
}

-(void)setupFilterThumbnails
{
    UIImage *currentThumb = self.session.thumbnailImage;
    for (bz_Button *button in self.scrollViewController.filterViewController.filterButtons)
    {
        BZFilterAdjustment *filterAdjustment = [[BZFilterAdjustment alloc] init];
        filterAdjustment.identifier = button.buttonIdentifier;
        filterAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: button.buttonIdentifier, kButtonIdentifier, nil];
        
        // set the preview layer mask to the adjusted mask.
        button.imageView.image = [filterAdjustment filteredImageWithImage: currentThumb];
    }
}

#pragma mark -
#pragma mark - sharing services

- (void)sharePhoto:(NSNotification*)notification {
    
//    // Need to add code here to run the higher-resolution image through the filter chain if not using the "Low" quality setting
//    UIImage *highRes = [self scaleImage:self.session.fullResolutionImage toSize:imgSize];
//    self.currentImage = highRes;
    
    int i = [(NSNumber*)[notification.userInfo objectForKey:@"sharePhotoTag"] intValue];
    switch (i) {
        case 26:
            [self shareToFacebook];
            break;
        case 27:
            [self shareToTwitter];
            break;
        case 28:
            [self shareToInstagram];
            break;
        case 29:
            [self saveToCameraRoll];
            break;
        case 30:
            [self deletePhoto];
            break;
        default:
            break;
    }
    
}

- (void)saveToCameraRoll
{    
    UIImage *curImg = [self.adjustmentProcessor processedFullResolutionImage];
    
    [SVProgressHUD showWithStatus:@"Saving Image"];
    [self.library writeImageToSavedPhotosAlbum: curImg.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error!=nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Image" message:@"Bezel encountered an error while attempting to save image to Photo Library.  Please try saving again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 0;
            [SVProgressHUD dismiss];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Image was saved successfully to your Photo Library" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Start Over", nil];
            alert.tag = 30;
            alert.delegate = self;
            [SVProgressHUD dismiss];
            [alert show];
        }
    }];
    
}

- (void)deletePhoto {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Discard Photo?" message:@"Do you really want to discard this photo and lose any unsaved changes?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Discard Photo", nil];
    alert.tag = 10;
    [alert show];
}

- (void)shareToFacebook {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                LogTrace(@"Facebook sharing cancelled.");
                
            } else
                
            {
                LogTrace(@"Facebook sharing Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        [controller setInitialText:@"Created with Bezel for iOS"];
        [controller addURL:[NSURL URLWithString:@"http://minddiaper.com/bezel"]];

        // Set processed image here.
//        [controller addImage:self.currentImage];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        LogError(@"Facebook Unavailable");
    }
}

- (void)shareToTwitter {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                LogTrace(@"Twitter sharing cancelled");
                
            } else
                
            {
                LogTrace(@"Twitter sharing done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        [controller setInitialText:@"Created with Bezel for iOS"];
        [controller addURL:[NSURL URLWithString:@"http://minddiaper.com/bezel"]];

        // Set processed image here.
        //        [controller addImage:self.currentImage];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        LogError(@"Twitter sharing unavailable");
    }
    
}

- (void)shareToInstagram {
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        NSString *documentsDirectory    = [self applicationDocumentsDirectory];
        NSString *savedImagePath        = [documentsDirectory stringByAppendingPathComponent:@"image.igo"];
        
        // Set processed image here.
        UIImage *img = self.session.thumbnailImage;
        NSData   *imageData             = UIImageJPEGRepresentation(img, 0.85);
        
        [imageData writeToFile:savedImagePath atomically:YES];
        NSURL    *imageURL              = [NSURL fileURLWithPath:savedImagePath];
        _docController                   = [[UIDocumentInteractionController alloc] init];
        _docController.delegate          = self;
        _docController.UTI               = @"com.instagram.exclusivegram";
        _docController.URL               = imageURL;
        [_docController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
        //        [docController presentOpenInMenuFromRect:self.view.frame inView:_sharedContainer.view animated:YES];
    } else {
        LogError(@"Instagram not available.");
        UIAlertView *instagramError     = [[UIAlertView alloc] initWithTitle:@"Instagram not available" message:@"To share photos to Instagram, you first need to install Instagram on your iOS device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [instagramError show];
    }
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
                [self.scrollViewController scrollToViewControllerAtIndex: 0];
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
                [self.scrollViewController scrollToViewControllerAtIndex: 0];
                [self startUpdatingPreviewLayer];
            }
            break;
        case 50:
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"No Thanks"])
            {
                //TODO
                
            }
            else if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Go To Store"])
            {
                
                [self openStoreView:nil];
                
            }
            break;
        default:
            break;
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

-(IBAction)openStoreView:(id)sender {
    bz_StoreViewController *storeVC = [[bz_StoreViewController alloc] initWithNibName:@"bz_StoreView" bundle:nil];
    [self presentViewController:storeVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark - Library Import

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *fullRes = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *thumb   = [UIImage scaleImage: fullRes
                                    toSize: kDefaultThumbnailSize];
    
    [self stopUpdatingPreviewLayer];
    
    self.imageCanvas.hidden = FALSE;
    self.imageCanvas.image = thumb;
    
    __weak id weakSelf = self;
    
    self.confirmView.completionBlock = ^(BOOL response)
    {
        if (response == TRUE)
        {
            [self.session setThumbnailImage: thumb];
            [self.session setFullResolutionImage: fullRes];
            
            [self.scrollViewController scrollToViewControllerAtIndex: 1];
            
            [weakSelf setupFilterThumbnails];
        }
        else
        {
            [weakSelf startUpdatingPreviewLayer];
            self.imageCanvas.image = nil;
            self.imageCanvas.hidden = TRUE;
        }
    };
    
    [SVProgressHUD dismiss];
    [self.confirmView presentConfirmationFromEdge: CGRectMaxYEdge forViewController: self];
    
    [imagePickerController.view removeFromSuperview];
    imagePickerController = nil;    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    __weak id weakSelf = self;
    [self dismissViewControllerAnimated:TRUE completion:^(void)
    {
        [weakSelf startUpdatingPreviewLayer];
    }];
}

@end
