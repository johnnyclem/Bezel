//
//  BZSettingsViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZViewController.h"

@interface BZSettingsViewController : BZViewController <UICollectionViewDataSource, UICollectionViewDelegate>

- (IBAction)close:(id)sender;
- (IBAction)valueChanged:(id)sender;

@end
