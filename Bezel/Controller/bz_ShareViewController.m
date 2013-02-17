//
//  bz_ShareViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ShareViewController.h"

@interface bz_ShareViewController ()
@property (strong, nonatomic) NSArray *shareButtons;
@end

@implementation bz_ShareViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // Top Row Buttons
    CGFloat width       = self.view.frame.size.width;
    CGFloat height       = self.view.frame.size.height;
    CGFloat btnOffset   = ((height-88)/2)+25;
    CGFloat btnWidth    = width/5.f;
    CGFloat btnHeight   = 50.f;
    
    bz_Button *facebook     = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnOffset, btnWidth, btnHeight)];
    bz_Button *twitter      = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth, btnOffset, btnWidth, btnHeight)];
    bz_Button *instagram    = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*2, btnOffset, btnWidth, btnHeight)];
    bz_Button *cameraRoll   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*3, btnOffset, btnWidth, btnHeight)];
    bz_Button *trash        = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*4, btnOffset, btnWidth, btnHeight)];
    
    facebook.buttonIdentifier = kButtonIdentifierFacebook;
    twitter.buttonIdentifier = kButtonIdentifierTwitter;
    instagram.buttonIdentifier = kButtonIdentifierInstagram;
    cameraRoll.buttonIdentifier = kButtonIdentifierCameraRoll;
    trash.buttonIdentifier = kButtonIdentifierTrash;
    
    self.shareButtons = [NSArray arrayWithObjects: facebook, twitter, instagram, cameraRoll, trash, nil];
    
    [facebook setTag:26];
    [twitter setTag:27];
    [instagram setTag:28];
    [cameraRoll setTag:29];
    [trash setTag:30];
    
    [self.view addSubview:facebook];
    [self.view addSubview:twitter];
    [self.view addSubview:instagram];
    [self.view addSubview:cameraRoll];
    [self.view addSubview:trash];
    
    [facebook addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    [twitter addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    [instagram addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    [cameraRoll addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    [trash addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareImage:(bz_Button*)sender {
        
    NSDictionary *sharePhoto = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:sender.tag] forKey:@"sharePhotoTag"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sharePhoto" object:self userInfo:sharePhoto];
    
    
}

@end
