//
//  BZPromotionView.h
//  BZ
//
//  Created by Josh Buchacher on 11/24/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BZPromotion;

@interface BZPromotionView : UICollectionReusableView

@property (strong, nonatomic, setter =  _setPromotion:) BZPromotion *promotion;
@property (weak, nonatomic) IBOutlet UILabel *promotionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *promotionDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *promotionImageView;

- (void)setPromotion:(BZPromotion *)promo;

@end