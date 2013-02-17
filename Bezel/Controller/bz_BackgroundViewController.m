//
//  bz_BackgroundViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_BackgroundViewController.h"
#import "BZButton.h"

@interface bz_BackgroundViewController ()
@property (weak, nonatomic) IBOutlet BZButton *whiteBackground;
@property (weak, nonatomic) IBOutlet BZButton *blackBackgorund;
@end

@implementation bz_BackgroundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.backgroundButtons = [NSArray arrayWithObjects: self.whiteBackground, self.blackBackgorund, nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
