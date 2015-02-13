//
//  UIViewController+TTLayoutSupport.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "UIViewController+TTLayoutSupport.h"
#import "TTLayoutSupportConstraint.h"
#import <objc/runtime.h>
#import "TTDeallocHook.h"

@interface UIViewController (TTLayoutSupportPrivate)

// recorded apple's `UILayoutSupportConstraint` objects for topLayoutGuide
@property (nonatomic, strong) NSArray *tt_recordedTopLayoutSupportConstraints;

// recorded apple's `UILayoutSupportConstraint` objects for bottomLayoutGuide
@property (nonatomic, strong) NSArray *tt_recordedBottomLayoutSupportConstraints;

// custom layout constraint that has been added to control the topLayoutGuide
@property (nonatomic, strong) TTLayoutSupportConstraint *tt_topConstraint;

// custom layout constraint that has been added to control the bottomLayoutGuide
@property (nonatomic, strong) TTLayoutSupportConstraint *tt_bottomConstraint;

@end

@implementation UIViewController (TTLayoutSupport)

- (CGFloat)tt_topLayoutGuideLength
{
    return self.tt_topConstraint ? self.tt_topConstraint.constant : self.topLayoutGuide.length;
}

- (void)setTt_topLayoutGuideLength:(CGFloat)length
{
    [self tt_ensureCustomTopConstraint];
    
    self.tt_topConstraint.constant = length;
    
    [self tt_updateInsets:YES];
}

- (CGFloat)tt_bottomLayoutGuideLength
{
    return self.tt_bottomConstraint ? self.tt_bottomConstraint.constant : self.bottomLayoutGuide.length;
}

- (void)setTt_bottomLayoutGuideLength:(CGFloat)length
{
    [self tt_ensureCustomBottomConstraint];

    self.tt_bottomConstraint.constant = length;
    
    [self tt_updateInsets:NO];
}

- (void)tt_ensureCustomTopConstraint
{
    if (self.tt_topConstraint) {
        // already created
        return;
    }
    
    // recording does not work if view has never been accessed
    __unused UIView *view = self.view;
    // if topLayoutGuide has never been accessed it may not exist yet
    __unused id<UILayoutSupport> topLayoutGuide = self.topLayoutGuide;

    self.tt_recordedTopLayoutSupportConstraints = [self findLayoutSupportConstraintsFor:self.topLayoutGuide];
    NSAssert(self.tt_recordedTopLayoutSupportConstraints.count, @"Failed to record topLayoutGuide constraints. Is the controller's view added to the view hierarchy?");
    [self.view removeConstraints:self.tt_recordedTopLayoutSupportConstraints];

    NSArray *constraints =
        [TTLayoutSupportConstraint layoutSupportConstraintsWithView:self.view
                                                     topLayoutGuide:self.topLayoutGuide];

    // todo: less hacky?
    self.tt_topConstraint = [constraints firstObject];
    
    [self.view addConstraints:constraints];

    // this fixes a problem with iOS7.1 (GH issue #2), where the contentInset
    // of a scrollView is overridden by the system after interface rotation
    // this should be safe to do on iOS8 too, even if the problem does not exist there.
    __weak typeof(self) weakSelf = self;
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification
                                                                    object:nil
                                                                     queue:[NSOperationQueue mainQueue]
                                                                usingBlock:^(NSNotification *note) {
        [weakSelf tt_updateInsets:NO];
    }];

    [TTDeallocHook attachTo:self callback:^{
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

- (void)tt_ensureCustomBottomConstraint
{
    if (self.tt_bottomConstraint) {
        // already created
        return;
    }

    // recording does not work if view has never been accessed
    __unused UIView *view = self.view;
    // if bottomLayoutGuide has never been accessed it may not exist yet
    __unused id<UILayoutSupport> bottomLayoutGuide = self.bottomLayoutGuide;

    self.tt_recordedBottomLayoutSupportConstraints = [self findLayoutSupportConstraintsFor:self.bottomLayoutGuide];
    NSAssert(self.tt_recordedBottomLayoutSupportConstraints.count, @"Failed to record bottomLayoutGuide constraints. Is the controller's view added to the view hierarchy?");
    [self.view removeConstraints:self.tt_recordedBottomLayoutSupportConstraints];
    
    NSArray *constraints =
    [TTLayoutSupportConstraint layoutSupportConstraintsWithView:self.view
                                              bottomLayoutGuide:self.bottomLayoutGuide];
    
    // todo: less hacky?
    self.tt_bottomConstraint = [constraints firstObject];
    
    [self.view addConstraints:constraints];
}

- (NSArray *)findLayoutSupportConstraintsFor:(id<UILayoutSupport>)layoutGuide
{
    NSMutableArray *recordedLayoutConstraints = [[NSMutableArray alloc] init];

    for (NSLayoutConstraint *constraint in self.view.constraints) {
        // I think an equality check is the fastest check we can make here
        // member check is to distinguish accidentally created constraints from _UILayoutSupportConstraints
        if (constraint.firstItem == layoutGuide && ![constraint isMemberOfClass:[NSLayoutConstraint class]]) {
            [recordedLayoutConstraints addObject:constraint];
        }
    }

    return recordedLayoutConstraints;
}

- (void)tt_updateInsets:(BOOL)adjustsScrollPosition
{
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

        UIEdgeInsets insets = UIEdgeInsetsMake(self.tt_topLayoutGuideLength, 0, self.tt_bottomLayoutGuideLength, 0);
        scrollView.contentInset = insets;
        scrollView.scrollIndicatorInsets = insets;
        
        if (adjustsScrollPosition && previousContentOffset.y == 0) {
            scrollView.contentOffset = CGPointMake(previousContentOffset.x, -scrollView.contentInset.top);
        }
    }
}

@end

@implementation UIViewController (TTLayoutSupportPrivate)

- (NSLayoutConstraint *)tt_topConstraint
{
    return objc_getAssociatedObject(self, @selector(tt_topConstraint));
}

- (void)setTt_topConstraint:(NSLayoutConstraint *)constraint
{
    objc_setAssociatedObject(self, @selector(tt_topConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)tt_bottomConstraint
{
    return objc_getAssociatedObject(self, @selector(tt_bottomConstraint));
}

- (void)setTt_bottomConstraint:(NSLayoutConstraint *)constraint
{
    objc_setAssociatedObject(self, @selector(tt_bottomConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)tt_recordedTopLayoutSupportConstraints
{
    return objc_getAssociatedObject(self, @selector(tt_recordedTopLayoutSupportConstraints));
}

- (void)setTt_recordedTopLayoutSupportConstraints:(NSArray *)constraints
{
    objc_setAssociatedObject(self, @selector(tt_recordedTopLayoutSupportConstraints), constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)tt_recordedBottomLayoutSupportConstraints
{
    return objc_getAssociatedObject(self, @selector(tt_recordedBottomLayoutSupportConstraints));
}

- (void)setTt_recordedBottomLayoutSupportConstraints:(NSArray *)constraints
{
    objc_setAssociatedObject(self, @selector(tt_recordedBottomLayoutSupportConstraints), constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
