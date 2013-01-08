//
//  bz_MainViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"

@class BZSession;
@class bz_ImageView;

@interface bz_MainViewController : bz_ViewController  <UIAlertViewDelegate, UIDocumentInteractionControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) BZSession *session;

@property (strong, nonatomic) IBOutlet UIView *cameraPreview;
@property (strong, nonatomic) IBOutlet bz_ImageView *imageCanvas;

@end
