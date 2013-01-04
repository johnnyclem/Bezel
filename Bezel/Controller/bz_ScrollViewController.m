//
//  bz_ScrollViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ScrollViewController.h"
#import "bz_ScrollView.h"
#import "bz_ShapesViewController.h"
#import "bz_FilterViewController.h"
#import "bz_AdjustmentViewController.h"
#import "bz_BackgroundViewController.h"
#import "bz_ShareViewController.h"
#import "bz_MainViewController.h"
#import "bz_Button.h"

@interface bz_ScrollViewController ()
{
    CGFloat scrollHeight;
    bz_ShapesViewController *shapeVC;
    bz_FilterViewController *filterVC;
    bz_AdjustmentViewController *adjustmentVC;
    bz_BackgroundViewController *backgroundVC;
    bz_ShareViewController *shareVC;
}

@property(nonatomic, strong) IBOutlet bz_ScrollView *scrollView;
@property(nonatomic, strong) bz_MainViewController *mainVC;

@end

@implementation bz_ScrollViewController

@synthesize mainVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addObservers];
    [self setupScrollViewChildren];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)setupScrollViewChildren {
    scrollHeight = self.view.frame.size.height - 380.f;
    
    //setup scrollview
    NSUInteger numberOfPages = 5;
    [_scrollView setContentSize: CGSizeMake(_scrollView.frame.size.width * numberOfPages, scrollHeight)] ;
    [_scrollView setDelegate:self];
    [_scrollView setScrollEnabled:NO];
    
	CGRect pageFrame ;
	for (int i = 0 ; i < numberOfPages ; i++)
	{
        pageFrame = CGRectMake(i * _scrollView.frame.size.width, 0.0f, _scrollView.frame.size.width, scrollHeight);
        switch (i) {
            case 0:
                shapeVC = [[bz_ShapesViewController alloc] init];
                shapeVC.scrollHeight = scrollHeight;
                shapeVC.view.frame = pageFrame;
                [_scrollView addSubview:shapeVC.view];
                break;
            case 1:
                filterVC = [[bz_FilterViewController alloc] init];
                filterVC.scrollHeight = scrollHeight;
                filterVC.view.frame = pageFrame;
                [_scrollView addSubview:filterVC.view];
                break;
            case 2:
                adjustmentVC = [[bz_AdjustmentViewController alloc] init];
                adjustmentVC.scrollHeight = scrollHeight;
                adjustmentVC.view.frame = pageFrame;
                [_scrollView addSubview:adjustmentVC.view];
                break;
            case 3:
                backgroundVC = [[bz_BackgroundViewController alloc] init];
                backgroundVC.scrollHeight = scrollHeight;
                backgroundVC.view.frame = pageFrame;
                [_scrollView addSubview:backgroundVC.view];
                break;
            case 4:
                shareVC = [[bz_ShareViewController alloc] init];
                shareVC.scrollHeight = scrollHeight;
                shareVC.view.frame = pageFrame;
                [_scrollView addSubview:shareVC.view];
                break;
                
            default:
                break;
        }
    }
}

- (void)tearDownScrollViewChildren {

    [shapeVC.view removeFromSuperview];
    [filterVC.view removeFromSuperview];
    [adjustmentVC.view removeFromSuperview];
    [backgroundVC.view removeFromSuperview];
    [shareVC.view removeFromSuperview];

    shapeVC = nil;
    filterVC = nil;
    adjustmentVC = nil;
    backgroundVC = nil;
    shareVC = nil;

}

- (void)removeChildrenImages;
{
    shapeVC.currentImage = nil;
    filterVC.currentImage = nil;
    adjustmentVC.currentImage = nil;
    backgroundVC.currentImage = nil;
    shareVC.currentImage = nil;
}

- (void)addObservers {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToView:) name:@"keepPhoto" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToView:) name:@"StartOver" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableScroll) name:@"disableScroll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableScroll) name:@"enableScroll" object:nil];

}

- (void)removeObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"keepPhoto" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StartOver" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"disableScroll" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"enableScroll" object:nil];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    LogError(@"memory warning. Rebuilding scrollviews");
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Low Memory" message:@"Bezel is experiencing problems due to low available memory. Please close any running background audio/voip applications or lower your photo quality in Settings." delegate:self cancelButtonTitle:@"I'll Take My Chances" otherButtonTitles:@"Change Settings", nil];
//    [alert show];
}


#pragma mark -
#pragma mark UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    [aScrollView setContentOffset: CGPointMake(aScrollView.contentOffset.x, 0)];
    _scrollView.scrollEnabled = YES;
    
    if (aScrollView.contentOffset.x == 0) {
        LogTrace(@"Scroll view is at original position.");
        NSDictionary* dict = [NSDictionary dictionaryWithObject:self forKey:@"scrollVC"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrolledHome" object:self userInfo:dict];
        _scrollView.scrollEnabled = NO;
    } else if (aScrollView.contentOffset.x == 640) {
        adjustmentVC.currentImage = mainVC.currentImage;
        adjustmentVC.contrast   = 1.0;
        adjustmentVC.exposure   = 0.0;
    } else if (aScrollView.contentOffset.x == 960) {
        backgroundVC.currentImage = adjustmentVC.currentImage;
        backgroundVC.mainVC = self.mainVC;
        [backgroundVC changeBackground:backgroundVC.blackBG];
    } else if (aScrollView.contentOffset.x == 1280) {
        shareVC.currentImage = backgroundVC.currentImage;
    }

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
    
}

- (void)pageControlClicked:(id)sender {
    
}

- (void)disableScroll {
    _scrollView.scrollEnabled = NO;
}

- (void)enableScroll {
    _scrollView.scrollEnabled = YES;
}

- (void)scrollToView:(NSNotification*)notification {
    
    NSNumber *viewIndex = [notification.userInfo objectForKey:@"scrollPosition"];
    [self.scrollView setContentOffset:CGPointMake(320*viewIndex.intValue, 0) animated:YES];
    
    if ([notification.userInfo objectForKey:@"mainVC"]) {
        mainVC = [notification.userInfo objectForKey:@"mainVC"];
    }
}


@end
