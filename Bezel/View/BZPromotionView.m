//
//  BZPromotionView.m
//  BZ
//
//  Created by Josh Buchacher on 11/24/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZPromotionView.h"
#import "BZPromotion.h"

#import "UIImageView+AFNetworking.h"

@interface BZPromotionView ()
@property (weak, nonatomic) IBOutlet UIButton *tappableArea;
@end

@implementation BZPromotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *tappableArea = [UIButton buttonWithType:UIButtonTypeCustom];
        tappableArea.frame = frame;
        [tappableArea addTarget:self action:@selector(openPromotionUrl) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)_setPromotion:(BZPromotion *)promo
{
    if (_promotion) {
        _promotion = nil;
    }

    _promotion = promo;
}

- (void)setPromotion:(BZPromotion *)promo
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
        LogTrace(@"opening promo url: %@", self.promotion.promotionHref);
    } else {
        LogError(@"no promo href");
    }
}

@end
