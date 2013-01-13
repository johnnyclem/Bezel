//
//  bz_Button.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString * const kButtonIdentifierUndefined;

@interface bz_Button : UIButton

@property (nonatomic, strong) NSString *notificationName;
@property (nonatomic, strong) NSString *buttonIdentifier;

- (id)initWithFrame:(CGRect)frame andTag:(int)tag;

@end
