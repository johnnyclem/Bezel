//
//  bz_BackgroundViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_BackgroundViewController.h"
#import "FlipView.h"

@interface bz_BackgroundViewController ()
{
    UIView *colorPickerView;
    UIView *dismissColorPickerView;
    
    bz_Button *blackBG;
    bz_Button *whiteBG;
    bz_Button *clearBG;
    bz_Button *switchBG;
    
    AnimationDelegate *animationDelegate;
    FlipView *container;
}

@end

@implementation bz_BackgroundViewController

@synthesize scrollHeight = _scrollHeight;

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
    
    CGFloat btnOffset   = (_scrollHeight-100);

    // Top Row Buttons
    CGFloat btnWidth    = 80.f;
    CGFloat btnHeight   = 100.f;

    blackBG  = [[bz_Button alloc] initWithFrame:CGRectMake(80, btnOffset/2, btnWidth, btnHeight)];
    whiteBG  = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnOffset/2, btnWidth, btnHeight)];
    clearBG  = [[bz_Button alloc] initWithFrame:CGRectMake(160, btnOffset/2, btnWidth, btnHeight)];
    switchBG = [[bz_Button alloc] initWithFrame:CGRectMake(240, btnOffset/2, btnWidth, btnHeight)];
    
    blackBG.buttonIdentifier = kButtonIdentifierBlackBackground;
    whiteBG.buttonIdentifier = kButtonIdentifierWhiteBackground;
    clearBG.buttonIdentifier = kButtonIdentifierClearBackground;
    switchBG.buttonIdentifier = kButtonIdentifierSwitchBackground;
    
    self.backgroundButtons = [NSArray arrayWithObjects: whiteBG, blackBG, clearBG, switchBG, nil];
    
    [whiteBG setTag:23];
    [blackBG setTag:24];
    [clearBG setTag:25];
    [switchBG setTag:39];
    
    [self.view addSubview:whiteBG];
    [self.view addSubview:blackBG];
    [self.view addSubview:clearBG];
    [self.view addSubview:switchBG];
}

-(void)switchBackgroundSet:(id)sender {
    
    UIImage *holidayBG  = [UIImage imageNamed:@"holidayBackgrounds.png"];
    UIImage *stdBG      = [UIImage imageNamed:@"standardBackgrounds.png"];
    LogTrace(@"button with tag: %i called for switch", [(bz_Button*)sender tag]);
    // Create a container view for the shape button animation
    animationDelegate = [[AnimationDelegate alloc] initWithSequenceType:kSequenceAuto directionType:kDirectionForward];
    animationDelegate.controller = self;
    animationDelegate.perspectiveDepth = 200;
    animationDelegate.repeat = NO;
    
    container = [[FlipView alloc] initWithAnimationType:kAnimationFlipVertical frame:CGRectMake(0.f, (_scrollHeight-100.f)/2.f, 320.f, 100.f)];
    animationDelegate.transformView = container;
    
    [self.view addSubview:container];
    
    switch ([(bz_Button*)sender tag]) {
        case 39:
            [(bz_Button*)sender setTag:139];
            LogTrace(@"switching to xmas backgrounds");
            [container printText:nil usingImage:holidayBG backgroundColor:nil textColor:nil];
            [container printText:nil usingImage:stdBG backgroundColor:nil textColor:nil];
            
            [whiteBG setTag:124];
            [blackBG setTag:123];
            [clearBG setTag:125];
            
            break;
        case 139:
            [(bz_Button*)sender setTag:39];
            LogTrace(@"switching to standard backgrounds");
            [container printText:nil usingImage:stdBG backgroundColor:nil textColor:nil];
            [container printText:nil usingImage:holidayBG backgroundColor:nil textColor:nil];
            
            [whiteBG setTag:23];
            [blackBG setTag:24];
            [clearBG setTag:25];
            
            break;
        default:
            break;
    }
    
    [(bz_Button*)sender setEnabled:NO];
    [animationDelegate startAnimation:kDirectionForward];

}

- (void)animationDidFinish:(BOOL)status {
    
    [blackBG setNeedsDisplay];
    [whiteBG setNeedsDisplay];
    [clearBG setNeedsDisplay];

    [container removeFromSuperview];
    container = nil;
    animationDelegate = nil;
    
    [switchBG setEnabled:YES];
    
}


//-(void)colorPickerDidChangeSelection:(RSColorPickerView *)cp {
//	_bgColor = [cp selectionColor];
//    colorPickerView.backgroundColor = _bgColor;
//}
//
//-(void)colorPickerDidFinishWithSelection:(RSColorPickerView *)cp {
//    _bgColor = [cp selectionColor];
//    [self changeBackground:nil];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
