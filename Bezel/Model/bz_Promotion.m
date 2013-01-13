//
//  bz_Promotion.m
//  Bezel
//
//  Created by Josh Buchacher on 12/15/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_Promotion.h"

NSString *BZ_PROMOTION_TITLE_KEY = @"promotion_title";
NSString *BZ_PROMOTION_DESCRIPTION_KEY = @"promotion_description";
NSString *BZ_PROMOTION_IMAGE_HREF_KEY = @"promotion_image_href";
NSString *BZ_PROMOTION_HREF_KEY = @"promotion_href";

@implementation bz_Promotion

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _promotionTitle = [dict objectForKey: BZ_PROMOTION_TITLE_KEY];
        _promotionDescription = [dict objectForKey: BZ_PROMOTION_DESCRIPTION_KEY];
        _promotionImageHref = [[NSURL alloc] initWithString:[dict objectForKey: BZ_PROMOTION_IMAGE_HREF_KEY]];
        _promotionHref = [[NSURL alloc] initWithString:[dict objectForKey: BZ_PROMOTION_HREF_KEY]];
    }
    
    return self;
}

@end
