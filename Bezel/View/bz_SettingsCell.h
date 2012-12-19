//
//  bz_SettingsCell.h
//  bz_
//
//  Created by Josh Buchacher on 11/17/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bz_Setting.h"

@interface bz_SettingsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UIView *accessoryView;

- (void)setCurrentValue:(id)value forType:(bz_SettingsValueType)type;

@end
