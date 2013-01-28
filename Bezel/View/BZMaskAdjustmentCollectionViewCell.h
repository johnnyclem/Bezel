//
//  BZMaskAdjustmentCollectionViewCell.h
//  Bezel
//
//  Created by Joshua Buchacher on 1/27/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BZMaskAdjustment;

@interface BZMaskAdjustmentCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@property (weak, nonatomic) BZMaskAdjustment *adjustment;

@end
