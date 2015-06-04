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

@interface UIView (LayoutSubtree)

- (void)tt_layoutAllSubviews;

@end

@implementation UIView (LayoutSubtree)

- (void)tt_layoutAllSubviews
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self layoutSubviews];

    for (UIView *view in self.subviews) {
        [view tt_layoutAllSubviews];
    }
}

@end

@interface TTLayoutSupportSnapshotTest ()

@property (nonatomic, strong) UIView *viewToTest;

@property (nonatomic, strong) TTDemoChildViewController *withoutScrollView;

@property (nonatomic, strong) TTDemoScrollViewController *plainScrollView;

@property (nonatomic, strong) UIViewController *storyboard;

@end

@implementation TTLayoutSupportSnapshotTest

- (void)setUp
{
    [super setUp];
    
    //self.recordMode = YES;
    
    self.viewToTest = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    
    self.withoutScrollView = [[TTDemoChildViewController alloc] init];
    self.plainScrollView = [[TTDemoScrollViewController alloc] init];
    self.storyboard = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Storyboard Controller"];
    
    // fails sometimes without it
    self.renderAsLayer = YES;
}

- (void)addController:(UIViewController *)controller
{
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.viewToTest addSubview:controller.view];
    controller.view.frame = self.viewToTest.bounds;
    
//    self.viewToTest = controller.view;
//    self.viewToTest.frame = CGRectMake(0, 0, 320, 640);
//    [self.viewToTest setNeedsLayout];
}

- (void)verify:(NSString *)identifier
{
    [self.viewToTest tt_layoutAllSubviews];
    FBSnapshotVerifyView(self.viewToTest, identifier);
}

#pragma mark - without scrollview

- (void)testTopLayoutGuideWithoutScrollview
{
    [self addController:self.withoutScrollView];

    self.withoutScrollView.tt_bottomLayoutGuide.length = 0;
    
    self.withoutScrollView.tt_topLayoutGuide.length = 0;
    [self verify:V(@"top 0, bottom 0 - w_o scrollview")];
    
    self.withoutScrollView.tt_topLayoutGuide.length = 50;
    [self verify:V(@"top 50, bottom 0 - w_o scrollview")];
}

- (void)testBottomLayoutGuideWithoutScrollview
{
    [self addController:self.withoutScrollView];
    
    self.withoutScrollView.tt_topLayoutGuide.length = 0;
    self.withoutScrollView.tt_bottomLayoutGuide.length = 100;
    
    [self verify:V(@"top 0, bottom 100 - w_o scrollview")];
}

- (void)testBothWithoutScrollView
{
    [self addController:self.withoutScrollView];
    
    self.withoutScrollView.tt_topLayoutGuide.length = 200;
    self.withoutScrollView.tt_bottomLayoutGuide.length = 100;
    
    [self verify:V(@"top 200, bottom 100 - w_o scrollview")];
}

#pragma mark - plan scrollview

- (void)testTopLayoutGuideWithPlainScrollview
{
    [self addController:self.plainScrollView];
    
    self.plainScrollView.tt_bottomLayoutGuide.length = 0;
    
    self.plainScrollView.tt_topLayoutGuide.length = 0;
    [self verify:V(@"top 0, bottom 0 - plain scrollview")];

    self.plainScrollView.tt_topLayoutGuide.length = 50;
    [self verify:V(@"top 50, bottom 0 - plain scrollview")];
}

- (void)testBottomLayoutGuideWithPlainScrollview
{
    [self addController:self.plainScrollView];
    
    self.plainScrollView.tt_topLayoutGuide.length = 0;
    self.plainScrollView.tt_bottomLayoutGuide.length = 100;
    
    [self verify:V(@"top 0, bottom 100 - plain scrollview")];
}

- (void)testBothWithPlainScrollview
{
    [self addController:self.plainScrollView];
    
    self.plainScrollView.tt_topLayoutGuide.length = 200;
    self.plainScrollView.tt_bottomLayoutGuide.length = 100;
    
    [self verify:V(@"top 200, bottom 100 - plain scrollview")];
}


#pragma mark - without scrollview

- (void)testTopLayoutGuideStoryboard
{
    [self addController:self.storyboard];
    
    self.storyboard.tt_bottomLayoutGuide.length = 0;
    
    self.storyboard.tt_topLayoutGuide.length = 0;
    [self verify:V(@"top 0, bottom 0 - storyboard")];
    
    self.storyboard.tt_topLayoutGuide.length = 50;
    [self verify:V(@"top 50, bottom 0 - storyboard")];
}

- (void)testBottomLayoutGuideStoryboard
{
    [self addController:self.storyboard];
    
    self.storyboard.tt_topLayoutGuide.length = 0;
    self.storyboard.tt_bottomLayoutGuide.length = 100;
    
    [self verify:V(@"top 0, bottom 100 - storyboard")];
}

- (void)testBothStoryboard
{
    [self addController:self.storyboard];
    
    self.storyboard.tt_topLayoutGuide.length = 200;
    self.storyboard.tt_bottomLayoutGuide.length = 100;
    
    [self verify:V(@"top 200, bottom 100 - storyboard")];
}

@end
