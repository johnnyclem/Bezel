//
//  bz_PromotionView.h
//  bz_
//
//  Created by Josh Buchacher on 11/24/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class bz_Promotion;

@interface bz_PromotionView : UICollectionReusableView

@property (weak, nonatomic, readonly) IBOutlet UILabel *promotionTitleLabel;
@property (weak, nonatomic, readonly) IBOutlet UILabel *promotionDescriptionLabel;
@property (weak, nonatomic, readonly) IBOutlet UIImageView *promotionImageView;

- (void)setPromotion:(bz_Promotion *)promo;

@end