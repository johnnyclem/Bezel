//
//  BZBackgroundViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZBackgroundViewController.h"
#import "BZButton.h"

@interface BZBackgroundViewController ()
@property (weak, nonatomic) IBOutlet BZButton *whiteBackground;
@property (weak, nonatomic) IBOutlet BZButton *blackBackground;
@property (weak, nonatomic) IBOutlet BZButton *clearBackground;
-(IBAction)switchBackground:(id)sender;
@end

@implementation BZBackgroundViewController

-(IBAction)switchBackground:(id)sender
{
    // Placeholder for better logic when we decide how this view looks and works.
    UIColor *selectedColor;
    
    if (sender == self.whiteBackground)
    {
        selectedColor = [UIColor whiteColor];
    }
    else if (sender == self.blackBackground)
    {
        selectedColor = [UIColor blackColor];
    }
    else if (sender == self.clearBackground)
    {
        selectedColor = [UIColor clearColor];
    }
    
    if (self.setBackgroundColorBlock)
    {
        self.setBackgroundColorBlock(selectedColor);
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.backgroundButtons = [NSArray arrayWithObjects: self.whiteBackground, self.blackBackground, self.clearBackground,nil];
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
