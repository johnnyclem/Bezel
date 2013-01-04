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
#import "BZAdjustmentProcessor.h"

@interface bz_MainViewController ()
{
    IBOutlet bz_Button *cart;
    IBOutlet bz_Button *gallery;
    IBOutlet bz_Button *settings;
    bz_Button *yes;
    bz_Button *no;
    UIImagePickerController *imagePickerController;
    
    BOOL colorPickerIsPurchased;
    BOOL holidayPackIsPurchased;
    BOOL proShapePackIsPurchased;
    BOOL imageCameFromLibrary;
    BOOL keepPhoto;
}

@property (nonatomic, strong) IBOutlet UIView *cameraPreviewView;
@property (nonatomic, strong) UIView *cameraMaskView;
@property (nonatomic, strong) UIView *photoMaskView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImage *saveMask;
@property (nonatomic, strong) UIImage *maskedImage;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) bz_ScrollViewController *scrollVC;
@property (strong, atomic) ALAssetsLibrary* library;
@property (nonatomic, strong) UIDocumentInteractionController *docController;
@property (nonatomic) BOOL useLibrary;
@property (nonatomic) bz_MaskShapeLayer *photoMaskLayer;
@property (nonatomic) CGSize imgSize;
@property (strong, nonatomic) BZSession *session;

@end

@implementation bz_MainViewController

@synthesize cameraMaskView  = _cameraMaskView;
@synthesize photoMaskView   = _photoMaskView;
@synthesize docController   = _docController;
@synthesize bgView          = _bgView;
@synthesize maskImage       = _maskImage;
@synthesize saveMask        = _saveMask;
@synthesize maskedImage     = _maskedImage;
@synthesize bgColor         = _bgColor;
@synthesize bgImage         = _bgImage;
@synthesize timer           = _timer;
@synthesize scrollVC        = _scrollVC;
@synthesize photoMaskLayer  = _photoMaskLayer;
@synthesize library, useLibrary, imgSize;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        LogTrace(@"bz_MainViewController initialized.");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.session = [[BZSession alloc] init];

    imageCameFromLibrary = NO;
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    holidayPackIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_HOLIDAY_PACK_PURCHASE_KEY] boolValue];
    proShapePackIsPurchased  = [(NSNumber*)[standard objectForKey: BZ_PRO_SHAPE_PACK_PURCHASE_KEY] boolValue];
    colorPickerIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_COLOR_PICKER_PURCHASE_KEY] boolValue];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        useLibrary = NO;
    } else {
        useLibrary = YES;
    }

    self.library = [[ALAssetsLibrary alloc] init];

    // Add event listeners
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takePhoto) name:@"camBtn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchShapes) name:@"switchShapes" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchShape:) name:@"switchShape" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchCamera) name:@"switchCam" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newPhotoArrived:) name:@"newImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newPhotoArrivedFromLibrary:) name:@"newImageFromLibrary" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewLoaded:) name:@"scrolledHome" object:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterImage:) name:@"filterImage" object:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBackground:) name:@"newBackground" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharePhoto:) name:@"sharePhoto" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyColorPicker) name:@"buyColorPicker" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyHolidayPack) name:@"buyHolidayPack" object:nil];

    
}

- (void)scrollViewLoaded:(NSNotification*)notification {
    LogTrace(@"Receiving scroll view: %@", _scrollVC);
    _scrollVC = [notification.userInfo objectForKey:@"scrollVC"];
    imageCameFromLibrary = NO;
    [self viewDidAppear:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    
    if ([(NSString*)[standard objectForKey:BZ_SETTINGS_FIRST_LAUNCH_KEY] isEqualToString:@"FALSE"]) {
        if (!keepPhoto) {
            self.currentImage = nil;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                useLibrary = NO;
                [self setupCamera];
            } else {
                useLibrary = YES;
            }
            
            [self switchShape:nil];
        }
        
    } else {
        bz_TutorialViewController *tutorialView = [[bz_TutorialViewController alloc] init];
        [self presentViewController:tutorialView animated:YES completion:^(void) {
            [standard setObject:@"FALSE" forKey: BZ_SETTINGS_FIRST_LAUNCH_KEY];
            [standard synchronize];
            LogInfo(@"first launch bool value: %@", (NSString*)[standard stringForKey: BZ_SETTINGS_FIRST_LAUNCH_KEY]);
        }];
    }

    keepPhoto = NO;
}

