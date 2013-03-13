//
//  BZBackgroundViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZViewController.h"

@interface BZBackgroundViewController : BZViewController

@property (strong, nonatomic) NSArray *backgroundButtons;

@property (nonatomic, copy) void (^setBackgroundColorBlock)(UIColor *color);

@end
