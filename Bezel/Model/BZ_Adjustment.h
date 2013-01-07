//
//  BZ_Adjustment.h
//  Bezel
//
//  Created by Josh Buchacher on 1/2/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BZ_Adjustment : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSManagedObject *session;

@end
