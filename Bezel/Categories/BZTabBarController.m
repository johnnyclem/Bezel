//
//  BZTabBarController.m
//  Bezel
//
//  Created by Joshua Buchacher on 2/16/13.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "BZTabBarController.h"

@interface BZTabBarController ()

@end

@implementation BZTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = TRUE;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end