-(IBAction)openStoreView:(id)sender {
    bz_StoreViewController *storeVC = [[bz_StoreViewController alloc] initWithNibName:@"bz_StoreView" bundle:nil];
    [self presentViewController:storeVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark Camera methods

-(void)setupCamera {

    [_bgView removeFromSuperview];
    _bgView     = nil;
    _maskedImage = nil;
    self.currentImage = nil;
    
    [[BZCaptureManager sharedManager] setPreviewLayerWithView: _sessionPreview];
}

-(IBAction)importFromLibrary:(id)sender {
    
    useLibrary = YES;
    
    [imagePickerController.view removeFromSuperview];
    imagePickerController = nil;
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;

    [self presentViewController:imagePickerController animated:YES completion:nil];

}

-(void)takePhoto {
    
    void (^takePhoto)(void) = ^ {
        
        void (^successBlock)(id obj) = ^(id obj)
        {
            if ([obj isKindOfClass:[UIImage class]])
            {
                UIImage *img = (UIImage *)obj;
                NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
                __block NSDictionary* dict;
                __block NSNotification *libraryPhoto;
                
                imageCameFromLibrary = NO;
                
                int quality = [df integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY];
                LogInfo(@"Image quality is set to: %i", quality);
                switch (quality) {
                    case 2: // User wants highest res image
                        imgSize = CGSizeMake(2048, 2048);
                        break;
                    case 1: // User wants 1024x1024 res image
                        imgSize = CGSizeMake(1024, 1024);
                        break;
                    case 0: // User wants 640x640 res image
                        imgSize = CGSizeMake(640, 640);
                        break;
                    default:
                        break;
                }
                
                if ([df boolForKey:BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY] == TRUE) {
                    [self.library writeImageToSavedPhotosAlbum: [img CGImage] orientation: img.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
                        if (error!=nil) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Image" message:@"Bezel encountered an error while attempting to save image to Photo Library.  Please try saving again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            alert.tag = 0;
                            [alert show];
                        }
                    }];
                }
                
                UIImage *thumb   = [self scaleImage: img toSize: CGSizeMake(640.f, 640.f)];
                
                [self.session setThumbnailImage: thumb];
                [self.session setFullResolutionImage: img];
                
                dict = [NSDictionary dictionaryWithObject: thumb forKey:@"newImageKey"];
                libraryPhoto = [NSNotification notificationWithName:@"newImage" object:self userInfo:dict];
                [self newPhotoArrived:libraryPhoto];
                
                [[BZCaptureManager sharedManager] setPreviewLayerWithView: nil];
            }
        };
        
        void (^failureBlock)(NSError *err) = ^(NSError *err)
        {
            
        };
        
        [[BZCaptureManager sharedManager] captureMediaWithType: BZCaptureTypePhoto
                                                  successBlock: successBlock
                                                  failureBlock: failureBlock];
    };
        
    [SVProgressHUD showWithStatus:@"Saving Image"];
    takePhoto();
}

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)targetSize {
    //If scaleFactor is not touched, no scaling will occur
    CGFloat scaleFactor = 1.0;
    
    //Deciding which factor to use to scale the image (factor = targetSize / imageSize)
    if (image.size.width > targetSize.width || image.size.height > targetSize.height)
        if (!((scaleFactor = (targetSize.width / image.size.width)) > (targetSize.height / image.size.height))) //scale to fit width, or
            scaleFactor = targetSize.height / image.size.height; // scale to fit heigth.
    
    UIGraphicsBeginImageContext(targetSize);
    
    //Creating the rect where the scaled image is drawn in
    CGRect rect = CGRectMake((targetSize.width - image.size.width * scaleFactor) / 2,
                             (targetSize.height -  image.size.height * scaleFactor) / 2,
                             image.size.width * scaleFactor, image.size.height * scaleFactor);
    
    //Draw the image into the rect
    [image drawInRect:rect];
    
    //Saving the image, ending image context
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

-(void)addBackground:(NSNotification*)notification {
    
    [_sessionPreview.layer setMask:nil];

    _bgColor = [notification.userInfo objectForKey:@"newBGColor"];
    if (_bgColor != nil) {
        _bgImage = [UIImage imageWithColor:_bgColor atSize:self.currentImage.size];
    } else if([notification.userInfo objectForKey:@"newBGImage"] != nil){
        _bgImage = [notification.userInfo objectForKey:@"newBGImage"];
    } else {
        _bgImage = [UIImage imageWithColor:[UIColor blackColor] atSize:self.currentImage.size];
    }
    
    GPUImagePicture *border = [[GPUImagePicture alloc] initWithImage:_bgImage];

    GPUImageAlphaBlendFilter *alpha = [[GPUImageAlphaBlendFilter alloc] init];
    GPUImagePicture *imageToProcess = [[GPUImagePicture alloc] initWithImage:_maskedImage];
    alpha.mix = 1.0f;
    
    [border addTarget:alpha];
    [imageToProcess addTarget:alpha];

    [border processImage];
    [imageToProcess processImage];
    
    self.currentImage = nil;
    self.currentImage = [alpha imageFromCurrentlyProcessedOutput];
    [_sessionPreview setImage:self.currentImage];

}

-(void)switchCamera {
    LogTrace(@"switching camera");
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] && imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        CGAffineTransform transform = CGAffineTransformScale(imagePickerController.cameraViewTransform, -1, 1);
        [imagePickerController setCameraViewTransform:transform];
        [imagePickerController setCameraDevice:UIImagePickerControllerCameraDeviceFront];
    } else if(imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        CGAffineTransform transform = CGAffineTransformScale(imagePickerController.cameraViewTransform, -1, 1);
        [imagePickerController setCameraViewTransform:transform];
        [imagePickerController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
    }
}

