//
//  bz_MainViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"
#import "bz_ImageView.h"

@interface bz_MainViewController : bz_ViewController  <UIAlertViewDelegate, UIDocumentInteractionControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet bz_ImageView *sessionPreview;
@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIImage *bgImage;

@end
