//
//  BZFilterViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZFiltersAdjustmentsController.h"
#import "BZFilterCollectionViewCell.h"
#import "BZBrightnessContrastCollectionViewCell.h"

#import "BZSession.h"
#import "BZFilterAdjustment.h"

@interface BZFiltersAdjustmentsController ()
@property (strong, nonatomic) NSMutableArray *filteredImages;
@property (strong, nonatomic) NSArray *filterAdjustments;
@property (strong, nonatomic) NSArray *filterTypes;
@end

@implementation BZFiltersAdjustmentsController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        self.filteredImages = [NSMutableArray arrayWithCapacity:8];
        self.filterTypes = [NSArray arrayWithObjects:
                            kButtonIdentifierFilterBW1,
                            kButtonIdentifierFilterBW2,
                            kButtonIdentifierFilterBlue,
                            kButtonIdentifierFilterDarkFade,
                            kButtonIdentifierFilterFaded,
                            kButtonIdentifierFilterGoldenHr,
                            kButtonIdentifierFilterOz,
                            kButtonIdentifierFilterSepia,
                            kButtonIdentifierFilterNormal, nil];
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

#pragma mark - Filter Image

- (void)filterImage:(UIImage *)image
{
    if (image)
    {
        // always clear old buttons
        if (self.filteredImages.count > 0)
        {
            [self.filteredImages removeAllObjects];
        }
        
        NSMutableArray *tempAdjs = [NSMutableArray arrayWithCapacity: 8];
        
        for (NSString *type in self.filterTypes)
        {
            BZFilterAdjustment *adjustment = [[BZFilterAdjustment alloc] init];
            adjustment.value = [NSDictionary dictionaryWithObjectsAndKeys: type, kButtonIdentifier, nil];
            adjustment.identifier = kAdjustmentTypeFilter;
            UIImage *filteredImg = [adjustment filteredImageWithImage: image];
            [tempAdjs addObject: adjustment];
            [self.filteredImages addObject: filteredImg];
        }
        
        self.filterAdjustments = tempAdjs;
        
        [self.collectionView reloadSections: [NSIndexSet indexSetWithIndex: 0]];
    }
}

#pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.filteredImages.count;
    }
    else if (section == 1)
    {
        return 1;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            BZFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: BZ_FILTER_CELL forIndexPath: indexPath];
            
            cell.filterPreview.image = [self.filteredImages objectAtIndex: indexPath.row] ? [self.filteredImages objectAtIndex: indexPath.row] : cell.filterPreview.image;
            
            return cell;
        }
            break;
        case 1:
        {
            BZBrightnessContrastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BZ_BRIGHTNESS_CONTRAST_ADJUSTMENT_CELL forIndexPath: indexPath];

            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BZFilterAdjustment *adj = [self.filterAdjustments objectAtIndex: indexPath.row];
    self.addFilterBlock(adj);
}

#pragma mark - UICollectionView Flow Layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return CGSizeMake(50.0, 50.0);
        }
            break;
        case 1:
        {
            return CGSizeMake(310.0, 50.0);
        }
            break;
        default:
            break;
    }
    
    return CGSizeZero;
}

@end
