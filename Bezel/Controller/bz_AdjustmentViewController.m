//
//  bz_AdjustmentViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_AdjustmentViewController.h"
#import "GPUImageExposure+Contrast.h"

@interface bz_AdjustmentViewController ()

@end

@implementation bz_AdjustmentViewController

@synthesize scrollHeight = _scrollHeight;
@synthesize currentImage = _currentImage;
@synthesize contrast     = _contrast;
@synthesize exposure     = _exposure;

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
    
    CGFloat width       = self.view.frame.size.width;
    CGFloat btnOffset   = (_scrollHeight-100.f)/2.f;
    CGFloat btnWidth    = width/2.f;
    CGFloat btnHeight   = _scrollHeight/2.f;
    
    bz_Button *leftBar  = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnOffset, btnWidth, btnHeight)];
    bz_Button *rightBar = [[bz_Button alloc] initWithFrame:CGRectMake(160, btnOffset, btnWidth, btnHeight)];
    bz_Button *expUp    = [[bz_Button alloc] initWithFrame:CGRectMake(leftBar.center.x-80, leftBar.center.y-(btnOffset+22), btnWidth, 44)];
    bz_Button *expDown  = [[bz_Button alloc] initWithFrame:CGRectMake(leftBar.center.x-80, leftBar.center.y+22, btnWidth, 44)];
    bz_Button *contUp   = [[bz_Button alloc] initWithFrame:CGRectMake(rightBar.center.x-80, rightBar.center.y-(btnOffset+22), btnWidth, 44)];
    bz_Button *contDown = [[bz_Button alloc] initWithFrame:CGRectMake(rightBar.center.x-80, rightBar.center.y+22, btnWidth, 44)];
    
    [expUp setTag:17];
    [expDown setTag:18];
    [contUp setTag:19];
    [contDown setTag:20];
    [leftBar setTag:21];
    [rightBar setTag:22];
    
    [leftBar setEnabled:NO];
    [leftBar setShowsTouchWhenHighlighted:NO];
    [rightBar setEnabled:NO];
    [rightBar setShowsTouchWhenHighlighted:NO];

    [self.view addSubview:expUp];
    [self.view addSubview:expDown];
    [self.view addSubview:contUp];
    [self.view addSubview:contDown];
    [self.view addSubview:leftBar];
    [self.view addSubview:rightBar];
        
    [expUp addTarget:self action:@selector(adjustImage:) forControlEvents:UIControlEventTouchUpInside];
    [expDown addTarget:self action:@selector(adjustImage:) forControlEvents:UIControlEventTouchUpInside];
    [contUp addTarget:self action:@selector(adjustImage:) forControlEvents:UIControlEventTouchUpInside];
    [contDown addTarget:self action:@selector(adjustImage:) forControlEvents:UIControlEventTouchUpInside];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

-(void)adjustImage:(bz_Button*)sender {
    
    switch (sender.tag) {
        case 17:
            _exposure = _exposure + 0.125;
            break;
        case 18:
            _exposure = _exposure - 0.125;
            break;
        case 19:
            _contrast = _contrast + 0.125;
            break;
        case 20:
            _contrast = _contrast - 0.125;
            break;
        default:
            
            break;
    }
    
    GPUImageExposure_Contrast *filter = [[GPUImageExposure_Contrast alloc] initWithContrast:_contrast andExposure:_exposure];
    UIImage *adjustedImage = [filter imageByFilteringImage:self.currentImage];
    NSDictionary *newFilteredImage = [NSDictionary dictionaryWithObject:adjustedImage forKey:@"newFilteredImage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"filterImage" object:self userInfo:newFilteredImage];

    
}

@end
