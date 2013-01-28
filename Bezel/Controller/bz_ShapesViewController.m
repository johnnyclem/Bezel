//
//  bz_ShapesViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_ShapesViewController.h"
#import "bz_MainViewController.h"

#import "BZMaskAdjustmentCollectionViewCell.h"
#import "BZMaskAdjustment.h"

#import "AFNetworking.h"
#import "PocketSVG.h"

@interface bz_ShapesViewController ()

@property (strong, nonatomic) NSMutableArray *shapes;
@property (nonatomic, assign, getter = isShowingAllShapes) BOOL showAllShapes;

@end

@implementation bz_ShapesViewController

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
    
    CGRect shapesCollectionViewFrame = CGRectMake(0.0, 0.0, 320.0, 50.0);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(50.0, 50.0)];
    
    self.shapesCollectionView = [[UICollectionView alloc] initWithFrame: shapesCollectionViewFrame collectionViewLayout: layout];
    self.shapesCollectionView.contentInset = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0);
    self.shapesCollectionView.dataSource = self;
    self.shapesCollectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"BZMaskAdjustmentCollectionViewCell" bundle: [NSBundle mainBundle]];
    [self.shapesCollectionView registerNib: nib forCellWithReuseIdentifier: BZ_MASK_ADJUSTMENT_CELL_REUSE_IDENTIFIER];

    [self.view addSubview: self.shapesCollectionView];
    
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
    
    NSURL *url = [NSURL URLWithString:@"http://minddiaper.com/ads/bezel.json"];
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
    BZMaskAdjustmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: BZ_MASK_ADJUSTMENT_CELL_REUSE_IDENTIFIER forIndexPath: indexPath];
    
    BZMaskAdjustment *mask = [self.shapes objectAtIndex: indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.layer.mask = [mask layerMaskForSize: cell.frame.size];
    
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
        return 4.0; // default amount to show
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.switchShapeBlock([self.shapes objectAtIndex: indexPath.row]);
}


@end
