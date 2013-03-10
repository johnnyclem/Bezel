//
//  BZBrightnessContrastCollectionViewCell.h
//  Bezel
//
//  Created by Josh Buchacher on 3/10/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BZButton;

@interface BZBrightnessContrastCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet BZButton *brightnessUpButton;
@property (weak, nonatomic) IBOutlet BZButton *brightnessDownButton;
@property (weak, nonatomic) IBOutlet BZButton *contrastUpButton;
@property (weak, nonatomic) IBOutlet BZButton *contrastDownButton;

@end
