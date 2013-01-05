//
//  bz_Constants.m
//  Bezel
//
//  Created by Josh Buchacher on 12/16/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_Constants.h"

// Settings bundle identifiers (for QA build only currently)
NSString* const BZ_SETTINGS_LOAD_REMOTE_PROMOTIONS = @"bz_load_remote_promotions";

// Defaults identifiers (in-app purchases, resolution settings, etc)
NSString* const BZ_HOLIDAY_PACK_PURCHASE_KEY = @"holiday_pack";
NSString* const BZ_COLOR_PICKER_PURCHASE_KEY = @"color_picker";
NSString* const BZ_PRO_SHAPE_PACK_PURCHASE_KEY = @"pro_shape_pack";
NSString* const BZ_SETTINGS_FULL_RESOLUTION_KEY = @"full_resolution";
NSString* const BZ_SETTINGS_FIRST_LAUNCH_KEY = @"first_launch";
NSString* const BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY = @"save_to_camera_roll";

// Reuse identifiers
NSString* const BZ_PROMOTION_VIEW_REUSE_IDENTIFIER = @"bz_PromotionView";
NSString* const BZ_PROMOTION_VALUE_STEPPER_REUSE_IDENTIFIER = @"bz_PromotionViewStepper";
NSString* const BZ_PROMOTION_VALUE_SWITCH_REUSE_IDENTIFIER = @"bz_PromotionViewSwitch";
NSString* const BZ_PROMOTION_VALUE_SEGMENTED_CONTROL_REUSE_IDENTIFIER = @"bz_PromotionViewSegmentedControl";

@implementation bz_Constants
@end
