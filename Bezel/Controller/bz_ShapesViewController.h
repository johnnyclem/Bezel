//
//  bz_ShapesViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"
#import "AnimationDelegate.h"

@class BZMaskAdjustment;

@interface bz_ShapesViewController : bz_ViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *shapesCollectionView;
@property (strong, nonatomic) UIButton *takePhotoButton;

@property (nonatomic, copy) void (^switchShapeBlock)(BZMaskAdjustment *adj);

@end
