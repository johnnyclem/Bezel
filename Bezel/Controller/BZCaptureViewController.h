//
//  BZCaptureViewController.h
//  Bezel
//
//  Created by Joshua Buchacher on 2/16/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZViewController.h"
#import "BZCameraControlsView.h"

@interface BZCaptureViewController : BZViewController

@property (weak, nonatomic) IBOutlet BZCameraControlsView *cameraControlsView;

@end
