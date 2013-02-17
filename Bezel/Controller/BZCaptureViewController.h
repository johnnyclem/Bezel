//
//  BZCaptureViewController.h
//  Bezel
//
//  Created by Joshua Buchacher on 2/16/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"
#import "BZCameraControlsView.h"

@interface BZCaptureViewController : bz_ViewController

@property (weak, nonatomic) IBOutlet BZCameraControlsView *cameraControlsView;

@end
