//
//  bz_SettingsCell.m
//  bz_
//
//  Created by Josh Buchacher on 11/17/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_SettingsCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation bz_SettingsCell

- (void)drawRect:(CGRect)rect
{
    self.contentView.layer.cornerRadius = 10.0f;
    self.contentView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.contentView.layer.borderWidth = 2.0f;
}

- (void)setCurrentValue:(id)value forType:(bz_SettingsValueType)type
{
    UIControl *accessory = (UIControl *)self.accessoryView;
    
    switch (type) {
        case bz_SettingsValueTypeBoolean: {
            UISwitch *aSwitch = (UISwitch *)accessory;
            aSwitch.on = [value boolValue];
        }
            break;
        case bz_SettingsValueTypeStepper: {
            UIStepper *aStepper = (UIStepper *)accessory;
            aStepper.value = [value doubleValue];
        }
            break;
        case bz_SettingsValueTypeInteger: {
            UISegmentedControl *aSegControl = (UISegmentedControl *)accessory;
            aSegControl.selectedSegmentIndex = [value integerValue];
        }
            break;
    }
}

@end
