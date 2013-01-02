//
//  BZMaskAdjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/3/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZAdjustmentManagedObject.h"

NSString * const kBZMaskAdjustmentMaskImageKey;

@interface BZMaskAdjustment : BZAdjustmentManagedObject

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSDictionary *value;
@property (nonatomic, retain) NSManagedObject *session;

@end
