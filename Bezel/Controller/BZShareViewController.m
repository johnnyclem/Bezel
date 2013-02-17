//
//  BZShareViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZShareViewController.h"
#import "BZButton.h"

@interface BZShareViewController ()
@property (strong, nonatomic) NSArray *shareButtons;
@property (weak, nonatomic) IBOutlet BZButton *facebook;
@property (weak, nonatomic) IBOutlet BZButton *twitter;
@property (weak, nonatomic) IBOutlet BZButton *instagram;
@property (weak, nonatomic) IBOutlet BZButton *cameraRoll;
@property (weak, nonatomic) IBOutlet BZButton *trash;
@end

@implementation BZShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.facebook.buttonIdentifier = kButtonIdentifierFacebook;
        self.twitter.buttonIdentifier = kButtonIdentifierTwitter;
        self.instagram.buttonIdentifier = kButtonIdentifierInstagram;
        self.cameraRoll.buttonIdentifier = kButtonIdentifierCameraRoll;
        self.trash.buttonIdentifier = kButtonIdentifierTrash;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareImage:(BZButton*)sender
{
    
}

@end
