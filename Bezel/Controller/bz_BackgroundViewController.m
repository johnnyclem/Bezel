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
    
    bz_Button *whiteBG;
    bz_Button *clearBG;
    bz_Button *switchBG;
    
    AnimationDelegate *animationDelegate;
    FlipView *container;

    BOOL colorPickerIsPurchased;
    BOOL holidayPackIsPurchased;

}

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic) BOOL bgIsColor;

@end

@implementation bz_BackgroundViewController

@synthesize scrollHeight = _scrollHeight;
@synthesize mainVC       = _mainVC;
@synthesize bgColor      = _bgColor;
@synthesize bgImage      = _bgImage;
@synthesize bgIsColor, blackBG;

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
    bgIsColor = YES;
    _bgColor = [UIColor blackColor];
    
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    holidayPackIsPurchased = [(NSNumber*)[standard objectForKey: BZ_HOLIDAY_PACK_PURCHASE_KEY] boolValue];
    colorPickerIsPurchased = [(NSNumber*)[standard objectForKey: BZ_COLOR_PICKER_PURCHASE_KEY] boolValue];

    CGFloat btnOffset   = (_scrollHeight-100);

    // Top Row Buttons
    CGFloat btnWidth    = 80.f;
    CGFloat btnHeight   = 100.f;
    
    whiteBG  = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnOffset/2, btnWidth, btnHeight)];
    blackBG  = [[bz_Button alloc] initWithFrame:CGRectMake(80, btnOffset/2, btnWidth, btnHeight)];
    clearBG  = [[bz_Button alloc] initWithFrame:CGRectMake(160, btnOffset/2, btnWidth, btnHeight)];
    switchBG = [[bz_Button alloc] initWithFrame:CGRectMake(240, btnOffset/2, btnWidth, btnHeight)];
    
    [whiteBG setTag:23];
    [blackBG setTag:24];
    [clearBG setTag:25];
    [switchBG setTag:39];
    
    [self.view addSubview:whiteBG];
    [self.view addSubview:blackBG];
    [self.view addSubview:clearBG];
    [self.view addSubview:switchBG];
    
    [whiteBG addTarget:self action:@selector(changeBackground:) forControlEvents:UIControlEventTouchUpInside];
    [blackBG addTarget:self action:@selector(changeBackground:) forControlEvents:UIControlEventTouchUpInside];
    [clearBG addTarget:self action:@selector(changeBackground:) forControlEvents:UIControlEventTouchUpInside];
    [switchBG addTarget:self action:@selector(switchBackgroundSet:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)changeBackground:(id)sender {
    
    bz_Button *button = (bz_Button*)sender;
    NSDictionary *newBackground;
    float mWidth = self.view.frame.size.height;
    
    if (button.tag <= 24) {
        bgIsColor = YES;
        switch (button.tag) {
            case 23:
                _bgColor = [UIColor whiteColor];
                break;
            case 24:
                _bgColor = [UIColor blackColor];
                break;
        }
        newBackground = [NSDictionary dictionaryWithObject:_bgColor forKey:@"newBGColor"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newBackground" object:self userInfo:newBackground];
    } else if (button.tag == 25) {
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        colorPickerIsPurchased = [(NSNumber*)[standard objectForKey: BZ_COLOR_PICKER_PURCHASE_KEY] boolValue];
        
        if (!colorPickerIsPurchased) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buyColorPicker" object:nil userInfo:nil];
        } else {
            LogTrace(@"Color picker is purchased");
            colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake(0, 0, mWidth, mWidth)];
            colorPicker.delegate = self;
            [colorPicker setCropToCircle:NO];
            colorPickerView = [[UIView alloc] initWithFrame:CGRectMake(0, mWidth, 320, mWidth)];
            [colorPickerView setOpaque:YES];
            colorPickerView.backgroundColor = [UIColor blackColor];
            
            brightnessSlider = [[RSBrightnessSlider alloc] initWithFrame:CGRectMake(mWidth+10, (mWidth-30)/2, 300-mWidth, 30)];
            [brightnessSlider setColorPicker:colorPicker];
            [brightnessSlider setUseCustomSlider:YES];
            
            dismissColorPickerView = [[UIView alloc] initWithFrame:CGRectMake(0, -60, 320, 60)];
            dismissColorPickerView.backgroundColor = [UIColor blackColor];
            
            colorPickerView.center = CGPointMake(colorPickerView.center.x, colorPickerView.center.y+mWidth);
            [self.view addSubview:colorPickerView];
            [_mainVC.view addSubview:dismissColorPickerView];
            [colorPickerView addSubview:colorPicker];
            [colorPickerView addSubview:brightnessSlider];
            
            bz_Button *yes = [[bz_Button alloc] initWithFrame:CGRectMake(25.f, 5.f, 50.f, 50.f)];
            yes.tag = 33;
            [yes addTarget:self action:@selector(keepNewColor) forControlEvents:UIControlEventTouchUpInside];
            
            bz_Button *no = [[bz_Button alloc] initWithFrame:CGRectMake(245.f, 5.f, 50.f, 50.f)];
            [no addTarget:self action:@selector(revertBackground) forControlEvents:UIControlEventTouchUpInside];
            no.tag = 34;
            
            [dismissColorPickerView addSubview:yes];
            [dismissColorPickerView addSubview:no];
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 colorPickerView.frame = CGRectMake(0, 0, 320, mWidth);
                                 dismissColorPickerView.frame = CGRectMake(0, 0, 320, 60);
                             }
                             completion:^(BOOL finished){
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"disableScroll" object:nil];
                             }];
        }
    } else if (button.tag >= 123) {
        bgIsColor = NO;
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        holidayPackIsPurchased = [(NSNumber*)[standard objectForKey: BZ_HOLIDAY_PACK_PURCHASE_KEY] boolValue];

        if (!holidayPackIsPurchased) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buyHolidayPack" object:nil userInfo:nil];
        } else {
            int quality = [standard integerForKey:@"full_resolution"];
            switch (button.tag) {
                case 123:
                    switch (quality) {
                        case 1:
                            _bgImage = [UIImage imageNamed:@"candyCaneBG_1024.png"];
                            break;
                        case 2:
                            _bgImage = [UIImage imageNamed:@"candyCaneBG.png"];
                            break;
                        default:
                            _bgImage = [UIImage imageNamed:@"candyCaneBG_640.png"];
                            break;
                    }
                    break;
                case 124:
                    switch (quality) {
                        case 1:
                            _bgImage = [UIImage imageNamed:@"treeBG_1024.jpg"];
                            break;
                        case 2:
                            _bgImage = [UIImage imageNamed:@"treeBG.jpg"];
                            break;
                        default:
                            _bgImage = [UIImage imageNamed:@"treeBG_640.jpg"];
                            break;
                    }
                    break;
                case 125:
                    switch (quality) {
                        case 1:
                            _bgImage = [UIImage imageNamed:@"goldTreeBG_1024.png"];
                            break;
                        case 2:
                            _bgImage = [UIImage imageNamed:@"goldTreeBG.png"];
                            break;
                        default:
                            _bgImage = [UIImage imageNamed:@"goldTreeBG_640.png"];
                            break;
                    }
                    break;
            }
            newBackground = [NSDictionary dictionaryWithObject:_bgImage forKey:@"newBGImage"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"newBackground" object:self userInfo:newBackground];
        }
    } 
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


