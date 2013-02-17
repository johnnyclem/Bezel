//
//  BZSettingsCell.h
//  BZ
//
//  Created by Josh Buchacher on 11/17/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZSetting.h"

@interface BZSettingsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UIView *accessoryView;

- (void)setCurrentValue:(id)value forType:(bz_SettingsValueType)type;

@end
