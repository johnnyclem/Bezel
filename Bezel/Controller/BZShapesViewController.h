//
//  BZShapesViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZViewController.h"
#import "AnimationDelegate.h"

@class BZMaskAdjustment;

@interface BZShapesViewController : BZViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *shapesCollectionView;
@property (strong, nonatomic, readonly) NSMutableArray *shapes;

@property (nonatomic, copy) void (^switchShapeBlock)(BZMaskAdjustment *adj);

@end
