//
//  TTLayoutSupportSnapshotTest.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTLayoutSupportSnapshotTest.h"
#import "UIViewController+TTLayoutSupport.h"
#import "TTDemoChildViewController.h"
#import "TTDemoScrollViewController.h"
#import "TTDemoTableViewController.h"
#import "TTDemoCollectionViewController.h"

#define V(__identifier) ([NSString stringWithFormat:@"%@-%@", __identifier, [[UIDevice currentDevice] systemVersion]])

@interface TTLayoutSupportSnapshotTest ()

@property (nonatomic, strong) UIView *viewToTest;

@property (nonatomic, strong) TTDemoChildViewController *testViewController;

@end

@implementation TTLayoutSupportSnapshotTest

- (void)setUp
{
    [super setUp];

    //self.recordMode = YES;
    
    self.viewToTest = [UIView new];
    self.viewToTest.frame = CGRectMake(0, 0, 320, 640);
    
    self.testViewController = [[TTDemoChildViewController alloc] init];
    
    // fails sometimes without it
    self.renderAsLayer = YES;
}

- (void)addController:(UIViewController *)controller
{
    [self.viewToTest addSubview:controller.view];
    controller.view.frame = self.viewToTest.bounds;
}

- (void)testTopLayoutGuideWithoutScrollview
{
    [self addController:self.testViewController];

    self.testViewController.tt_bottomLayoutGuideLength = 0;
    
    self.testViewController.tt_topLayoutGuideLength = 0;
    FBSnapshotVerifyView(self.viewToTest, V(@"top 0, bottom 0"));
    
    self.testViewController.tt_topLayoutGuideLength = 50;
    FBSnapshotVerifyView(self.viewToTest, V(@"top 50, bottom 0"));
}

- (void)testBottomLayoutGuideWithoutScrollview
{
    [self addController:self.testViewController];
    
    self.testViewController.tt_topLayoutGuideLength = 0;
    self.testViewController.tt_bottomLayoutGuideLength = 100;
    
    FBSnapshotVerifyView(self.viewToTest, V(@"top 0, bottom 100"));
}

- (void)testBothWithoutScrollView
{
    [self addController:self.testViewController];
    
    self.testViewController.tt_topLayoutGuideLength = 200;
    self.testViewController.tt_bottomLayoutGuideLength = 100;
    
    FBSnapshotVerifyView(self.viewToTest, V(@"top 200, bottom 100"));
}

@end
