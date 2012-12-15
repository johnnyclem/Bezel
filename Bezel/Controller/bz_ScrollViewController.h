//
//  bz_ScrollViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"

@interface bz_ScrollViewController : bz_ViewController <UIScrollViewDelegate>

- (void)setupScrollViewChildren;
- (void)tearDownScrollViewChildren;
- (void)removeChildrenImages;

@end
