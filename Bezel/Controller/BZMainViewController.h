//
//  BZMainViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZViewController.h"

@class BZSession;
@class BZImageView;

@interface BZMainViewController : BZViewController  <UIAlertViewDelegate, UIDocumentInteractionControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) BZSession *session;

@property (strong, nonatomic) IBOutlet UIView *cameraPreview;
@property (strong, nonatomic) IBOutlet BZImageView *imageCanvas;

@end