-(void)switchShapes
{
    LogTrace(@"switching shape set");
}

-(void)switchShape:(NSNotification*)notification {
    
    bz_MaskShapeLayer *previewMaskLayer;
    
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    holidayPackIsPurchased = [(NSNumber*)[standard objectForKey: BZ_HOLIDAY_PACK_PURCHASE_KEY] boolValue];
    proShapePackIsPurchased = [(NSNumber*)[standard objectForKey: BZ_PRO_SHAPE_PACK_PURCHASE_KEY] boolValue];

    bz_Button *button = [notification.userInfo objectForKey:@"newShape"];
    CGSize imageSize;
    CGSize previewSize = CGSizeMake(320.f, 320.f);
    switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
        case 1:
            imageSize = CGSizeMake(1024.f, 1024.f);
            break;
        case 2:
            imageSize = CGSizeMake(2048.f, 2048.f);
            break;
        default:
            imageSize = CGSizeMake(640.f, 640.f);
            break;
    }

    if (button.tag <= 7) {
        switch (button.tag) {
            case 4:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"squareMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"squareMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"squareMask_640.png"];
                        break;
                }
                previewMaskLayer = [[bz_MaskShapeLayer alloc] initWithSquareShapeAtSize:previewSize];
                _photoMaskLayer   = [[bz_MaskShapeLayer alloc] initWithSquareShapeAtSize:imageSize];
                break;
            case 5:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"triangleMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"triangleMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"triangleMask_640.png"];
                        break;
                }
                _photoMaskLayer   = [[bz_MaskShapeLayer alloc] initWithTriangleAtSize:imageSize];
                previewMaskLayer = [[bz_MaskShapeLayer alloc] initWithTriangleAtSize:previewSize];
                break;
            case 6:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"hexagonMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"hexagonMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"hexagonMask_640.png"];
                        break;
                }
                previewMaskLayer = [[bz_MaskShapeLayer alloc] initWithHexagonAtSize:previewSize];
                _photoMaskLayer   = [[bz_MaskShapeLayer alloc] initWithHexagonAtSize:imageSize];
                break;
            case 7:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"heartMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"heartMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"heartMask_640.png"];
                        break;
                }
                previewMaskLayer = [[bz_MaskShapeLayer alloc] initWithHeartAtSize:previewSize];
                _photoMaskLayer   = [[bz_MaskShapeLayer alloc] initWithTriangleAtSize:imageSize];
                break;
            default:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"circleMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"circleMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"circleMask_640.png"];
                        break;
                }
                previewMaskLayer = [[bz_MaskShapeLayer alloc] initWithCircleShapeAtSize:previewSize];
                _photoMaskLayer   = [[bz_MaskShapeLayer alloc] initWithCircleShapeAtSize:imageSize];
                break;
        }
    }

    else if (button.tag >= 53 && button.tag <= 100 && holidayPackIsPurchased) {
        switch ([(bz_Button*)[notification.userInfo objectForKey:@"newShape"] tag]) {
            case 53:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"treeMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"treeMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"treeMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"tree.png"];
                break;
            case 55:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"starMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"starMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"starMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"star.png"];
                break;
            case 58:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"ornamentMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"ornamentMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"ornamentMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"ornament.png"];
                break;
            default:
                break;
        }
    }

    else if (button.tag >= 53 && button.tag <= 100 && !holidayPackIsPurchased) {
        UIAlertView *buyHolidayPack = [[UIAlertView alloc] initWithTitle:@"Buy Holiday Pack?" message:@"This shape is part of the Bezel Holiday Pack. You can unlock all 3 holiday shapes and 3 holiday backgrounds in the Bezel Store" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Go To Store", nil];
        buyHolidayPack.tag = 50;
        [buyHolidayPack show];
    }
    else if (button.tag >= 153 && button.tag <= 200 && proShapePackIsPurchased) {
        switch ([(bz_Button*)[notification.userInfo objectForKey:@"newShape"] tag]) {
            case 153:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"crossMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"crossMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"crossMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"cross.png"];
                break;
            case 154:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"teardropMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"teardropMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"teardropMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"teardrop.png"];
                break;
            case 155:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"lightningMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"lightningMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"lightningMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"lightning.png"];
                break;
            case 156:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"anchorMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"anchorMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"anchorMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"anchor.png"];
                break;
            case 157:
                switch ([standard integerForKey:BZ_SETTINGS_FULL_RESOLUTION_KEY]) {
                    case 1:
                        _saveMask  = [UIImage imageNamed:@"arrowMask_1024.png"];
                        break;
                    case 2:
                        _saveMask  = [UIImage imageNamed:@"arrowMask.png"];
                        break;
                    default:
                        _saveMask  = [UIImage imageNamed:@"arrowMask_640.png"];
                        break;
                }
                _maskImage = [UIImage imageNamed:@"arrow.png"];
                break;
            default:
                break;
        }
    }
    
    else if (button.tag >= 153 && button.tag <= 200 && !proShapePackIsPurchased) {
        UIAlertView *buyProShapePack = [[UIAlertView alloc] initWithTitle:@"Buy Pro Shape Pack?" message:@"This shape is part of the Bezel Pro Shapes Pack. You can unlock all 5 pro shapes in the Bezel Store" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Go To Store", nil];
        buyProShapePack.tag = 150;
        [buyProShapePack show];
    }

//    switch ([standard integerForKey:bz_SettingsFullResolutionKey]) {
//        case 0:
//            _maskImage = [_maskImage resizedImage:CGSizeMake(640, 640) interpolationQuality:kCGInterpolationHigh];
//            _saveMask  = [_saveMask resizedImage:CGSizeMake(1024, 1024) interpolationQuality:kCGInterpolationHigh];
//            break;
//        case 1:
//            _maskImage = [_maskImage resizedImage:CGSizeMake(640, 640) interpolationQuality:kCGInterpolationHigh];
//            _saveMask  = [_saveMask resizedImage:CGSizeMake(1024, 1024) interpolationQuality:kCGInterpolationHigh];
//            break;
//        default:
//            break;
//    }

//    previewMaskLayer = [[bz_MaskShapeLayer alloc] initWithShapeFromImage:_maskImage atSize:CGSizeMake(320, 320)];
//    if (self.view.frame.size.height == 480) {
//    } else {
//        previewMaskLayer.frame = CGRectMake(0, 90, 320, 320);
//    }

//    photoMaskLayer = [[bz_MaskShapeLayer alloc] initWithShapeFromImage:_maskImage atSize:CGSizeMake(320, 320)];
//    previewMaskLayer.frame = CGRectMake(0, 60, 320, 320);

    BZMaskAdjustment *maskAdjustment = [[BZMaskAdjustment alloc] init];
    maskAdjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: _photoMaskLayer, kBZMaskAdjustmentMaskShapeKey, nil];
    
    [self.session addAdjustment: maskAdjustment];

    if (!imageCameFromLibrary) {
        [_sessionPreview setImage:nil];
    }
    
    _sessionPreview.layer.mask = previewMaskLayer;
    _sessionPreview.clipsToBounds = YES;
    [_sessionPreview setNeedsDisplay];
    
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

-(void)filterImage:(NSNotification*)notification {
    
    UIImage *filteredImage = [notification.userInfo objectForKey:@"newFilteredImage"];
    
    _maskedImage = [self maskImage:filteredImage withMask:_saveMask];
    self.currentImage = nil;
    self.currentImage = filteredImage;
    
    [_sessionPreview setImage:self.currentImage];

}

-(void)newPhotoArrived:(NSNotification*)notification {
    
    keepPhoto = YES;
    UIImage *newImage = [notification.userInfo objectForKey:@"newImageKey"];
    [NSThread detachNewThreadSelector:@selector(processNewImage:) toTarget:self withObject:newImage];
}

-(void)newLibraryPhotoArrived:(NSNotification*)notification {
    
    keepPhoto = YES;
    self.currentImage = [notification.userInfo objectForKey:@"newImageKey"];
    [_sessionPreview setImage:self.currentImage];
    [NSThread detachNewThreadSelector:@selector(processNewLibraryImage:) toTarget:self withObject:nil];
}

-(void)processNewImage:(UIImage*)newImage {

    _maskImage = [bz_MaskShapeLayer maskImageFromShape:_photoMaskLayer atSize:CGSizeMake(1024.f, 1024.f)];
    _maskedImage = [self maskImage:newImage withMask:_maskImage];
    self.currentImage = nil;
    self.currentImage = newImage;
    [_sessionPreview setImage:self.currentImage];
    _sessionPreview.contentMode = UIViewContentModeScaleAspectFill;

    UIView *confirm = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, 320, UIScreen.mainScreen.bounds.size.height-380)];
    confirm.backgroundColor = [UIColor blackColor];
    yes = [[bz_Button alloc] initWithFrame:CGRectMake(25.f, (confirm.frame.size.height/2.f)-25.f, 50.f, 50.f)];
    yes.tag = 33;
    [yes addTarget:self action:@selector(keepPhotoAndRemoveView:) forControlEvents:UIControlEventTouchUpInside];
    
    no = [[bz_Button alloc] initWithFrame:CGRectMake(245.f, (confirm.frame.size.height/2.f)-25.f, 50.f, 50.f)];
    [no addTarget:self action:@selector(retakePhoto:) forControlEvents:UIControlEventTouchUpInside];
    no.tag = 34;
    
    [confirm addSubview:yes];
    [confirm addSubview:no];
    
    [self.view addSubview:confirm];
    [SVProgressHUD dismiss];

    [UIView animateWithDuration:0.5
                     animations:^{
                         confirm.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height-confirm.frame.size.height, 320.f, confirm.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         LogTrace(@"completed animation");
                     }];

}

