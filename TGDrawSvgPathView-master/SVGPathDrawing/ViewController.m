//
//  ViewController.m
//  SVGPathDrawing
//
//  Created by Thibault Guégan on 08/07/2014.
//  Copyright (c) 2014 Skyr. All rights reserved.
//

#import "ViewController.h"
#import "TGDrawSvgPathView.h"

@interface ViewController ()

@property (nonatomic, strong) CAShapeLayer* shapeView;
@property (nonatomic, strong) TGDrawSvgPathView* tgView;
@property (nonatomic)         CFTimeInterval animationDuration;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mySlider.minimumValue = 2;
    self.mySlider.maximumValue = 5;
    
    NSInteger val = lround(self.mySlider.value);
    
    _animationDuration = (float) val;
    
    [_lblDuration setText:[NSString stringWithFormat:@"duration: %ld s", val]];
    
    _tgView = [[TGDrawSvgPathView alloc] initWithFrame:CGRectMake(40.0, 70.0, 250.0, 250.0)];
    [_tgView setPathFromSvg:@"anchor" strokeColor:[UIColor blackColor] duration:_animationDuration];
    [self.view addSubview:_tgView];
}


- (IBAction)btnSvgAnchor:(id)sender {
    _tgView.layer.sublayers = nil;
    
    [_tgView setPathFromSvg:@"anchor" strokeColor:[UIColor blackColor] duration:_animationDuration];
}
- (IBAction)btnSvgCircle:(id)sender {
    _tgView.layer.sublayers = nil;
    
    [_tgView setPathFromSvg:@"circle" strokeColor:[UIColor blackColor] duration:_animationDuration];
}
- (IBAction)btnSvgHexagon:(id)sender {
    _tgView.layer.sublayers = nil;
    
    [_tgView setPathFromSvg:@"hexagon" strokeColor:[UIColor blackColor] duration:_animationDuration];
}
- (IBAction)btnSvgOrnament:(id)sender {
    _tgView.layer.sublayers = nil;
    
    [_tgView setPathFromSvg:@"ornament" strokeColor:[UIColor blackColor] duration:_animationDuration];
}
- (IBAction)btnSvgOval:(id)sender {
    _tgView.layer.sublayers = nil;
    
    [_tgView setPathFromSvg:@"oval" strokeColor:[UIColor blackColor] duration:_animationDuration];
}
- (IBAction)btnSvgXmasTree:(id)sender {
    _tgView.layer.sublayers = nil;
    
    [_tgView setPathFromSvg:@"xmas_tree" strokeColor:[UIColor blackColor] duration:_animationDuration];
}


- (IBAction)sliderChanged:(id)sender {
    
    NSInteger val = lround(self.mySlider.value);
    
    _animationDuration = (float) val;
    
    [_lblDuration setText:[NSString stringWithFormat:@"duration: %ld s", val]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
