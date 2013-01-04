//
//  bz_ShapesViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ShapesViewController.h"
#import "bz_MainViewController.h"
#import "FlipView.h"

@interface bz_ShapesViewController ()
{
    bz_Button *circle;
    bz_Button *square;
    bz_Button *triangle;
    bz_Button *hexagon;
    bz_Button *heart;
    bz_Button *switchShapes;
    
    AnimationDelegate *animationDelegate;
    FlipView *container;
}

@end

@implementation bz_ShapesViewController

@synthesize scrollHeight    = _scrollHeight;

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
    
    // Top Row Buttons
    CGFloat width       = self.view.frame.size.width;
    CGFloat btnOffset   = (_scrollHeight-100)/4;
    CGFloat btnOnset    = (_scrollHeight-50)-btnOffset;
    CGFloat btnWidth    = width/5.f;
    CGFloat btnHeight   = 50.f;
    
    circle   = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnOffset, btnWidth, btnHeight)];
    square   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth, btnOffset, btnWidth, btnHeight)];
    triangle = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*2, btnOffset, btnWidth, btnHeight)];
    hexagon  = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*3, btnOffset, btnWidth, btnHeight)];
    heart    = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*4, btnOffset, btnWidth, btnHeight)];

    [circle setTag:3];
    [square setTag:4];
    [triangle setTag:5];
    [hexagon setTag:6];
    [heart setTag:7];
        
    [self.view addSubview:circle];
    [self.view addSubview:square];
    [self.view addSubview:triangle];
    [self.view addSubview:hexagon];
    [self.view addSubview:heart];
    
    // Bottom Row Buttons
    bz_Button *switchCam   = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnOnset, 106, btnHeight)];
    bz_Button *camBtn   = [[bz_Button alloc] initWithFrame:CGRectMake(106, btnOnset, 108, btnHeight)];
    switchShapes = [[bz_Button alloc] initWithFrame:CGRectMake(214, btnOnset, 106, btnHeight)];

    [switchCam setTag:32];
    [camBtn setTag:1];
    [switchShapes setTag:38];

    [self.view addSubview:switchCam];
    [self.view addSubview:camBtn];
    [self.view addSubview:switchShapes];
    
    
    // Assign button actions
    [circle setNotificationName:@"circle"];
    [square setNotificationName:@"square"];
    [triangle setNotificationName:@"triangle"];
    [hexagon setNotificationName:@"hexagon"];
    [heart setNotificationName:@"heart"];
    [switchCam setNotificationName:@"switchCam"];
    [switchShapes setNotificationName:@"switchShapes"];
    [camBtn setNotificationName:@"camBtn"];

    [switchShapes addTarget:self action:@selector(switchShapeSet:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flipAnimationFinished:) name:@"flipAnimationFinished" object:nil];

    [circle addTarget:self action:@selector(switchShape:) forControlEvents:UIControlEventTouchUpInside];
    [square addTarget:self action:@selector(switchShape:) forControlEvents:UIControlEventTouchUpInside];
    [triangle addTarget:self action:@selector(switchShape:) forControlEvents:UIControlEventTouchUpInside];
    [hexagon addTarget:self action:@selector(switchShape:) forControlEvents:UIControlEventTouchUpInside];
    [heart addTarget:self action:@selector(switchShape:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)switchShapeSet:(id)sender {
    
    // Create a container view for the shape button animation
    animationDelegate = [[AnimationDelegate alloc] initWithSequenceType:kSequenceAuto directionType:kDirectionForward];
    animationDelegate.controller = self;
    animationDelegate.perspectiveDepth = 200;
    animationDelegate.repeat = NO;

    container = [[FlipView alloc] initWithAnimationType:kAnimationFlipVertical frame:CGRectMake(0.f, circle.frame.origin.y, 320.f, circle.frame.size.height)];
    animationDelegate.transformView = container;

    [self.view addSubview:container];
    
    switch ([(bz_Button*)sender tag]) {
        case 38:
            [(bz_Button*)sender setTag:138];
            LogTrace(@"switching to xmas shapes");
            [container printText:@"" usingImage:[UIImage imageNamed:@"holidayShapes.png"] backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
            [container printText:@"" usingImage:[UIImage imageNamed:@"standardShapes.png"] backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
            
            [circle setTag:53];
            [square setHidden:YES];
            [triangle setTag:55];
            [hexagon setHidden:YES];
            [heart setTag:58];
            
            [circle setNotificationName:@"treeFilled"];
            [triangle setNotificationName:@"starFilled"];
            [heart setNotificationName:@"ornamentFilled"];
            break;
        case 138:
            [(bz_Button*)sender setTag:238];
            NSLog(@"switching to pro shapes");
            [container printText:@"" usingImage:[UIImage imageNamed:@"proShapes.png"] backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
            [container printText:@"" usingImage:[UIImage imageNamed:@"holidayShapes.png"] backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
            
            [circle setTag:153];
            [square setHidden:NO];
            [square setTag:154];
            [triangle setTag:155];
            [hexagon setHidden:NO];
            [hexagon setTag:156];
            [heart setTag:157];
            
            [circle setNotificationName:@"cross"];
            [square setNotificationName:@"teardrop"];
            [triangle setNotificationName:@"lightning"];
            [hexagon setNotificationName:@"anchor"];
            [heart setNotificationName:@"arrow"];
            break;
        case 238:
            [(bz_Button*)sender setTag:38];
            LogTrace(@"switching to standard shapes");
            [container printText:@"" usingImage:[UIImage imageNamed:@"standardShapes.png"] backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
            [container printText:@"" usingImage:[UIImage imageNamed:@"proShapes.png"] backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
            
            [circle setTag:3];
            [square setTag:4];
            [triangle setTag:5];
            [hexagon setTag:6];
            [heart setTag:7];
            
            [circle setNotificationName:@"circle"];
            [square setNotificationName:@"square"];
            [triangle setNotificationName:@"triangle"];
            [hexagon setNotificationName:@"hexagon"];
            [heart setNotificationName:@"heart"];
            break;
        default:
            break;
    }
    
    [(bz_Button*)sender setEnabled:NO];
    [animationDelegate startAnimation:kDirectionForward];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchShape:(id)sender {
    
    NSDictionary* dict = [NSDictionary dictionaryWithObject:(bz_Button*)sender forKey:@"newShape"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switchShape" object:self userInfo:dict];

}

- (void)switchCamera {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switchCam" object:nil userInfo:nil];
}

- (void)animationDidFinish:(BOOL)status {
    
    [circle setNeedsDisplay];
    [square setNeedsDisplay];
    [triangle setNeedsDisplay];
    [hexagon setNeedsDisplay];
    [heart setNeedsDisplay];
    [container removeFromSuperview];
    
    [switchShapes setEnabled:YES];

}

@end
