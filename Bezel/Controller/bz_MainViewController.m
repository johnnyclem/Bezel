//
//  bz_MainViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_MainViewController.h"
#import "bz_StoreViewController.h"
#import "bz_MaskShapeLayer.h"
#import "bz_ScrollViewController.h"
#import "bz_TutorialViewController.h"
#import "UIImage+Utils.h"
#import "UIImage+Resize.h"
#import "UIImage+Storage.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "SVProgressHUD.h"
#import "BZCaptureManager.h"
#import "BZSession.h"

#import "BZMaskAdjustment.h"
#import "BZFilterAdjustment.h"
#import "BZAdjustmentProcessor.h"

#import "bz_ImageView.h"
#import "bz_ConfirmView.h"

@interface bz_MainViewController ()
{
    IBOutlet bz_Button *cart;
    IBOutlet bz_Button *gallery;
    IBOutlet bz_Button *settings;

    UIImagePickerController *imagePickerController;
    
    BOOL colorPickerIsPurchased;
    BOOL holidayPackIsPurchased;
    BOOL proShapePackIsPurchased;
    BOOL keepPhoto;
}
@property (strong, nonatomic) bz_ScrollViewController *scrollViewController;
@property (strong, nonatomic) UIDocumentInteractionController *docController;
@property (strong, nonatomic) bz_ConfirmView *confirmView;
@property (strong, nonatomic) ALAssetsLibrary* library;
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
    
    // Set up NSUserDefaults values
    [self setUpDefaults];
    
    // Set up scroll view
    self.scrollViewController = [[bz_ScrollViewController alloc] init];
    [self.scrollViewController setupScrollViewChildren];
    [self.view addSubview: self.scrollViewController.scrollView];
    
    [self.confirmView presentConfirmationFromEdge: CGRectMinYEdge forViewController: self];
    
    // Use library if camera is *not* available.
    useLibrary = ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];

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
    
    // Backgrounds
}

#pragma mark -
#pragma mark Camera methods

-(void)setupCamera
{
    [[BZCaptureManager sharedManager] setPreviewLayerWithView: self.cameraPreview];
    
    // Default to square mask around preview image.
    BZMaskAdjustment *maskAdjustment = [[BZMaskAdjustment alloc] init];
    maskAdjustment.identifier = kButtonIdentifierSquareMask;
    maskAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: kButtonIdentifierSquareMask, kButtonIdentifier, nil];
    [self.session addAdjustment: maskAdjustment];
    
    self.cameraPreview.layer.mask = [maskAdjustment layerMaskForSize: kDefaultCameraPreviewSize];
}

- (void)stopUpdatingPreviewLayer
{
    [[BZCaptureManager sharedManager] setPreviewLayerWithView: nil];
}

-(IBAction)importFromLibrary:(id)sender
{    
    [self stopUpdatingPreviewLayer];
    
    useLibrary = YES;
    
    [imagePickerController.view removeFromSuperview];
    imagePickerController = nil;
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;

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
            
            [self.session setThumbnailImage: thumb];
            [self.session setFullResolutionImage: img];
            
            [self processNewImage];
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

-(void)addBackground:(NSNotification*)notification
{    
//    [self.sessionPreview.layer setMask:nil];
//
//    _bgColor = [notification.userInfo objectForKey:@"newBGColor"];
//    if (_bgColor != nil) {
//        _bgImage = [UIImage imageWithColor:_bgColor atSize:self.currentImage.size];
//    } else if([notification.userInfo objectForKey:@"newBGImage"] != nil){
//        _bgImage = [notification.userInfo objectForKey:@"newBGImage"];
//    } else {
//        _bgImage = [UIImage imageWithColor:[UIColor blackColor] atSize:self.currentImage.size];
//    }
//    
//    GPUImagePicture *border = [[GPUImagePicture alloc] initWithImage:_bgImage];
//
//    GPUImageAlphaBlendFilter *alpha = [[GPUImageAlphaBlendFilter alloc] init];
//    GPUImagePicture *imageToProcess = [[GPUImagePicture alloc] initWithImage: nil];
//    alpha.mix = 1.0f;
//    
//    [border addTarget:alpha];
//    [imageToProcess addTarget:alpha];
//
//    [border processImage];
//    [imageToProcess processImage];
//    
//    self.currentImage = nil;
//    self.currentImage = [alpha imageFromCurrentlyProcessedOutput];
//    [self.sessionPreview setImage:self.currentImage];

}

-(void)switchCamera {
    LogTrace(@"switching camera");
    [[BZCaptureManager sharedManager] toggleCamera];
}

-(void)switchShape:(bz_Button *)button
{
    BZMaskAdjustment *maskAdjustment = [[BZMaskAdjustment alloc] init];
    maskAdjustment.identifier = kAdjustmentTypeMask;
    maskAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: button.buttonIdentifier, kButtonIdentifier, nil];
    
    [self.session addAdjustment: maskAdjustment];

//    if (!imageCameFromLibrary) {
//        [self.sessionPreview setImage:nil];
//    }
    
    // set the preview layer mask to the adjusted mask.
    self.cameraPreview.layer.mask = [maskAdjustment layerMaskForSize: self.cameraPreview.frame.size];
    self.cameraPreview.clipsToBounds = YES;
    [self.cameraPreview setNeedsDisplay];
}

