//
//  TTDemoParentViewController.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTDemoParentViewController.h"
#import "UIViewController+TTLayoutSupport.h"

@interface TTDemoParentViewController ()

@property (nonatomic, strong) UIViewController *childViewController;

@property (nonatomic, strong) UISlider *topSlider;

@property (nonatomic, strong) UISlider *bottomSlider;

@end

@implementation TTDemoParentViewController

- (instancetype)initWithChildViewController:(UIViewController *)childViewController
{
    self = [super init];

    if (self) {
        self.childViewController = childViewController;
        self.title = self.childViewController.title;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewController];
    [self addTopBar];
    [self addBottomBar];
    
    
    self.tabBarItem.title = self.title;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    self.topSlider.minimumValue = self.topLayoutGuide.length + self.topSlider.superview.frame.size.height;
    self.bottomSlider.minimumValue = self.bottomLayoutGuide.length + self.bottomSlider.superview.frame.size.height;
    
    self.topSlider.maximumValue = self.topSlider.minimumValue * 4;
    self.bottomSlider.maximumValue = self.bottomSlider.minimumValue * 4;
    
    [self topSliderDidChange:self.topSlider];
    [self bottomSliderDidChange:self.bottomSlider];
    
    [self.view layoutSubviews];
}

#pragma mark - UISlider actions

- (void)topSliderDidChange:(UISlider *)topSlider
{
    // change topLayoutGuide of child viewController
    self.childViewController.tt_topLayoutGuideLength = topSlider.value;
}

- (void)bottomSliderDidChange:(UISlider *)bottomSlider
{
    // change bottomLayoutGuide of child viewController
    self.childViewController.tt_bottomLayoutGuideLength = bottomSlider.value;
}

#pragma mark - manage view hierarchy

- (void)addChildViewController
{
    [self.childViewController willMoveToParentViewController:self];
    [self.view addSubview:self.childViewController.view];
    [self addChildViewController:self.childViewController];
    
    self.childViewController.view.frame = self.view.bounds;
    self.childViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)addTopBar
{
    UIView *topBar = [UIView new];
    topBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    topBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    UISlider *topSlider = [[UISlider alloc] init];
    topSlider.translatesAutoresizingMaskIntoConstraints = NO;
    
    [topSlider addTarget:self action:@selector(topSliderDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [topBar addSubview:topSlider];
    [self.view addSubview:topBar];
    
    id<UILayoutSupport>topLayoutGuide = self.topLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(topBar, topSlider, topLayoutGuide);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[topSlider]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[topSlider]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topBar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][topBar(44)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    self.topSlider = topSlider;
}

- (void)addBottomBar
{
    UIView *bottomBar = [UIView new];
    bottomBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    bottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    UISlider *bottomSlider = [[UISlider alloc] init];
    bottomSlider.translatesAutoresizingMaskIntoConstraints = NO;
    
    [bottomSlider addTarget:self action:@selector(bottomSliderDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [bottomBar addSubview:bottomSlider];
    [self.view addSubview:bottomBar];
    
    id<UILayoutSupport>bottomLayoutGuide = self.bottomLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(bottomBar, bottomSlider, bottomLayoutGuide);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[bottomSlider]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[bottomSlider]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomBar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomBar(44)][bottomLayoutGuide]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    self.bottomSlider = bottomSlider;
}

@end
