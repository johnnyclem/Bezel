//
//  BZStoreViewController.h
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZViewController.h"
#import "EBPurchase.h"
#import "MAConfirmButton.h"

@interface BZStoreViewController : BZViewController <EBPurchaseDelegate, UIScrollViewDelegate> {
    
    EBPurchase* holidayPackPurchase;
    EBPurchase* colorPickerPurchase;
    EBPurchase* proShapePackPurchase;
    
    BOOL holidayPackIsPurchased;
    BOOL colorPickerIsPurchased;
    BOOL proShapePackIsPurchased;

}

@property(nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UINavigationBar *navBar;
@property(nonatomic, strong) MAConfirmButton *buyHolidayPackButton;
@property(nonatomic, strong) MAConfirmButton *buyColorPickerButton;
@property(nonatomic, strong) MAConfirmButton *buyProShapePackButton;

-(IBAction)purchaseHolidayPack;
-(IBAction)purchaseColorPicker;
-(IBAction)purchaseProShapePack;
-(IBAction)restorePurchase;

@end
