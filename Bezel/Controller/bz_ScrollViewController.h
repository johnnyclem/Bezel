//
//  bz_ScrollViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"
#import "bz_ScrollView.h"

#import "bz_ShapesViewController.h"
#import "bz_FilterViewController.h"
#import "bz_AdjustmentViewController.h"
#import "bz_BackgroundViewController.h"
#import "bz_ShareViewController.h"

@interface bz_ScrollViewController : bz_ViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet bz_ScrollView *scrollView;
@property (strong, nonatomic) bz_ShapesViewController *shapesViewController;
@property (strong, nonatomic) bz_FilterViewController *filterViewController;
@property (strong, nonatomic) bz_AdjustmentViewController *adjustmentViewController;
@property (strong, nonatomic) bz_BackgroundViewController *backgroundViewController;
@property (strong, nonatomic) bz_ShareViewController *shareViewController;

@property (nonatomic, copy) void (^scrolledToIndexCallback)(NSInteger index);

- (void)setupScrollViewChildren;
- (void)tearDownScrollViewChildren;

- (void)scrollToViewControllerAtIndex:(NSInteger)index;

@end
