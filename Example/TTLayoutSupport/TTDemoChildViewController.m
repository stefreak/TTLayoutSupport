//
//  TTViewController.m
//  TTLayoutSupport
//
//  Created by Steffen Neubauer on 11/25/2014.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTDemoChildViewController.h"

@interface TTDemoChildViewController ()

@end

@implementation TTDemoChildViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.title = @"No ScrollView";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addViewRelativeToTopLayoutGuide];
    [self addViewRelativeToBottomLayoutGuide];
}

- (void)addViewRelativeToTopLayoutGuide
{
    UILabel *topLabel = [UILabel new];
    topLabel.text = @"↑ topLayoutGuide";
    topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:topLabel];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
}

- (void)addViewRelativeToBottomLayoutGuide
{
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.text = @"↓ bottomLayoutGuide";
    bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:bottomLabel];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomLabel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bottomLayoutGuide
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
}

@end
