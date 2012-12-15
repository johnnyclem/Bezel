//
//  bz_Setting.h
//  bz_
//
//  Created by Josh Buchacher on 11/18/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum bz_SettingsValueTypes {
    bz_SettingsValueTypeBoolean = 0,
    bz_SettingsValueTypeStepper,
    bz_SettingsValueTypeInteger,
    } bz_SettingsValueType;

@interface bz_Setting : NSObject

@property (strong, nonatomic) NSString *readableName;
@property (strong, nonatomic) NSString *defaultsIdentifier;
@property (assign, nonatomic) bz_SettingsValueType valueType;
@property (assign, nonatomic) NSNumber *value;

@end
