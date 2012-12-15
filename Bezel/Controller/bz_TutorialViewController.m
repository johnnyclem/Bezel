//
//  bz_TutorialViewController.m
//  Bezel
//
//  Created by John Clem on 12/12/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_TutorialViewController.h"
#import "GCPagedScrollView.h"

@interface bz_TutorialViewController ()

@property (nonatomic, readonly) GCPagedScrollView* scrollView;

@end

@implementation bz_TutorialViewController

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
    
    for (NSUInteger index = 0; index < 4; index ++) {
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
    UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20,
                                                            self.view.frame.size.height - 50)];
    if (index == 3) {
        UIButton *close = [[UIButton alloc] initWithFrame:view.frame];
        [close setImage:image forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closeTutorial) forControlEvents:UIControlEventTouchUpInside];
        return close;
    } else {
        [view setImage:image];
    }
    return view;
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
