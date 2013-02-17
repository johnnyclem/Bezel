//
//  BZShapesViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZShapesViewController.h"
#import "BZMainViewController.h"

#import "BZMaskAdjustmentCollectionViewCell.h"
#import "BZMaskAdjustment.h"

#import "AFNetworking.h"

@interface BZShapesViewController ()

@property (strong, nonatomic) NSMutableArray *shapes;
@property (nonatomic, assign, getter = isShowingAllShapes) BOOL showAllShapes;

@end

@implementation BZShapesViewController

- (id)init
{
    if (self = [super init])
    {
        // Capacity is arbitrary but used for optimization.
        self.shapes = [NSMutableArray arrayWithCapacity: 50];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self fetchShapes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button actions

- (void)showMoreShapes
{
//    self.showAllShapes = TRUE;
//    self.shapesCollectionView.scrollEnabled = TRUE;
//    [self.shapesCollectionView reloadData];
//    
//    [UIView animateWithDuration: 0.5 animations: ^(void) {
//        self.shapesCollectionView.frame = self.view.frame;
//     } completion: ^(BOOL completion) {
//    }];
}

#pragma mark - BZMaskAdjustment fetching

- (void)fetchShapes
{
#ifdef DEBUG
    BOOL loadRemote = [[NSUserDefaults standardUserDefaults] boolForKey: BZ_SETTINGS_LOAD_REMOTE_SHAPES];
    if (!loadRemote) {
        [self local_fetchShapes];
        return;
    }
#endif
    
    // TODO Need URL for shapes feed. We should have a whole directory for bezel feeds.
    NSURL *url = [NSURL URLWithString:@"http://www.minddiaper.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *fetchPromotions = [AFJSONRequestOperation
                                               JSONRequestOperationWithRequest:request
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                               {
                                                   if (response.statusCode == 200) {
                                                       NSDictionary *shapes = [JSON objectForKey:@"shapes"];
                                                       if (shapes) {
                                                           for (NSDictionary *maskAdj in shapes)
                                                           {
                                                               BZMaskAdjustment *adj = [[BZMaskAdjustment alloc] initWithDictionary: maskAdj];
                                                               if (adj)
                                                               {
                                                                   // Add new shapes then reload data.
                                                                   if (!self.shapes) self.shapes = [NSMutableArray arrayWithCapacity: 50]; // arbitrary # for performance.
                                                                   [self.shapes addObject: adj];
                                                                   [self.shapesCollectionView reloadData];
                                                               }
                                                           }
                                                       }
                                                   }
                                               }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                               {
                                                   [self local_fetchShapes];
                                               }];
    
    [fetchPromotions start];
}

- (void)local_fetchShapes
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shapes" ofType:@"json"];
    NSError *fileErr;
    NSData *jsonData = [NSData dataWithContentsOfFile: filePath options: NSDataReadingMappedIfSafe error: &fileErr];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingAllowFragments error: &fileErr];
    
    // Failure Block (if it were remote)
    if (fileErr)
    {
        // Handle failure.
    }
    
    // Success Block (if it were remote)
    else
    {
        NSDictionary *shapes = [json objectForKey:@"shapes"];
        if (shapes) {
            for (NSDictionary *maskAdj in shapes)
            {
                BZMaskAdjustment *adj = [[BZMaskAdjustment alloc] initWithDictionary: maskAdj];
                if (adj)
                {
                    // Reload supplementary views.
                    if (!self.shapes) self.shapes = [NSMutableArray arrayWithCapacity: 50]; // arbitrary # for performance.
                    [self.shapes addObject: adj];
                    [self.shapesCollectionView reloadData];
                }
            }
        }
        else
        {
            // Handle failure.
        }
    }
}

#pragma mark - UICollectionView Data Source Methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BZMaskAdjustmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: BZ_SHAPE_ADJUSTMENT_CELL forIndexPath: indexPath];
    
    // Protect against array out of bounds since we might not be finished loading all of them in.
    if (self.shapes.count >= indexPath.row)
    {
        BZMaskAdjustment *mask = [self.shapes objectAtIndex: indexPath.row];
        
        // Layout, UI
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.mask = [mask layerMaskForSize: cell.frame.size];
        
        // Accesibility
        cell.accessibilityLabel = mask.shapeAccessibilityLabel;
        cell.accessibilityHint = mask.shapeAccessibilityHint;
    }

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isShowingAllShapes)
    {
        return self.shapes.count;
    }
    else
    {
        // Show 4 default shapes, as long as there are shapes to show!
        return (self.shapes.count >= 5) ? 5.0 : 0.0; // default amount to show
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.showAllShapes)
//    {
//        self.showAllShapes = FALSE;
//        self.shapesCollectionView.scrollEnabled = FALSE;
//        
//        [UIView animateWithDuration: 0.5 animations: ^(void) {
//            self.shapesCollectionView.frame = CGRectMake(0.0, 0.0, 290.0, 50.0);
//        } completion: ^(BOOL completion) {
//        }];
//    }
    
    self.switchShapeBlock([self.shapes objectAtIndex: indexPath.row]);
}


@end
