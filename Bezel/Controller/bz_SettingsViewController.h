//
//  bz_SettingsViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bz_ViewController.h"

@interface bz_SettingsViewController : bz_ViewController <UICollectionViewDataSource, UICollectionViewDelegate>

- (IBAction)close:(id)sender;
- (IBAction)valueChanged:(id)sender;

@end
