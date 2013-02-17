//
//  BZStoreViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "BZStoreViewController.h"
#import "MAConfirmButton.h"
#import "SVProgressHUD.h"

#define HOLIDAY_PACK_ID @"bz_holidayPack"
#define COLOR_PICKER_ID @"bz_colorPicker"
#define PRO_SHAPE_PACK_ID @"bz_proShapePack"

@interface BZStoreViewController ()

@property (nonatomic, strong) IBOutlet UIView *holidayBG;
@property (nonatomic, strong) IBOutlet UIView *colorPickerBG;
@property (nonatomic, strong) IBOutlet UIView *proShapeBG;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@end

@implementation BZStoreViewController

@synthesize scrollView  = _scrollView;
@synthesize navBar      = _navBar;
@synthesize pageControl = _pageControl;
@synthesize buyColorPickerButton, buyHolidayPackButton, buyProShapePackButton;

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
    _navBar.frame = CGRectMake(0, -1, 320, 44);

    buyHolidayPackButton = [MAConfirmButton buttonWithTitle:@"installed" confirm:@"Buy Now"];
    [buyHolidayPackButton addTarget:self action:@selector(purchaseHolidayPack) forControlEvents:UIControlEventTouchUpInside];
    [buyHolidayPackButton setTintColor:[UIColor colorWithRed:0.3922 green:0.5686 blue:0.9333 alpha:1.0]];
    [buyHolidayPackButton setAnchor:CGPointMake(930, 265)];
    buyHolidayPackButton.enabled = NO;
    [_scrollView addSubview:buyHolidayPackButton];

    buyProShapePackButton = [MAConfirmButton buttonWithTitle:@"installed" confirm:@"Buy Now"];
    [buyProShapePackButton addTarget:self action:@selector(purchaseProShapePack) forControlEvents:UIControlEventTouchUpInside];
    [buyProShapePackButton setTintColor:[UIColor colorWithRed:0.3922 green:0.5686 blue:0.9333 alpha:1.0]];
    [buyProShapePackButton setAnchor:CGPointMake(610, 265)];
    buyProShapePackButton.enabled = NO;
    [_scrollView addSubview:buyProShapePackButton];

    buyColorPickerButton = [MAConfirmButton buttonWithTitle:@"installed" confirm:@"Buy Now"];
    [buyColorPickerButton addTarget:self action:@selector(purchaseColorPicker) forControlEvents:UIControlEventTouchUpInside];
    [buyColorPickerButton setTintColor:[UIColor colorWithRed:0.3922 green:0.5686 blue:0.9333 alpha:1.0]];
    [buyColorPickerButton setAnchor:CGPointMake(290, 265)];
    buyColorPickerButton.enabled = NO;
    [_scrollView addSubview:buyColorPickerButton];

//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"patternBG.png"]];
    _scrollView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44);
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width*3, _scrollView.frame.size.height)];
    
    holidayPackPurchase = [[EBPurchase alloc] init];
    holidayPackPurchase.delegate = self;
    
    colorPickerPurchase = [[EBPurchase alloc] init];
    colorPickerPurchase.delegate = self;

    proShapePackPurchase = [[EBPurchase alloc] init];
    proShapePackPurchase.delegate = self;

    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    holidayPackIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_HOLIDAY_PACK_PURCHASE_KEY] boolValue];
    colorPickerIsPurchased   = [(NSNumber*)[standard objectForKey: BZ_COLOR_PICKER_PURCHASE_KEY] boolValue];
    proShapePackIsPurchased  = [(NSNumber*)[standard objectForKey: BZ_PRO_SHAPE_PACK_PURCHASE_KEY] boolValue];
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _pageControl.frame = CGRectMake(_pageControl.frame.origin.x, self.view.frame.size.height-40.f, _pageControl.frame.size.width, _pageControl.frame.size.height);
    
    if (!holidayPackIsPurchased) {
        buyHolidayPackButton.enabled = YES;
        [buyHolidayPackButton setTitle:@"0.99" forState:UIControlStateNormal];
        [holidayPackPurchase requestProduct:HOLIDAY_PACK_ID];
    }
    if (!colorPickerIsPurchased) {
        buyColorPickerButton.enabled = YES;
        [buyColorPickerButton setTitle:@"0.99" forState:UIControlStateNormal];
        [colorPickerPurchase requestProduct:COLOR_PICKER_ID];
    }
    if (!proShapePackIsPurchased) {
        buyProShapePackButton.enabled = YES;
        [buyProShapePackButton setTitle:@"0.99" forState:UIControlStateNormal];
        [proShapePackPurchase requestProduct:PRO_SHAPE_PACK_ID];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    [aScrollView setContentOffset: CGPointMake(aScrollView.contentOffset.x, 0)];
    int offset = aScrollView.contentOffset.x;
    
    switch (offset) {
        case 0:
            [_pageControl setCurrentPage:0];
            break;
        case 320:
            [_pageControl setCurrentPage:1];
            break;
        case 640:
            [_pageControl setCurrentPage:2];
            break;
        default:
            break;
    }
}

