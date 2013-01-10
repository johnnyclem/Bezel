//
//  bz_ScrollViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ScrollViewController.h"
#import "bz_MainViewController.h"
#import "bz_Button.h"

@interface bz_ScrollViewController ()
{
    CGFloat scrollHeight;
}

@property(nonatomic, strong) bz_MainViewController *mainVC;

@end

@implementation bz_ScrollViewController

@synthesize mainVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        scrollHeight = self.view.frame.size.height - 380.f;
        CGRect scrollViewFrame = CGRectMake(0.0, 380.0, self.view.frame.size.width, scrollHeight);
        _scrollView = [[bz_ScrollView alloc] initWithFrame: scrollViewFrame];
        _scrollView.pagingEnabled = TRUE;
        _scrollView.showsHorizontalScrollIndicator = FALSE;
        _scrollView.showsVerticalScrollIndicator = FALSE;
        
        [self.view addSubview: _scrollView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)setupScrollViewChildren
{
    [self addObservers];
    
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
                self.shapesViewController = [[bz_ShapesViewController alloc] init];
                self.shapesViewController.scrollHeight = scrollHeight;
                self.shapesViewController.view.frame = pageFrame;
                [_scrollView addSubview: self.shapesViewController.view];
                break;
            case 1:
                self.filterViewController = [[bz_FilterViewController alloc] init];
                self.filterViewController.scrollHeight = scrollHeight;
                self.filterViewController.view.frame = pageFrame;
                [_scrollView addSubview: self.filterViewController.view];
                break;
            case 2:
                self.adjustmentViewController = [[bz_AdjustmentViewController alloc] init];
                self.adjustmentViewController.scrollHeight = scrollHeight;
                self.adjustmentViewController.view.frame = pageFrame;
                [_scrollView addSubview: self.adjustmentViewController.view];
                break;
            case 3:
                self.backgroundViewController = [[bz_BackgroundViewController alloc] init];
                self.backgroundViewController.scrollHeight = scrollHeight;
                self.backgroundViewController.view.frame = pageFrame;
                [_scrollView addSubview: self.backgroundViewController.view];
                break;
            case 4:
                self.shareViewController = [[bz_ShareViewController alloc] init];
                self.shareViewController.scrollHeight = scrollHeight;
                self.shareViewController.view.frame = pageFrame;
                [_scrollView addSubview: self.shareViewController.view];
                break;
                
            default:
                break;
        }
    }
}

- (void)tearDownScrollViewChildren {

    [self.shapesViewController.view removeFromSuperview];
    [self.filterViewController.view removeFromSuperview];
    [self.adjustmentViewController.view removeFromSuperview];
    [self.backgroundViewController.view removeFromSuperview];
    [self.shareViewController.view removeFromSuperview];

    self.shapesViewController = nil;
    self.filterViewController = nil;
    self.adjustmentViewController = nil;
    self.backgroundViewController = nil;
    self.shareViewController = nil;
}

- (void)removeChildrenImages;
{
    self.shapesViewController.currentImage = nil;
    self.filterViewController.currentImage = nil;
    self.adjustmentViewController.currentImage = nil;
    self.backgroundViewController.currentImage = nil;
    self.shareViewController.currentImage = nil;
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
        self.adjustmentViewController.currentImage = mainVC.currentImage;
    } else if (aScrollView.contentOffset.x == 960) {
        self.backgroundViewController.currentImage = self.adjustmentViewController.currentImage;
        self.backgroundViewController.mainVC = self.mainVC;
        [self.backgroundViewController changeBackground: self.backgroundViewController.blackBG];
    } else if (aScrollView.contentOffset.x == 1280) {
        self.shareViewController.currentImage = self.backgroundViewController.currentImage;
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

- (void)scrollToView:(NSNotification*)notification
{

}

- (void)scrollToViewControllerAtIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(320*index, 0) animated:YES];
}


@end
