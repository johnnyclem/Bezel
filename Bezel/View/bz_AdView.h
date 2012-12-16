//
//  bz_AdView.h
//  bz_
//
//  Created by Josh Buchacher on 11/24/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class bz_Ad;

@interface bz_AdView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adImage;

- (void)setPromotion:(bz_Ad *)promo;

@end
