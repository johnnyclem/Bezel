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

@interface bz_PromotionView ()
@property (weak, nonatomic) IBOutlet UIButton *tappableArea;
@end

@implementation bz_PromotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *tappableArea = [UIButton buttonWithType:UIButtonTypeCustom];
        tappableArea.frame = frame;
    }
    return self;
}

-(void)_setPromotion:(bz_Promotion *)promo
{
    if (_promotion) {
        _promotion = nil;
    }

    _promotion = promo;
}

- (void)setPromotion:(bz_Promotion *)promo
{
    [self _setPromotion: promo];
    self.promotionTitleLabel.text = promo.promotionTitle;
    self.promotionDescriptionLabel.text = promo.promotionDescription;
    [self.promotionImageView setImageWithURL: promo.promotionImageHref];
}
                                  
- (IBAction)openPromotionUrl
{
    NSURL *promoUrl = self.promotion.promotionHref;
    if (promoUrl) {
        [[UIApplication sharedApplication] openURL: promoUrl];
    }
}

@end
