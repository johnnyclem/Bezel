//
//  bz_ImagePickerViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bz_ViewController.h"
#import "YLBackgroundView.h"

@interface bz_ImagePickerViewController : bz_ViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIView *overlay;
@property (nonatomic, strong) GPUImageStillCamera *stillCamera;
@property (nonatomic) BOOL useLibrary;

- (void)takePicture;

@end
