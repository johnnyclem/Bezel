//
//  bz_ShapesViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"
#import "AnimationDelegate.h"

@protocol BZShapesViewControllerDelegate <NSObject>
- (void)shapeTouched:(bz_Button *)shape;
@end

@interface bz_ShapesViewController : bz_ViewController

@property (weak) id <BZShapesViewControllerDelegate> delegate;

@property (strong, nonatomic, readonly) NSArray *shapeButtons;
@property (strong, nonatomic, readonly) bz_Button *takePhotoButton;

@end
