//
//  UIViewController+TTLayoutSupport.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "UIViewController+TTLayoutSupport.h"
#import <objc/runtime.h>

@implementation UIViewController (TTLayoutSupport)

- (TTLayoutGuide *)tt_topLayoutGuide
{
    TTLayoutGuide *topLayoutGuide = objc_getAssociatedObject(self, @selector(tt_topLayoutGuide));
    
    if (!topLayoutGuide) {
        topLayoutGuide = [[TTLayoutGuide alloc] initWithViewController:self
                                                   layoutGuideSelector:@selector(topLayoutGuide)];
        
        objc_setAssociatedObject(self, @selector(tt_topLayoutGuide), topLayoutGuide, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return topLayoutGuide;
}

- (TTLayoutGuide *)tt_bottomLayoutGuide
{
    TTLayoutGuide *bottomLayoutGuide = objc_getAssociatedObject(self, @selector(tt_bottomLayoutGuide));
    
    if (!bottomLayoutGuide) {
        bottomLayoutGuide = [[TTLayoutGuide alloc] initWithViewController:self
                                                      layoutGuideSelector:@selector(bottomLayoutGuide)];
        
        
        objc_setAssociatedObject(self, @selector(tt_bottomLayoutGuide), bottomLayoutGuide, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return bottomLayoutGuide;
}

- (void)tt_viewDidLayoutSubviews
{
    [self tt_viewDidLayoutSubviews];

    if (!objc_getAssociatedObject(self, @selector(tt_bottomLayoutGuide)) &&
        !objc_getAssociatedObject(self, @selector(tt_topLayoutGuide))) {
        return;
    }
    
    // don't update scroll view insets if developer didn't want it
    if (!self.automaticallyAdjustsScrollViewInsets) {
        return;
    }
    
    UIScrollView *scrollView;
    
    if ([self respondsToSelector:@selector(tableView)]) {
        scrollView = ((UITableViewController *)self).tableView;
    } else if ([self respondsToSelector:@selector(collectionView)]) {
        scrollView = ((UICollectionViewController *)self).collectionView;
    } else {
        scrollView = (UIScrollView *)self.view;
    }
    
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        CGPoint previousContentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + scrollView.contentInset.top);
        
        UIEdgeInsets insets = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0);
        scrollView.contentInset = insets;
        scrollView.scrollIndicatorInsets = insets;
        
        if (previousContentOffset.y == 0) {
            scrollView.contentOffset = CGPointMake(previousContentOffset.x, -scrollView.contentInset.top);
        }
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLayoutSubviews);
        SEL swizzledSelector = @selector(tt_viewDidLayoutSubviews);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

@end