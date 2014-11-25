//
//  TTLayoutSupportTests.m
//  TTLayoutSupportTests
//
//  Created by Steffen Neubauer on 11/25/2014.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "UIViewController+TTLayoutSupport.h"
#import "TTDemoChildViewController.h"
#import "TTDemoScrollViewController.h"
#import "TTDemoTableViewController.h"
#import "TTDemoCollectionViewController.h"

SPEC_BEGIN(InitialTests)

describe(@"TTLayoutSupport", ^{

    
    context(@"without UIScrollView", ^{
        
        __block TTDemoChildViewController *controller;
        __block UIView *superview;
        
        beforeEach(^{
            superview = [UIView new];
            controller = [TTDemoChildViewController new];
            [superview addSubview:controller.view];
        });
        
        it(@"can change the topLayoutGuideLength", ^{
            [[theValue(controller.topLayoutGuide.length) should] equal:@0];
            
            controller.tt_topLayoutGuideLength = 50;
            
            [[theValue(controller.topLayoutGuide.length) should] equal:@50];
        });
        
        it(@"can change the bottomLayoutGuideLength", ^{
            [[theValue(controller.bottomLayoutGuide.length) should] equal:@0];
            
            controller.tt_bottomLayoutGuideLength = 50;
            
            [[theValue(controller.bottomLayoutGuide.length) should] equal:@50];
        });
    });
    
  context(@"without being added to the view hierarchy", ^{

      __block TTDemoChildViewController *controller;

      beforeEach(^{
          controller = [TTDemoChildViewController new];
      });

      it(@"can change the topLayoutGuideLength", ^{
          [[theValue(controller.topLayoutGuide.length) should] equal:@0];

          [[theBlock(^{
              controller.tt_topLayoutGuideLength = 50;
          }) should] raiseWithReason:@"Failed to record topLayoutGuide constraints. Is the controller's view added to the view hierarchy?"];
      });

      it(@"can change the bottomLayoutGuideLength", ^{
          [[theValue(controller.bottomLayoutGuide.length) should] equal:@0];
          
          [[theBlock(^{
              controller.tt_bottomLayoutGuideLength = 50;
          }) should] raiseWithReason:@"Failed to record bottomLayoutGuide constraints. Is the controller's view added to the view hierarchy?"];
      });
  });

  context(@"with UIScrollView", ^{
      
      __block TTDemoScrollViewController *controller;
      __block UIScrollView *scrollView;
      __block UIView *superview;

      beforeEach(^{
          superview = [UIView new];
          controller = [TTDemoScrollViewController new];
          [superview addSubview:controller.view];

          scrollView = (UIScrollView *)controller.view;
          scrollView.frame = CGRectMake(0, 0, 320, 640);
          scrollView.contentSize = CGSizeMake(320, 2000);
      });
      
      it(@"adjusts contentInsets for ScrollViews", ^{
          controller.tt_topLayoutGuideLength = 50;
          controller.tt_bottomLayoutGuideLength = 100;
          
          [[theValue(scrollView.contentInset) should] equal:theValue(UIEdgeInsetsMake(50, 0, 100, 0))];
      });

      it(@"also adjusts contentOffset for ScrollViews so they are scrolled to top", ^{
          controller.tt_topLayoutGuideLength = 50;
          controller.tt_bottomLayoutGuideLength = 100;
          
          [[theValue(scrollView.contentOffset.y) should] equal:@(-50)];
      });
      
      it(@"does not adjust contentOffset for scrollViews that are not scrolled to top at the moment the guide changes", ^{
          scrollView.contentOffset = CGPointMake(0, 44);
          
          controller.tt_topLayoutGuideLength = 20;
          controller.tt_bottomLayoutGuideLength = 100;
          
          [[theValue(scrollView.contentOffset.y) should] equal:@(44)];
      });
      
      it(@"does not adjust contentOffset or contentInset if automaticallyAdjustsScrollViewInsets is true", ^{
          controller.automaticallyAdjustsScrollViewInsets = NO;

          controller.tt_topLayoutGuideLength = 50;
          controller.tt_bottomLayoutGuideLength = 100;
          
          [[theValue(scrollView.contentOffset.y) should] equal:@(0)];
          [[theValue(scrollView.contentInset) should] equal:theValue(UIEdgeInsetsZero)];
      });
      
  });
  
});

SPEC_END
