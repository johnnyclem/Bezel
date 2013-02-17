//
//  BZTutorialViewController.m
//  Bezel
//
//  Created by John Clem on 12/12/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZTutorialViewController.h"
#import "GCPagedScrollView.h"
#import "BZAppDelegate.h"

@interface BZTutorialViewController ()

@property (nonatomic, readonly) GCPagedScrollView* scrollView;

@end

@implementation BZTutorialViewController

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
    GCPagedScrollView* scrollView = [[GCPagedScrollView alloc] initWithFrame:self.view.frame];
    scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.view = scrollView;

    self.scrollView.backgroundColor = [UIColor blackColor];
    
    for (NSUInteger index = 0; index < 5; index ++) {
        //You add your content views here
        UIImage *image;
        switch (index) {
            case 0:
                image = [UIImage imageNamed:@"tutorial1.jpg"];
                break;
            case 1:
                image = [UIImage imageNamed:@"tutorial2.jpg"];
                break;
            case 2:
                image = [UIImage imageNamed:@"tutorial3.jpg"];
                break;
            case 3:
                image = [UIImage imageNamed:@"tutorial4.jpg"];
                break;                
            case 4:
                image = [UIImage imageNamed:@"tutorial5.jpg"];
                break;
            default:
                break;
        }
        [self.scrollView addContentSubview:[self createViewAtIndex:index withImage:image]];
    }

}

#pragma mark -
#pragma mark Getters

- (GCPagedScrollView *)scrollView {
    return (GCPagedScrollView*) self.view;
}

#pragma mark -
#pragma mark Helper methods

- (UIView *)createViewAtIndex:(NSUInteger)index withImage:(UIImage*)image {
    UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (index == 4) {
        UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 320, 440)];
        [close setImage:image forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closeTutorial) forControlEvents:UIControlEventTouchUpInside];
        UIButton *connect = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 320, 55)];
        [connect addTarget:self action:@selector(authButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [close addSubview:connect];
        return close;
    } else {
        [view setImage:image];
    }
    return view;
}

- (void)authButtonAction:(id)sender {
    BZAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    [appDelegate openSessionWithAllowLoginUI:YES];
    [self closeTutorial];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeTutorial {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
