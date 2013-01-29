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
}

@property (strong, nonatomic) UIDocumentInteractionController *docController;
@property (strong, nonatomic) ALAssetsLibrary* library;

@property (strong, nonatomic) bz_ScrollViewController *scrollViewController;
@property (strong, nonatomic) BZAdjustmentProcessor *adjustmentProcessor;
@property (strong, nonatomic) bz_ConfirmView *confirmView;

@end

@implementation bz_MainViewController

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
    self.imageCanvas.contentMode = UIViewContentModeScaleAspectFit;
    
//    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(handlePinch:)];
//    pinchGesture.delegate = self;
//    [self.imageCanvas addGestureRecognizer: pinchGesture];
//    self.imageCanvas.userInteractionEnabled = TRUE;
    
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
        bz_TutorialViewController *tutorialView = [[bz_TutorialViewController alloc] init];
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
    
//    // Default to square mask around preview image.
//    BZMaskAdjustment *maskAdjustment = [[BZMaskAdjustment alloc] init];
//    maskAdjustment.identifier = kAdjustmentTypeMask;
//    maskAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: kButtonIdentifierSquareMask, kButtonIdentifier, nil];
//    [self.session addAdjustment: maskAdjustment];
//    
//    self.cameraPreview.layer.mask = [maskAdjustment layerMaskForSize: kDefaultCameraPreviewSize];
//    self.imageCanvas.layer.mask = [maskAdjustment layerMaskForSize: kDefaultCameraPreviewSize];
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
            
            __weak bz_MainViewController *weakSelf = self;
            
            self.confirmView.completionBlock = ^(BOOL response)
            {
                if (response == TRUE)
                {
                    [weakSelf.session setThumbnailImage: thumb];
                    [weakSelf.session setFullResolutionImage: img];
                    
                    weakSelf.imageCanvas.layer.mask = nil;
                    weakSelf.imageCanvas.image = [weakSelf.adjustmentProcessor processedThumbnailImage];
                    
                    [weakSelf.scrollViewController scrollToViewControllerAtIndex: 1];
                    
                    [weakSelf setupFilterThumbnails];
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

#pragma mark - Adjustments

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

-(void)switchShape:(BZMaskAdjustment *)adj
{
    adj.identifier = kAdjustmentTypeMask;
    
    [self.session addAdjustment: adj];
    
    self.cameraPreview.layer.mask = [adj layerMaskForSize: self.cameraPreview.frame.size];
    self.imageCanvas.layer.mask = [adj layerMaskForSize: self.cameraPreview.frame.size];

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

-(void)applyFilter:(bz_Button *)filterButton
{
    BZFilterAdjustment *filterAdjustment = [[BZFilterAdjustment alloc] init];
    filterAdjustment.identifier = kAdjustmentTypeFilter;
    filterAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: filterButton.buttonIdentifier, kButtonIdentifier, nil];
    
    // set the preview layer mask to the adjusted mask.
    self.imageCanvas.image = [filterAdjustment filteredImageWithImage: [self.adjustmentProcessor processedThumbnailImage]];

    __weak bz_MainViewController *weakSelf = self;
    self.confirmView.completionBlock = ^(BOOL response)
    {
        if (response == TRUE)
        {
            [weakSelf.session addAdjustment: filterAdjustment];
            [weakSelf.scrollViewController scrollToViewControllerAtIndex:2];
        }
        else
        {
            weakSelf.imageCanvas.image = [weakSelf.adjustmentProcessor processedThumbnailImage];
        }
    };
    
    [self.confirmView presentConfirmationFromEdge: CGRectMinYEdge forViewController: self];
}

#pragma mark - jclem adjustImage
- (void)adjustImage:(bz_Button *)adjustmentButton
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

-(IBAction)importFromLibrary:(id)sender
{
    [self stopUpdatingPreviewLayer];
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


#pragma mark - Sharing

- (void)sharePhoto:(bz_Button *)button
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

#pragma mark - In-App Purchases / Store

-(IBAction)openStoreView:(id)sender {
    bz_StoreViewController *storeVC = [[bz_StoreViewController alloc] initWithNibName:@"bz_StoreView" bundle:nil];
    [self presentViewController:storeVC animated:YES completion:nil];
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

#pragma mark - Image Picker Delegate (Library Importing)

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    __block UIImage *fullRes;
    __block UIImage *thumb;
    __weak bz_MainViewController *weakSelf = self;
    
    self.confirmView.completionBlock = ^(BOOL response)
    {
        if (response == TRUE)
        {
            [weakSelf.session setFullResolutionImage:fullRes];
            
            weakSelf.imageCanvas.layer.mask = nil;
            weakSelf.imageCanvas.image = [weakSelf.adjustmentProcessor processedThumbnailImage];
            
            [weakSelf.scrollViewController scrollToViewControllerAtIndex: 1];
            
            [weakSelf setupFilterThumbnails];
        }
        else
        {
            [weakSelf startUpdatingPreviewLayer];
            weakSelf.imageCanvas.layer.mask = nil;
            weakSelf.imageCanvas.image = nil;
            weakSelf.imageCanvas.hidden = TRUE;
        }
    };
    
    [imagePickerController dismissViewControllerAnimated:YES completion:^(void){
        
        fullRes = [info objectForKey:UIImagePickerControllerEditedImage];
        thumb   = [UIImage scaleImage: fullRes
                               toSize: kDefaultThumbnailSize];
        
        [[weakSelf session] setThumbnailImage: thumb];
        [[weakSelf imageCanvas] setHidden:FALSE];
        [[[weakSelf imageCanvas] layer] setMask:[(BZMaskAdjustment *)[self.session adjustmentWithIdentifier: kAdjustmentTypeMask] layerMaskForSize: kDefaultCameraPreviewSize]];
        [[weakSelf imageCanvas] setImage:thumb];
        [[weakSelf confirmView] presentConfirmationFromEdge: CGRectMaxYEdge forViewController: self];
        
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

- (void)setUpDefaults
{
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    holidayPackIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_HOLIDAY_PACK_PURCHASE_KEY] boolValue];
    proShapePackIsPurchased  = [(NSNumber*)[standard objectForKey: BZ_PRO_SHAPE_PACK_PURCHASE_KEY] boolValue];
    colorPickerIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_COLOR_PICKER_PURCHASE_KEY] boolValue];
}

- (void)setUpButtonTargets
{
    __weak id weakSelf = self;
    
    [self.scrollViewController.shapesViewController.takePhotoButton addTarget: self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.scrollViewController.shapesViewController.switchShapeBlock = ^(BZMaskAdjustment *adj)
    {
        [weakSelf switchShape: adj];
    };
    
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
    
    // Sharing
    for (bz_Button *button in self.scrollViewController.shareViewController.shareButtons)
    {
        [button addTarget: self action:@selector(sharePhoto:) forControlEvents: UIControlEventTouchUpInside];
    }
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

- (NSString *)applicationDocumentsDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self; //_sharedContainer;
}

@end
