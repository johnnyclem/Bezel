//
//  bz_FilterViewController.m
//  Bezel
//
//  Created by John Clem on 12/4/12.
//  Copyright (c) 2012 Mind Diaper. All rights reserved.
//

#import "bz_FilterViewController.h"
#import "UIImage+Resize.h"
#import "FlipView.h"

#define ARC4RANDOM_MAX	0x1000000000
#define MAXDELAY 1.15

@interface bz_FilterViewController ()

@property (nonatomic, strong) bz_Button *filter1;
@property (nonatomic, strong) bz_Button *filter2;
@property (nonatomic, strong) bz_Button *filter3;
@property (nonatomic, strong) bz_Button *filter4;
@property (nonatomic, strong) bz_Button *filter5;
@property (nonatomic, strong) bz_Button *filter6;
@property (nonatomic, strong) bz_Button *filter7;
@property (nonatomic, strong) bz_Button *filter8;

@property (strong, nonatomic) NSMutableArray *filterButtons;

@end

@implementation bz_FilterViewController


@synthesize scrollHeight    = _scrollHeight;
@synthesize currentThumb    = _currentThumb;
@synthesize currentMask     = _currentMask;
@synthesize filter1         = _filter1;
@synthesize filter2         = _filter2;
@synthesize filter3         = _filter3;
@synthesize filter4         = _filter4;
@synthesize filter5         = _filter5;
@synthesize filter6         = _filter6;
@synthesize filter7         = _filter7;
@synthesize filter8         = _filter8;

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
    
    // Top Row Buttons
    CGFloat width       = self.view.frame.size.width;
    CGFloat btnWidth    = width/4.0f;
    CGFloat btnHeight   = _scrollHeight/2.0f;
    UIImage *icon       = [UIImage imageNamed:@"Icon.png"];
    
    _filter1   = [[bz_Button alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight) andTag:1000];
    _filter1.buttonIdentifier = kButtonIdentifierFilterBW1;
    
    _filter2   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth, 0, btnWidth, btnHeight) andTag:1001];
    _filter2.buttonIdentifier = kButtonIdentifierFilterBW2;
    
    _filter3   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*2, 0, btnWidth, btnHeight) andTag:1002];
    _filter3.buttonIdentifier = kButtonIdentifierFilterDarkFade;
    
    _filter4   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*3, 0, btnWidth, btnHeight) andTag:1003];
    _filter4.buttonIdentifier = kButtonIdentifierFilterFaded;
    
    _filter5   = [[bz_Button alloc] initWithFrame:CGRectMake(0, btnHeight, btnWidth, btnHeight) andTag:1004];
    _filter5.buttonIdentifier = kButtonIdentifierFilterGoldenHr;
    
    _filter6   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth, btnHeight, btnWidth, btnHeight) andTag:1005];
    _filter6.buttonIdentifier = kButtonIdentifierFilterOz;
    
    _filter7   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*2, btnHeight, btnWidth, btnHeight) andTag:1006];
    _filter7.buttonIdentifier = kButtonIdentifierFilterSepia;
    
    _filter8   = [[bz_Button alloc] initWithFrame:CGRectMake(btnWidth*3, btnHeight, btnWidth, btnHeight) andTag:1007];
    _filter8.buttonIdentifier = kButtonIdentifierFilterNormal;
    
    
    self.filterButtons = [NSMutableArray arrayWithObjects: _filter1, _filter2, _filter3, _filter4, _filter5, _filter6, _filter7, _filter8, nil];
    
    for (bz_Button *button in self.filterButtons)
    {
        [button setImage:icon forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];
}

-(void)setupFilterPreviews:(NSNotification *)notification {
    
    self.currentImage = [notification.userInfo objectForKey:@"newImage"];
    self.currentThumb = [self.currentImage resizedImage:CGSizeMake(160, 160) interpolationQuality:kCGInterpolationLow];
    
    if (self.currentImage != nil) {

        
        for (int i=1000; i<1008; i++) {
            bz_Button *button = [self buttonFromTag:[NSNumber numberWithInt:i]];
            bz_FilterViewController *this = self;
            __block UIImage *filteredImage;

            void (^filterThumb)(void) = ^ {
                UIImage *inputImage;
                
                switch (i) {
                    case 1000:
                        inputImage = [UIImage imageNamed:@"B&W1.png"];
                        break;
                    case 1001:
                        inputImage = [UIImage imageNamed:@"B&W2.png"];
                        break;
                    case 1002:
                        inputImage = [UIImage imageNamed:@"blue.png"];
                        break;
                    case 1003:
                        inputImage = [UIImage imageNamed:@"DarkFade.png"];
                        break;
                    case 1004:
                        inputImage = [UIImage imageNamed:@"faded.png"];
                        break;
                    case 1005:
                        inputImage = [UIImage imageNamed:@"GoldenHr.png"];
                        break;
                    case 1006:
                        inputImage = [UIImage imageNamed:@"oz.png"];
                        break;
                    case 1007:
                        inputImage = [UIImage imageNamed:@"Sepia.png"];
                        break;
                    default:
                        inputImage = [UIImage imageNamed:@"normal.png"];
                        break;
                }

                GPUImageLookupFilter *lookupFilter  = [[GPUImageLookupFilter alloc] init];
                GPUImagePicture *stillImageSource   = [[GPUImagePicture alloc] initWithImage:inputImage];
                GPUImagePicture *sourceImage        = [[GPUImagePicture alloc] initWithImage:this.currentThumb];
                
                [sourceImage addTarget:lookupFilter];
                [sourceImage processImage];
                [stillImageSource addTarget:lookupFilter atTextureLocation:1];
                [stillImageSource processImage];
                filteredImage = [lookupFilter imageFromCurrentlyProcessedOutput];
                [button setImage:filteredImage forState:UIControlStateNormal];
                [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
            };
            
            filterThumb();
            [button setNeedsDisplay];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (bz_Button*)buttonFromTag:(NSNumber*)tag {
    
    switch ([tag intValue]) {
        case 1000:
            return _filter1;
        case 1001:
            return _filter2;
        case 1002:
            return _filter3;
        case 1003:
            return _filter4;
        case 1004:
            return _filter5;
        case 1005:
            return _filter6;
        case 1006:
            return _filter7;
        case 1007:
            return _filter8;
        default:
            return _filter1;
    }

}

@end
