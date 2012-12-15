//
//  bz_SettingsViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_SettingsViewController.h"
#import "bz_AdView.h"
#import "bz_SettingsCell.h"
#import "bz_Setting.h"

NSString* const bz_SettingsFullResolutionKey = @"full_resolution";

@interface bz_SettingsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *settings;
@end

@implementation bz_SettingsViewController

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    
    [self.collectionView registerClass:[bz_AdView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"bz_AdView"];
    
    bz_Setting *fullRes = [[bz_Setting alloc] init];
    fullRes.readableName = @"Photo Quality";
    fullRes.defaultsIdentifier = bz_SettingsFullResolutionKey;
    fullRes.valueType = bz_SettingsValueTypeInteger;
    fullRes.value = [NSNumber numberWithInt:[df integerForKey: bz_SettingsFullResolutionKey]];
    
    self.settings = @[fullRes];
    
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
    bz_Setting *setting = self.settings[control.tag];
    
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
        NSLog(@"changing quality to %@", val);
        [def setValue: val forKey: setting.defaultsIdentifier];
    }
    
    [def synchronize];
}

- (IBAction)loadAppStoreLink:(id)sender {
    NSLog(@"loading cinepro");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/us/app/cinepro/id522585198?mt=8&uo=4"]];
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
    bz_Setting *setting = self.settings[indexPath.row];
    // Reuse identifier should correspond with LoupeSetting.valueType.
    NSString *reuseIdentifier;
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    
    switch (setting.valueType) {
        case bz_SettingsValueTypeBoolean: {
            reuseIdentifier = @"Switch";
        }
            break;
        case bz_SettingsValueTypeStepper: {
            reuseIdentifier = @"Stepper";
        }
            break;
        case bz_SettingsValueTypeInteger: {
            reuseIdentifier = @"SegmentedControl";
        }
            break;
    }
    
    bz_SettingsCell *cell = [cv dequeueReusableCellWithReuseIdentifier: reuseIdentifier forIndexPath:indexPath];
    
    if (bz_SettingsValueTypeInteger) {
        [(UISegmentedControl*)cell.accessoryView setSelectedSegmentIndex:[df integerForKey: bz_SettingsFullResolutionKey]];
    }
    cell.settingsLabel.text = setting.readableName;
    cell.accessoryView.tag = indexPath.row;
    
    return cell;
}

#pragma mark - Supplementary Views

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    bz_AdView *supView = [self.collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"bz_AdView" forIndexPath: indexPath];
    
    
    
    return supView;
}


@end