- (void)undoLastAdjustment
{
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

- (UIImage*) maskImage:(UIImage *) image withMask:(UIImage *) mask
{
    CGImageRef imageReference = image.CGImage;
    CGImageRef maskReference = mask.CGImage;
    
    CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(maskReference),
                                             CGImageGetHeight(maskReference),
                                             CGImageGetBitsPerComponent(maskReference),
                                             CGImageGetBitsPerPixel(maskReference),
                                             CGImageGetBytesPerRow(maskReference),
                                             CGImageGetDataProvider(maskReference),
                                             NULL, // Decode is null
                                             YES // Should interpolate
                                             );
    
    CGImageRef maskedReference = CGImageCreateWithMask(imageReference, imageMask);
    CGImageRelease(imageMask);
    
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedReference];
    CGImageRelease(maskedReference);
    
    return maskedImage;
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
        }
        else
        {
            self.imageCanvas.image = self.session.thumbnailImage;
        }
    };
    [self.confirmView presentConfirmationFromEdge: CGRectMinXEdge forViewController: self];
    
}

-(void)undoFilter:(id)sender
{    
    UIView *confirm = (UIView*)[sender superview];
    [UIView animateWithDuration:0.5
                     animations:^{
                         confirm.frame = CGRectMake(0, -60.f, 320.f, 60.f);
                     }
                     completion:^(BOOL finished){
                         [confirm removeFromSuperview];
                         useLibrary = NO;
                         
                         BZFilterAdjustment *adj = [self.session.adjustments lastObject];
                         [self.session removeAdjustment: adj];
                         
//                         self.imageCanvas.image = [adj filteredImageWithImage: nil];
//                         self.imageCanvas.contentMode = UIViewContentModeScaleAspectFill;
                         
                     }];
}

-(void)keepFilteredImage:(id)sender {
    
    UIView *confirm = (UIView*)[sender superview];
    [confirm removeFromSuperview];
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:2], @"scrollPosition", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keepPhoto" object:nil userInfo:dict];
    
    useLibrary = NO;
}


-(void)newPhotoArrived:(NSNotification*)notification {
    
    keepPhoto = YES;
    UIImage *newImage = [notification.userInfo objectForKey:@"newImageKey"];
    [NSThread detachNewThreadSelector:@selector(processNewImage:) toTarget:self withObject:newImage];
}

-(void)newLibraryPhotoArrived;
{
//    self.sessionPreview.image = self.session.thumbnailImage;
//    self.sessionPreview.contentMode = UIViewContentModeScaleAspectFill;
    

    [SVProgressHUD dismiss];
    

}

-(void)processNewImage
{
    [self.imageCanvas setImage: self.session.thumbnailImage];
    self.imageCanvas.contentMode = UIViewContentModeScaleAspectFill;

    [SVProgressHUD dismiss];
    
    [self.confirmView presentConfirmationFromEdge: CGRectMaxXEdge forViewController: self];
}

