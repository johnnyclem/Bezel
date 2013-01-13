//
//  bz_Promotion.h
//  Bezel
//
//  Created by Josh Buchacher on 12/15/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bz_Promotion : NSObject

@property (strong, nonatomic, readonly) NSString *promotionTitle;
@property (strong, nonatomic, readonly) NSString *promotionDescription;
@property (strong, nonatomic, readonly) NSURL *promotionImageHref;
@property (strong, nonatomic, readonly) NSURL *promotionHref;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
