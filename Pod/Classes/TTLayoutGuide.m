//
//  TTLayoutGuide.m
//  TTLayoutSupport
//
//  Created by Steffen Neubauer on 23/05/15.
//  Copyright (c) 2015 Steffen Neubauer. All rights reserved.
//

#import "TTLayoutGuide.h"
#import <objc/runtime.h>

@interface TTLayoutGuide ()

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, assign) SEL layoutGuideSelector;

@property (nonatomic, strong) NSLayoutConstraint *originalLengthConstraint;

@property (nonatomic, strong) NSLayoutConstraint *customLengthConstraint;

@end

@implementation TTLayoutGuide

- (instancetype)initWithViewController:(UIViewController *)viewController layoutGuideSelector:(SEL)layoutGuideSelector
{
    NSParameterAssert(viewController);
    NSParameterAssert(layoutGuideSelector);

    self = [super init];

    if (self) {
        _viewController = viewController;
        _layoutGuideSelector = layoutGuideSelector;
    }

    return self;
}


#pragma mark - Properties

@synthesize length = _length;
@synthesize viewController = _viewController;
@synthesize layoutGuideSelector = _layoutGuideSelector;
@synthesize originalLengthConstraint = _originalLengthConstraint;
@synthesize customLengthConstraint = _customLengthConstraint;

@synthesize topAnchor = _topAnchor;
@synthesize heightAnchor = _heightAnchor;
@synthesize bottomAnchor = _bottomAnchor;


#pragma mark - set static layout guide length

- (CGFloat)length
{
    return [self layoutGuide].length;
}

- (void)setLength:(CGFloat)length
{
    if (self.customLengthConstraint) {
        [self.viewController.view removeConstraint:self.customLengthConstraint];
    }

    self.customLengthConstraint = [self constrainAttribute:TTLayoutGuideAttributeLength
                                                  toAttribute:NSLayoutAttributeNotAnAttribute
                                                       ofView:nil
                                                   withOffset:length];
}

#pragma mark - constrain layout guide length to a property of another view

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
{
    return [self constrainAttribute:guideAttribute
                        toAttribute:viewAttribute
                             ofView:view
                         withOffset:0];
}

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset
{
    return [self constrainAttribute:guideAttribute
                        toAttribute:viewAttribute
                             ofView:view
                         withOffset:offset
                         multiplier:1];
}

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset
                                multiplier:(CGFloat)multiplier
{
    return [self constrainAttribute:guideAttribute
                        toAttribute:viewAttribute
                             ofView:view
                         withOffset:offset
                         multiplier:multiplier
                           relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset
                                multiplier:(CGFloat)multiplier
                                  relation:(NSLayoutRelation)relation
{
    [self ensureOriginalLengthConstraintRemoved];

    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:[self layoutGuide]
                                                                  attribute:(NSLayoutAttribute)guideAttribute
                                                                  relatedBy:relation
                                                                     toItem:view
                                                                  attribute:viewAttribute
                                                                 multiplier:multiplier
                                                                   constant:offset];

    UIView *commonSuperview = self.viewController.view;
    if (view) {
         commonSuperview = [self findCommonSuperviewForView:(UIView *)[self layoutGuide] otherView:view];
    }
    
    [commonSuperview addConstraint:constraint];

    return constraint;
}

- (void)ensureOriginalLengthConstraintRemoved
{
    // get original layout guide so we have the constraints
    [self layoutGuide];

    if (self.originalLengthConstraint) {
        // nothing to do; already removed!
        return;
    }

    for (NSLayoutConstraint *constraint in self.viewController.view.constraints) {
        if (constraint.firstItem == [self layoutGuide] && constraint.secondItem == nil) {
            self.originalLengthConstraint = constraint;
            break;
        }
    }

    NSAssert(self.originalLengthConstraint,
             @"Failed to find layout guide constraints. Is the controller's view added to the view hierarchy?");

    [self.viewController.view removeConstraint:self.originalLengthConstraint];
}

#pragma mark - helpers

// copied from PureLayout Copyright (c) 2014-2015 Tyler Fox
// MIT License https://github.com/smileyborg/PureLayout/blob/master/LICENSE
- (UIView *)findCommonSuperviewForView:(UIView *)view otherView:(UIView *)otherView
{
    UIView *commonSuperview = nil;
    UIView *startView = view;
    do {
        if ([otherView isDescendantOfView:startView]) {
            commonSuperview = startView;
        }
        startView = startView.superview;
    } while (startView && !commonSuperview);
    NSAssert(commonSuperview, @"Can't constrain two views that do not share a common superview. Make sure that both views have been added into the same view hierarchy.");
    return commonSuperview;
}

- (id<UILayoutSupport>)layoutGuide
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [self.viewController performSelector:self.layoutGuideSelector];
#pragma clang diagnostic pop
}

@end