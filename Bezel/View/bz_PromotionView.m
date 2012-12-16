//
//  bz_PromotionView.m
//  bz_
//
//  Created by Josh Buchacher on 11/24/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_PromotionView.h"
#import "bz_Promotion.h"

#import "UIImageView+AFNetworking.h"

@implementation bz_PromotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setPromotion:(bz_Promotion *)promo
{
    self.promotionTitleLabel.text = promo.promotionTitle;
    self.promotionDescriptionLabel.text = promo.promotionDescription;
    [self.promotionImageView setImageWithURL: promo.promotionImageHref];
}

@end
