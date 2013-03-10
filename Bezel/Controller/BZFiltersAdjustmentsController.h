//
//  BZFilterViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZViewController.h"
#import "AnimationDelegate.h"

@class BZFilterAdjustment;
@class BZBrightnessContrastAdjustment;

@interface BZFiltersAdjustmentsController : BZViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

// Callback used for applying a filter to an image, fired when a user taps
// the collection view cell. The corresponding BZFilterAdjustment will be
// provided to the addFilterBlock.
@property (nonatomic, copy) void (^addFilterBlock)(BZFilterAdjustment *adj);

// Callback used for adjusting an image (brightness or contrast currently),
// fired when a user taps the collection view cell. The corresponding
// BZBrightnessContrastAdjustment will be provided to the adjustImageBlock.
@property (nonatomic, copy) void (^adjustImageBlock)(BZBrightnessContrastAdjustment *adj);

// Called to populate the collection view with the filter previews;
- (void)filterImage:(UIImage *)image;

@end