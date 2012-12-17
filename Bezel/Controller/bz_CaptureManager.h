//
//  bz_CaptureManager.h
//  Bezel
//
//  Created by Josh Buchacher on 12/16/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface bz_CaptureManager : NSObject

@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;

-(void)takePicture;

@end