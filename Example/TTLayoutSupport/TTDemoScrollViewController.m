//
//  TTDemoScrollViewController.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTDemoScrollViewController.h"

@interface TTDemoScrollViewController ()

@end

@implementation TTDemoScrollViewController

- (instancetype)init
{
    self = [super init];

    if (self) {
        self.title = @"ScrollView";
    }

    return self;
}

- (void)loadView
{
    self.view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor brownColor];
    
    [self addArrow];
}

- (void)addArrow
{
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    arrow.translatesAutoresizingMaskIntoConstraints = NO;
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:arrow];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(arrow);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[arrow]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[arrow]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
}

@end