-(void)colorPickerDidChangeSelection:(RSColorPickerView *)cp {
	_bgColor = [cp selectionColor];
    colorPickerView.backgroundColor = _bgColor;
}

-(void)colorPickerDidFinishWithSelection:(RSColorPickerView *)cp {
    _bgColor = [cp selectionColor];
    [self changeBackground:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keepNewColor {
    
    
    bgIsColor = YES;
    [UIView animateWithDuration:0.5
                     animations:^{
                         colorPickerView.frame = CGRectMake(0, colorPickerView.frame.size.height, 320, colorPickerView.frame.size.height);
                         dismissColorPickerView.frame = CGRectMake(0, -60, 320, 60);
                     }
                     completion:^(BOOL finished){
                         [colorPickerView removeFromSuperview];
                         [dismissColorPickerView removeFromSuperview];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"enableScroll" object:nil];
                     }];
}

- (void)revertBackground {

    [self changeBackground:blackBG];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         colorPickerView.frame = CGRectMake(0, colorPickerView.frame.size.height, 320, colorPickerView.frame.size.height);
                         dismissColorPickerView.frame = CGRectMake(0, -60, 320, 60);
                     }
                     completion:^(BOOL finished){
                         [colorPickerView removeFromSuperview];
                         [dismissColorPickerView removeFromSuperview];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"enableScroll" object:nil];
                     }];
}

@end
