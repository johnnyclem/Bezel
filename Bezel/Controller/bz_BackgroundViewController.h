//
//  bz_BackgroundViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ViewController.h"
#import "RSColorPickerView.h"
#import "RSBrightnessSlider.h"
#import "bz_MainViewController.h"
#import "AnimationDelegate.h"

@interface bz_BackgroundViewController : bz_ViewController <RSColorPickerViewDelegate>
{
    RSColorPickerView *colorPicker;
	RSBrightnessSlider *brightnessSlider;
}

@property(nonatomic, strong) bz_MainViewController *mainVC;

- (void)changeBackground:(id)sender;

@end
