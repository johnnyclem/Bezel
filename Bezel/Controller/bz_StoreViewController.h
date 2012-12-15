//
//  bz_StoreViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bz_ViewController.h"
#import "EBPurchase.h"
#import "MAConfirmButton.h"

@interface bz_StoreViewController : bz_ViewController <EBPurchaseDelegate, UIScrollViewDelegate> {
    
    EBPurchase* holidayPackPurchase;
    EBPurchase* colorPickerPurchase;
    
    BOOL holidayPackIsPurchased;
    BOOL colorPickerIsPurchased;

}

@property(nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UINavigationBar *navBar;
@property(nonatomic, strong) MAConfirmButton *buyHolidayPackButton;
@property(nonatomic, strong) MAConfirmButton *buyColorPickerButton;

-(IBAction)purchaseHolidayPack;
-(IBAction)purchaseColorPicker;
-(IBAction)restorePurchase;

@end