-(void)purchaseHolidayPack
{
    if (holidayPackPurchase.validProduct != nil)
    {
        if (![holidayPackPurchase purchaseProduct:holidayPackPurchase.validProduct])
        {
            // Returned NO, so notify user that In-App Purchase is Disabled in their Settings.
            UIAlertView *settingsAlert = [[UIAlertView alloc] initWithTitle:@"Allow Purchases" message:@"You must first enable In-App Purchase in your iOS Settings before making this purchase." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [settingsAlert show];
        }
    }
}

-(void)purchaseColorPicker
{
    if (colorPickerPurchase.validProduct != nil)
    {
        if (![colorPickerPurchase purchaseProduct:colorPickerPurchase.validProduct])
        {
            // Returned NO, so notify user that In-App Purchase is Disabled in their Settings.
            UIAlertView *settingsAlert = [[UIAlertView alloc] initWithTitle:@"Allow Purchases" message:@"You must first enable In-App Purchase in your iOS Settings before making this purchase." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [settingsAlert show];
        }
    }
}

-(void)purchaseProShapePack
{
    if (proShapePackPurchase.validProduct != nil)
    {
        if (![proShapePackPurchase purchaseProduct:proShapePackPurchase.validProduct])
        {
            // Returned NO, so notify user that In-App Purchase is Disabled in their Settings.
            UIAlertView *settingsAlert = [[UIAlertView alloc] initWithTitle:@"Allow Purchases" message:@"You must first enable In-App Purchase in your iOS Settings before making this purchase." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [settingsAlert show];
        }
    }
}

-(IBAction)restorePurchase
{
    // Restore a customer's previous non-consumable or subscription In-App Purchase.
    // Required if a user reinstalled app on same device or another device.
    
    // Call restore method.
    if (![colorPickerPurchase restorePurchase])
    {
        if (![holidayPackPurchase restorePurchase]) {
            // Returned NO, so notify user that In-App Purchase is Disabled in their Settings.
            UIAlertView *settingsAlert = [[UIAlertView alloc] initWithTitle:@"Allow Purchases" message:@"You must first enable In-App Purchase in your iOS Settings before restoring a previous purchase." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [settingsAlert show];

        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark EBPurchaseDelegate Methods

-(void) requestedProduct:(EBPurchase*)ebp identifier:(NSString*)productId name:(NSString*)productName price:(NSString*)productPrice description:(NSString*)productDescription
{
    LogInfo(@"ViewController requestedProduct: %@", productDescription);
    
    if ([productId isEqualToString:HOLIDAY_PACK_ID]) {

        if (productPrice != nil)
        {
            // Product is available, so update button title with price.
            [buyHolidayPackButton setTitle:[@"" stringByAppendingString:productPrice] forState:UIControlStateNormal];
            buyHolidayPackButton.enabled = YES; // Enable buy button.
        }
        else {
        // Product is NOT available in the App Store, so notify user.
            [buyHolidayPackButton setTitle:@"Sold Out" forState:UIControlStateNormal];
            buyHolidayPackButton.enabled = NO; // Disable buy button.

            UIAlertView *unavailAlert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"The Holiday Pack is not available in the App Store at this time. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [unavailAlert show];
        }

    } else if([productId isEqualToString:COLOR_PICKER_ID]) {
        
        if (productPrice != nil) {
            [buyColorPickerButton setTitle:[@"" stringByAppendingString:productPrice] forState:UIControlStateNormal];
            buyColorPickerButton.enabled = YES; // Enable buy button.
        } else {
            [buyColorPickerButton setTitle:@"Sold Out" forState:UIControlStateNormal];
            buyColorPickerButton.enabled = NO; // Disable buy button.
            
            UIAlertView *unavailAlert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"The Color Picker is not available in the App Store at this time. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [unavailAlert show];
        }
    } else if([productId isEqualToString:COLOR_PICKER_ID]) {
    
    if (productPrice != nil) {
        [buyColorPickerButton setTitle:[@"" stringByAppendingString:productPrice] forState:UIControlStateNormal];
        buyColorPickerButton.enabled = YES; // Enable buy button.
    } else {
        [buyColorPickerButton setTitle:@"Sold Out" forState:UIControlStateNormal];
        buyColorPickerButton.enabled = NO; // Disable buy button.
        
        UIAlertView *unavailAlert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"The Color Picker is not available in the App Store at this time. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [unavailAlert show];
    }
}

}

-(void) successfulPurchase:(EBPurchase*)ebp restored:(bool)isRestore identifier:(NSString*)productId receipt:(NSData*)transactionReceipt
{
    LogInfo(@"ViewController successfulPurchase");
    
    // Purchase or Restore request was successful, so...
    // 1 - Unlock the purchased content for your new customer!
    // 2 - Notify the user that the transaction was successful.
    
    if ([productId isEqualToString:HOLIDAY_PACK_ID]) {
        if (!holidayPackIsPurchased)
        {
            holidayPackIsPurchased = YES;
            NSString *alertMessage;
            if (isRestore) {
                // This was a Restore request.
                alertMessage = @"Your purchase was restored and the Holiday Pack is now unlocked!";
                
            } else {
                // This was a Purchase request.
                alertMessage = @"Your purchase was successful and the Holiday Pack is now unlocked!";
            }

            NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
            [standard setObject:[NSNumber numberWithBool:TRUE] forKey: BZ_HOLIDAY_PACK_PURCHASE_KEY];
            [standard synchronize];
            UIAlertView *updatedAlert = [[UIAlertView alloc] initWithTitle:@"Thank You!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [updatedAlert show];
        }
    }
    else if ([productId isEqualToString:PRO_SHAPE_PACK_ID]) {
        if (!proShapePackIsPurchased)
        {
            proShapePackIsPurchased = YES;
            NSString *alertMessage;
            if (isRestore) {
                // This was a Restore request.
                alertMessage = @"Your purchase was restored and the Pro Shape Pack is now unlocked!";
                
            } else {
                // This was a Purchase request.
                alertMessage = @"Your purchase was successful and the Pro Shape Pack is now unlocked!";
            }

            NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
            [standard setObject:[NSNumber numberWithBool:TRUE] forKey: BZ_PRO_SHAPE_PACK_PURCHASE_KEY];
            [standard synchronize];
            UIAlertView *updatedAlert = [[UIAlertView alloc] initWithTitle:@"Thank You!" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [updatedAlert show];
            
        }
    }

}

-(void) failedPurchase:(EBPurchase*)ebp error:(NSInteger)errorCode message:(NSString*)errorMessage
{
    LogError(@"ViewController failedPurchase");
    
    // Purchase or Restore request failed or was cancelled, so notify the user.
    
    UIAlertView *failedAlert = [[UIAlertView alloc] initWithTitle:@"Purchase Stopped" message:@"Either you cancelled the request or Apple reported a transaction error. Please try again later, or contact the app's customer support for assistance." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [failedAlert show];
}

-(void) incompleteRestore:(EBPurchase*)ebp
{
    LogError(@"ViewController incompleteRestore");
    
    // Restore queue did not include any transactions, so either the user has not yet made a purchase
    // or the user's prior purchase is unavailable, so notify user to make a purchase within the app.
    // If the user previously purchased the item, they will NOT be re-charged again, but it should
    // restore their purchase.
    
    UIAlertView *restoreAlert = [[UIAlertView alloc] initWithTitle:@"Restore Issue" message:@"A prior purchase transaction could not be found. To restore the purchased product, tap the Buy button. Paid customers will NOT be charged again, but the purchase will be restored." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [restoreAlert show];
}

-(void) failedRestore:(EBPurchase*)ebp error:(NSInteger)errorCode message:(NSString*)errorMessage
{
    LogError(@"ViewController failedRestore");
    
    // Restore request failed or was cancelled, so notify the user.
    
    UIAlertView *failedAlert = [[UIAlertView alloc] initWithTitle:@"Restore Stopped" message:@"Either you cancelled the request or your prior purchase could not be restored. Please try again later, or contact the app's customer support for assistance." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [failedAlert show];
}

- (CAGradientLayer*) backgroundLayer {
	
	UIColor *colorOne		= [UIColor colorWithWhite:0.9 alpha:1.0];
	UIColor *colorTwo		= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
	UIColor *colorThree	    = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
	UIColor *colorFour		= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
    
	NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
	
	NSNumber *stopOne		= [NSNumber numberWithFloat:0.0];
	NSNumber *stopTwo		= [NSNumber numberWithFloat:0.02];
	NSNumber *stopThree	    = [NSNumber numberWithFloat:0.99];
	NSNumber *stopFour		= [NSNumber numberWithFloat:1.0];
	
	NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
	
	CAGradientLayer *headerLayer = [CAGradientLayer layer];
	//headerLayer.frame = CGRectMake(0.0, 0.0, 320.0, 77.0);
	headerLayer.colors = colors;
	headerLayer.locations = locations;
	
	return headerLayer;
}

@end