-(void)processNewLibraryImage:(UIImage*)newImage {
    
    UIView *confirm = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height, 320, (UIScreen.mainScreen.bounds.size.height-380)/2)];
    confirm.backgroundColor = [UIColor blackColor];
    yes = [[bz_Button alloc] initWithFrame:CGRectMake(25.f, (confirm.frame.size.height/2.f)-25.f, 50.f, 50.f)];
    yes.tag = 33;
    [yes addTarget:self action:@selector(keepPhotoAndRemoveView:) forControlEvents:UIControlEventTouchUpInside];
    
    no = [[bz_Button alloc] initWithFrame:CGRectMake(245.f, (confirm.frame.size.height/2.f)-25.f, 50.f, 50.f)];
    [no addTarget:self action:@selector(retakePhoto:) forControlEvents:UIControlEventTouchUpInside];
    no.tag = 34;
    
    [confirm addSubview:yes];
    [confirm addSubview:no];
    
    [self.view addSubview:confirm];
    [SVProgressHUD dismiss];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         confirm.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height-confirm.frame.size.height, 320.f, confirm.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         LogTrace(@"completed animation");
                     }];
    
}

-(void)keepPhotoAndRemoveView:(id)sender {
    
    keepPhoto = YES;
    UIView *confirm = [(bz_Button*)sender superview];
    LogTrace(@"confirm view is at: %f, %f", confirm.frame.origin.x, confirm.frame.origin.y);
    [confirm removeFromSuperview];

    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"scrollPosition", self, @"mainVC", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keepPhoto" object:self userInfo:dict];

//    [self sendImagetoFilterView:self.currentImage];
    [self performSelectorInBackground:@selector(sendImagetoFilterView:) withObject:self.currentImage];
    useLibrary = NO;
}

