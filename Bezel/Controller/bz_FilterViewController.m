//
//  bz_FilterViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_FilterViewController.h"
#import "UIImage+Resize.h"
#import "FlipView.h"

#define ARC4RANDOM_MAX	0x1000000000
#define MAXDELAY 1.15

@interface bz_FilterViewController ()

@property (nonatomic, strong) bz_Button *filter1;
@property (nonatomic, strong) bz_Button *filter2;
@property (nonatomic, strong) bz_Button *filter3;
@property (nonatomic, strong) bz_Button *filter4;
@property (nonatomic, strong) bz_Button *filter5;
@property (nonatomic, strong) bz_Button *filter6;
@property (nonatomic, strong) bz_Button *filter7;
@property (nonatomic, strong) bz_Button *filter8;

@property (strong, nonatomic) NSMutableArray *filterButtons;

@end

@implementation bz_FilterViewController


@synthesize scrollHeight    = _scrollHeight;
@synthesize filter1         = _filter1;
@synthesize filter2         = _filter2;
@synthesize filter3         = _filter3;
@synthesize filter4         = _filter4;
@synthesize filter5         = _filter5;
@synthesize filter6         = _filter6;
@synthesize filter7         = _filter7;
@synthesize filter8         = _filter8;

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

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Top Row Buttons
    CGFloat width       = self.view.frame.size.width;
    CGFloat btnWidth    = width/4.0f;
    CGFloat btnHeight   = self.view.frame.size.height/2.0f;
    UIImage *icon       = [UIImage imageNamed:@"Icon.png"];
    
    _filter1   = [[bz_Button alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight) andTag:1000];
    _filter1.buttonIdentifier = kButtonIdentifierFilterBW1;
    
    _filter2   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth, 0, btnWidth, btnHeight) andTag:1001];
    _filter2.buttonIdentifier = kButtonIdentifierFilterBW2;
    
    _filter3   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*2, 0, btnWidth, btnHeight) andTag:1002];
    _filter3.buttonIdentifier = kButtonIdentifierFilterDarkFade;
    
    _filter4   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*3, 0, btnWidth, btnHeight) andTag:1003];
    _filter4.buttonIdentifier = kButtonIdentifierFilterFaded;
    
    _filter5   = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnHeight, btnWidth, btnHeight) andTag:1004];
    _filter5.buttonIdentifier = kButtonIdentifierFilterGoldenHr;
    
    _filter6   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth, btnHeight, btnWidth, btnHeight) andTag:1005];
    _filter6.buttonIdentifier = kButtonIdentifierFilterOz;
    
    _filter7   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*2, btnHeight, btnWidth, btnHeight) andTag:1006];
    _filter7.buttonIdentifier = kButtonIdentifierFilterSepia;
    
    _filter8   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*3, btnHeight, btnWidth, btnHeight) andTag:1007];
    _filter8.buttonIdentifier = kButtonIdentifierFilterNormal;
    
    
    self.filterButtons = [NSMutableArray arrayWithObjects: _filter1, _filter2, _filter3, _filter4, _filter5, _filter6, _filter7, _filter8, nil];
    
    for (bz_Button *button in self.filterButtons)
    {
        [button setImage:icon forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}

-(void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