-(void)keepPhotoAndRemoveView:(id)sender {
    
    keepPhoto = YES;
    UIView *confirm = [(bz_Button*)sender superview];
    LogTrace(@"confirm view is at: %f, %f", confirm.frame.origin.x, confirm.frame.origin.y);
    [confirm removeFromSuperview];

    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"scrollPosition", self, @"mainVC", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keepPhoto" object:self userInfo:dict];

    [self setupFilterThumbnails];
    
    useLibrary = NO;
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

-(void)retakePhoto:(id)sender {
    
    keepPhoto = NO;
    UIView *confirm = [(bz_Button*)sender superview];

    [UIView animateWithDuration:0.5
                     animations:^{
                         confirm.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, 320.f, confirm.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [confirm removeFromSuperview];
                         useLibrary = NO;
                         LogTrace(@"completed animation");
                     }];
}

#pragma mark -
#pragma mark - Image Masking

-(void)addMaskedImageViewWithImage:(UIImage*)image
{
//    bz_MaskShapeLayer *maskLayer    = [[bz_MaskShapeLayer alloc] initWithCircleShapeAtSize:CGSizeMake(320, 320)];
//    [self.camer setImage:image];
//    self.sessionPreview.layer.mask = maskLayer;
//    self.sessionPreview.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (void)saveToCameraRoll {
    
    BZAdjustmentProcessor *proc = [[BZAdjustmentProcessor alloc] initWithSession: self.session];
    UIImage *curImg = [proc processedFullResolutionImage];
    
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
        [controller addImage:self.currentImage];
        
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
        [controller addImage:self.currentImage];
        
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
        NSData   *imageData             = UIImageJPEGRepresentation(self.currentImage, 0.85);
        
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSDictionary* dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:@"scrollPosition"];

    switch (alertView.tag) {
        case 10:
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Discard Photo"]) {
                keepPhoto = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StartOver" object:nil userInfo:dict];
            }
            break;
        case 20:
            break;
        case 30:
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Start Over"]) {
                keepPhoto = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StartOver" object:nil userInfo:dict];
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
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    int quality = [df integerForKey:@"full_resolution"];
    
    CGSize imageSize;
    __block UIImage *takenImage;
    __block NSDictionary* dict;
    __block NSNotification *libraryPhoto;
    
    switch (quality) {
        case 2: // User wants highest res image
            imageSize = CGSizeMake(2048, 2048);
            break;
        case 1: // User wants 1024x1024 res image
            imageSize = CGSizeMake(1024, 1024);
            break;
        case 0: // User wants 640x640 res image
            imageSize = CGSizeMake(640, 640);
            break;
        default:
            break;
    }
    LogTrace(@"captured image at: %f, %f", imageSize.width, imageSize.height);

    self.session.thumbnailImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.session.fullResolutionImage = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    if (useLibrary)
    {
        [self dismissViewControllerAnimated:YES completion:^(void){
            useLibrary = NO;
        }];
        
        [self newLibraryPhotoArrived];
        
    } else {
        GPUImageCropFilter *filter;
        
        if (self.view.frame.size.height == 480) {
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(.140625, 0, .75, 1)];
        } else {
            GPUImageCropFilter *filter;

            if (self.view.frame.size.height == 480) {
                filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(.140625, 0, .75, 1)];
            } else {
                filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(.19218745, 0, .75, 1)];
            }
            
            if ([df boolForKey:BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY] == TRUE) {
                [self.library writeImageToSavedPhotosAlbum:[[info objectForKey:UIImagePickerControllerOriginalImage] CGImage] orientation:ALAssetOrientationRight completionBlock:^(NSURL *assetURL, NSError *error) {
                    if (error!=nil) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Image" message:@"Bezel encountered an error while attempting to save image to Photo Library.  Please try saving again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        alert.tag = 0;
                        [alert show];
                    }
                }];
            }
            UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *filteredImage = [filter imageByFilteringImage: originalImage];
            takenImage = [filteredImage resizedImage: kDefaultCameraPreviewSize interpolationQuality:kCGInterpolationMedium];
//            replace code below with
//            saveToCache();
            dict = [NSDictionary dictionaryWithObject:takenImage forKey:@"newImageKey"];
            libraryPhoto = [NSNotification notificationWithName:@"newImage" object:self userInfo:dict];
            [self newPhotoArrived:libraryPhoto];
            [imagePickerController.view removeFromSuperview];
            imagePickerController = nil;
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(.19218745, 0, .75, 1)];
        }
        
        if ([df boolForKey:BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY] == TRUE) {
            [self.library writeImageToSavedPhotosAlbum:[[info objectForKey:UIImagePickerControllerOriginalImage] CGImage] orientation:ALAssetOrientationRight completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error!=nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Image" message:@"Bezel encountered an error while attempting to save image to Photo Library.  Please try saving again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    alert.tag = 0;
                    [alert show];
                }
            }];
        }
//        takenImage = [[filter imageByFilteringImage:[info objectForKey:UIImagePickerControllerOriginalImage] ] resizedImage:imgSize interpolationQuality:kCGInterpolationDefault];
//        dict = [NSDictionary dictionaryWithObject:takenImage forKey:@"newImageKey"];
//        libraryPhoto = [NSNotification notificationWithName:@"newImage" object:self userInfo:dict];
//        [self newPhotoArrived:libraryPhoto];
//        [imagePickerController.view removeFromSuperview];
//        imagePickerController = nil;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        useLibrary = NO;
        [self.imageCanvas setImage:nil];
        self.currentImage = nil;
    }];
}

@end
