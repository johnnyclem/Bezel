//
//  bz_Constants.h
//  Bezel
//
//  Created by Josh Buchacher on 12/16/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>


// Settings bundle identifiers (for QA build only currently)
NSString* const BZ_SETTINGS_LOAD_REMOTE_PROMOTIONS;

// Defaults identifiers (in-app purchases, resolution settings, etc)
NSString* const BZ_HOLIDAY_PACK_PURCHASE_KEY;
NSString* const BZ_COLOR_PICKER_PURCHASE_KEY;
NSString* const BZ_PRO_SHAPE_PACK_PURCHASE_KEY;
NSString* const BZ_SETTINGS_FULL_RESOLUTION_KEY;
NSString* const BZ_SETTINGS_FIRST_LAUNCH_KEY;
NSString* const BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY;

// Reuse identifiers
NSString* const BZ_PROMOTION_VIEW_REUSE_IDENTIFIER;
NSString* const BZ_PROMOTION_VALUE_STEPPER_REUSE_IDENTIFIER;
NSString* const BZ_PROMOTION_VALUE_SWITCH_REUSE_IDENTIFIER;
NSString* const BZ_PROMOTION_VALUE_SEGMENTED_CONTROL_REUSE_IDENTIFIER;

// Used as more meaningful Tags
NSString* const kButtonIdentifier;

// Mask buttons
NSString* const kButtonIdentifierCircleMask;
NSString* const kButtonIdentifierSquareMask;
NSString* const kButtonIdentifierTriangleMask;
NSString* const kButtonIdentifierHexagonMask;
NSString* const kButtonIdentifierHeartMask;


// Filter buttons
NSString* const kButtonIdentifierFilterBW1;
NSString* const kButtonIdentifierFilterBW2;
NSString* const kButtonIdentifierFilterBlue;
NSString* const kButtonIdentifierFilterDarkFade;
NSString* const kButtonIdentifierFilterFaded;
NSString* const kButtonIdentifierFilterGoldenHr;
NSString* const kButtonIdentifierFilterOz;
NSString* const kButtonIdentifierFilterSepia;
NSString* const kButtonIdentifierFilterNormal;

@interface bz_Constants : NSObject
@end