-(void)sendImagetoFilterView:(UIImage*)image {
    
    NSDictionary* newImage = [NSDictionary dictionaryWithObjectsAndKeys:image, @"newImage", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupFilterPreviews" object:self userInfo:newImage];

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
                         [self viewDidAppear:NO];
                         LogTrace(@"completed animation");
                     }];
    
}

#pragma mark -
#pragma mark - Image Masking

-(void)addMaskedImageViewWithImage:(UIImage*)image {
    
    bz_MaskShapeLayer *maskLayer    = [[bz_MaskShapeLayer alloc] initWithCircleShapeAtSize:CGSizeMake(320, 320)];
    [_sessionPreview setImage:image];
    _sessionPreview.layer.mask = maskLayer;
    _sessionPreview.clipsToBounds = YES;

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
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"No Thanks"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"switchShapes" object:self userInfo:dict];
                
            } else if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Go To Store"]) {
                
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

#pragma mark -
#pragma mark - Library Import

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    // remove the image if previously saved
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedImage"]) {
//        NSString *cachedFilePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedImage"];
//        [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:cachedFilePath] error:NULL];
//    }
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    int quality = [df integerForKey:@"full_resolution"];
    
    CGSize imgSize;
    __block UIImage *takenImage;
//    __block UIImage *thumbImage;
    __block NSDictionary* dict;
    __block NSNotification *libraryPhoto;
    
    switch (quality) {
        case 2: // User wants highest res image
            imgSize = CGSizeMake(2048, 2048);
            break;
        case 1: // User wants 1024x1024 res image
            imgSize = CGSizeMake(1024, 1024);
            break;
        case 0: // User wants 640x640 res image
            imgSize = CGSizeMake(640, 640);
            break;
        default:
            break;
    }
    LogTrace(@"captured image at: %f, %f", imgSize.width, imgSize.height);
    
