//
//  bz_ViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bz_Button.h"

@interface bz_ViewController : UIViewController

@property(nonatomic) CGFloat scrollHeight;
@property (nonatomic, strong) UIImage *currentImage;

@property (weak, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end
