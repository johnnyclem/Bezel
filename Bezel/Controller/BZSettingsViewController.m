//
//  BZSettingsViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "AFNetworking.h"
#import "BZSettingsViewController.h"
#import "BZPromotionView.h"
#import "BZPromotion.h"
#import "BZSettingsCell.h"
#import "BZSetting.h"

@interface BZSettingsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *promotions;
@property (strong, nonatomic) NSArray *settings;
@end

@implementation BZSettingsViewController

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    
    [self.collectionView registerClass:[BZPromotionView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier: BZ_PROMOTION_VIEW_REUSE_IDENTIFIER];
    
    BZSetting *fullRes = [[BZSetting alloc] init];
    fullRes.readableName = @"Photo Quality";
    fullRes.defaultsIdentifier = BZ_SETTINGS_FULL_RESOLUTION_KEY;
    fullRes.valueType = bz_SettingsValueTypeInteger;
    fullRes.value = [NSNumber numberWithInt:[df integerForKey: BZ_SETTINGS_FULL_RESOLUTION_KEY]];
    
    BZSetting *saveToCameraRoll = [[BZSetting alloc] init];
    saveToCameraRoll.readableName = @"Save Original Photo to Camera Roll";
    saveToCameraRoll.defaultsIdentifier = BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY;
    saveToCameraRoll.valueType = bz_SettingsValueTypeBoolean;
    saveToCameraRoll.value = [NSNumber numberWithInt:[df integerForKey: BZ_SETTINGS_SAVE_TO_CAMERA_ROLL_KEY]];
    
    
    self.settings = @[fullRes, saveToCameraRoll];

    [self loadPromotions];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(id)sender
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    UIControl *control = sender;
    BZSetting *setting = self.settings[control.tag];
    
    if ([sender isKindOfClass:[UIStepper class]]) {
        UIStepper *step = sender;
        NSNumber *val = [NSNumber numberWithDouble: step.value];
        [def setValue: val forKey: setting.defaultsIdentifier];
    } else if ([sender isKindOfClass:[UISwitch class]]) {
        UISwitch *toggle = sender;
        NSNumber *val = [NSNumber numberWithBool: toggle.on];
        [def setValue: val forKey: setting.defaultsIdentifier];
    } else if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *segment = sender;
        NSNumber *val = [NSNumber numberWithInt: segment.selectedSegmentIndex];
        LogTrace(@"changing quality to %@", val);
        [def setValue: val forKey: setting.defaultsIdentifier];
    }
    
    [def synchronize];
}

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return self.settings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    BZSetting *setting = self.settings[indexPath.row];
    // Reuse identifier should correspond with LoupeSetting.valueType.
    NSString *reuseIdentifier;
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    
    switch (setting.valueType) {
        case bz_SettingsValueTypeBoolean: {
            reuseIdentifier = BZ_PROMOTION_VALUE_SWITCH_REUSE_IDENTIFIER;
        }
            break;
        case bz_SettingsValueTypeStepper: {
            reuseIdentifier = BZ_PROMOTION_VALUE_STEPPER_REUSE_IDENTIFIER;
        }
            break;
        case bz_SettingsValueTypeInteger: {
            reuseIdentifier = BZ_PROMOTION_VALUE_SEGMENTED_CONTROL_REUSE_IDENTIFIER;
        }
            break;
    }
    
    BZSettingsCell *cell = [cv dequeueReusableCellWithReuseIdentifier: reuseIdentifier forIndexPath:indexPath];
    
    [cell setCurrentValue: [df valueForKey: setting.defaultsIdentifier] forType: setting.valueType];
    
    cell.settingsLabel.text = setting.readableName;
    cell.accessoryView.tag = indexPath.row;
    
    return cell;
}

#pragma mark - Supplementary Views

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    BZPromotionView *supView = [self.collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier: BZ_PROMOTION_VIEW_REUSE_IDENTIFIER forIndexPath: indexPath];
    
    if ([self.promotions objectAtIndex: indexPath.section]) {
        [supView setPromotion:[self.promotions objectAtIndex: indexPath.section]];
    } else {
        // handle err
    }
    
    
    return supView;
}

#pragma mark - Promotions

- (void)loadPromotions
{
#ifdef DEBUG
    BOOL loadRemote = [[NSUserDefaults standardUserDefaults] boolForKey: BZ_SETTINGS_LOAD_REMOTE_PROMOTIONS];
    if (!loadRemote) {
        [self local_loadPromotions];
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
                                                       NSDictionary *promotions = [JSON objectForKey:@"promotions"];
                                                       if (promotions) {
                                                           for (NSDictionary *promo in promotions)
                                                           {
                                                               BZPromotion *aPromotion = [[BZPromotion alloc] initWithDictionary: promo];
                                                               if (aPromotion)
                                                               {
                                                                   // Reload supplementary views.
                                                                   if (!self.promotions) self.promotions = [NSMutableArray arrayWithCapacity: 5]; // arbitrary #, not usually many promotions at once.
                                                                   [self.promotions addObject: aPromotion];
                                                                   [self.collectionView reloadData];
                                                               }
                                                           }
                                                       }
                                                   }
                                               }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                               {
                                                   [self local_loadPromotions];
                                               }];
    
    [fetchPromotions start];
}

- (void)local_loadPromotions
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"promotion" ofType:@"json"];
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
        NSDictionary *promotions = [json objectForKey:@"promotions"];
        if (promotions) {
            for (NSDictionary *promo in promotions)
            {
                BZPromotion *aPromotion = [[BZPromotion alloc] initWithDictionary: promo];
                if (aPromotion)
                {
                    // Reload supplementary views.
                    if (!self.promotions) self.promotions = [NSMutableArray arrayWithCapacity: 5]; // arbitrary #, not usually many promotions at once.
                    [self.promotions addObject: aPromotion];
                    [self.collectionView reloadData];
                }
            }
        }
        else
        {
            // Handle failure.
        }
        
        
    }
    
}


@end