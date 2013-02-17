//
//  BZCameraControlsView.h
//  Bezel
//
//  Created by Joshua Buchacher on 1/28/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZButton.h"

@interface BZCameraControlsView : UIView

@property (weak, nonatomic) IBOutlet BZButton *shootPhoto;
@property (weak, nonatomic) IBOutlet BZButton *switchCamera;
@property (weak, nonatomic) IBOutlet BZButton *toggleFlash;
@end
