//
//  BZCameraControlsView.h
//  Bezel
//
//  Created by Joshua Buchacher on 1/28/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZCameraControlsView : UIView

@property (weak, nonatomic) IBOutlet UIButton *takePhoto;
@property (weak, nonatomic) IBOutlet UIButton *switchCamera;
@property (weak, nonatomic) IBOutlet UIButton *importFromLibrary;

@end
