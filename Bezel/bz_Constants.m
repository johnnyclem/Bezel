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
NSString* const BZ_SETTINGS_LOAD_REMOTE_SHAPES = @"bz_load_remote_shapes";

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

NSString* const BZ_SHAPE_ADJUSTMENT_CELL = @"BZ_SHAPE_ADJUSTMENT_CELL";
NSString* const BZ_FILTER_ADJUSTMENT_CELL = @"BZ_FILTER_ADJUSTMENT_CELL";

// Used as more meaningful Tags
NSString* const kButtonIdentifier = @"kButtonIdentifier";

// Filter buttons
NSString* const kButtonIdentifierFilterBW1 = @"kButtonIdentifierFilterBW1";
NSString* const kButtonIdentifierFilterBW2 = @"kButtonIdentifierFilterBW2";
NSString* const kButtonIdentifierFilterBlue = @"kButtonIdentifierFilterBlue";
NSString* const kButtonIdentifierFilterDarkFade = @"kButtonIdentifierFilterDarkFade";
NSString* const kButtonIdentifierFilterFaded = @"kButtonIdentifierFilterFaded";
NSString* const kButtonIdentifierFilterGoldenHr = @"kButtonIdentifierFilterGoldenHr";
NSString* const kButtonIdentifierFilterOz = @"kButtonIdentifierFilterOz";
NSString* const kButtonIdentifierFilterSepia = @"kButtonIdentifierFilterSepia";
NSString* const kButtonIdentifierFilterNormal = @"kButtonIdentifierFilterNormal";

// BrightnessContrastButtons
NSString* const kButtonIdentifierBrightnessUp = @"kButtonIdentifierBrightnessUp";
NSString* const kButtonIdentifierBrightnessDown = @"kButtonIdentifierBrightnessDown";
NSString* const kButtonIdentifierContrastUp = @"kButtonIdentifierContrastUp";
NSString* const kButtonIdentifierContrastDown = @"kButtonIdentifierContrastDown";

// Background Buttons
NSString* const kButtonIdentifierBlackBackground = @"kButtonIdentifierBlackBackground";
NSString* const kButtonIdentifierWhiteBackground = @"kButtonIdentifierWhiteBackground";
NSString* const kButtonIdentifierClearBackground = @"kButtonIdentifierClearBackground";
NSString* const kButtonIdentifierSwitchBackground = @"kButtonIdentifierSwitchBackground";

// Sharing Buttons
NSString* const kButtonIdentifierFacebook = @"kButtonIdentifierFacebook";
NSString* const kButtonIdentifierTwitter = @"kButtonIdentifierTwitter";
NSString* const kButtonIdentifierInstagram = @"kButtonIdentifierInstagram";
NSString* const kButtonIdentifierCameraRoll = @"kButtonIdentifierCameraRoll";
NSString* const kButtonIdentifierTrash = @"kButtonIdentifierTrash";

@implementation bz_Constants
@end