//    void (^saveToCache)(void) = ^ {
//
//        [takenImage persistToCacheAsPNG:^(NSURL *url, NSUInteger size) {
//            LogInfo(@"Complete: %@ | %d", url, size);
//            
//            // save the file path
//            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", url] forKey:@"savedImage"];
//        } failure:^(NSError *error) {
//            LogError(@"Error: %@", error);
//        }];  
//    };

    void (^saveFullRes)(void) = ^ {
    
        if (useLibrary) {
            imageCameFromLibrary = YES;
            [self dismissViewControllerAnimated:YES completion:^(void){
                takenImage = [[info objectForKey:UIImagePickerControllerEditedImage] resizedImage:imgSize interpolationQuality:kCGInterpolationDefault];
//            replace code below with
//            saveToCache();
                dict = [NSDictionary dictionaryWithObject:takenImage forKey:@"newImageKey"];
                libraryPhoto = [NSNotification notificationWithName:@"newImage" object:self userInfo:dict];
                useLibrary = NO;
                [self newLibraryPhotoArrived:libraryPhoto];
            }];
        } else {
            imageCameFromLibrary = NO;
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
            takenImage = [filteredImage resizedImage:imgSize interpolationQuality:kCGInterpolationMedium];
//            replace code below with
//            saveToCache();
            dict = [NSDictionary dictionaryWithObject:takenImage forKey:@"newImageKey"];
            libraryPhoto = [NSNotification notificationWithName:@"newImage" object:self userInfo:dict];
            [self newPhotoArrived:libraryPhoto];
            [imagePickerController.view removeFromSuperview];
            imagePickerController = nil;
        }
            
    };
    
//work this in later
//    
//    void (^saveThumb)(void) = ^ {
//        
//        if (useLibrary) {
//            [self dismissViewControllerAnimated:YES completion:^(void){
//                takenImage = [[info objectForKey:UIImagePickerControllerEditedImage] resizedImage:CGSizeMake(640, 640) interpolationQuality:kCGInterpolationLow];
//                dict = [NSDictionary dictionaryWithObject:takenImage forKey:@"newImageKey"];
//                libraryPhoto = [NSNotification notificationWithName:@"newImage" object:self userInfo:dict];
//                [self newPhotoArrived:libraryPhoto];
//                imagePickerController = nil;
//            }];
//        } else {
//            GPUImageCropFilter *filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(.140625, 0, .75, 1)];
//            takenImage = [[filter imageByFilteringImage:[info objectForKey:UIImagePickerControllerOriginalImage]] resizedImage:CGSizeMake(640, 640) interpolationQuality:kCGInterpolationLow];
//            dict = [NSDictionary dictionaryWithObject:takenImage forKey:@"newImageKey"];
//            libraryPhoto = [NSNotification notificationWithName:@"newImage" object:self userInfo:dict];
//            [self newPhotoArrived:libraryPhoto];
//            [imagePickerController.view removeFromSuperview];
//            imagePickerController = nil;
//        }
//                
//    };
//    
//    saveThumb();
    
    saveFullRes();

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        useLibrary = NO;
        [_sessionPreview setImage:nil];
        self.currentImage = nil;
        [self viewDidAppear:YES];
    }];
}

@end
