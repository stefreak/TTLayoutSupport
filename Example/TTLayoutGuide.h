//
//  TTLayoutGuide.h
//  TTLayoutSupport
//
//  Created by Steffen Neubauer on 23/05/15.
//  Copyright (c) 2015 Steffen Neubauer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger/*NSLayoutAttribute*/, TTLayoutGuideAttribute) {
    TTLayoutGuideAttributeBottom = NSLayoutAttributeBottom,
    TTLayoutGuideAttributeLength = NSLayoutAttributeHeight,
};

@interface TTLayoutGuide : NSObject<UILayoutSupport>

- (instancetype)initWithViewController:(UIViewController *)viewController layoutGuideSelector:(SEL)layoutGuideSelector;

#pragma mark - set static layout guide length

// usage example:
//
//      viewController.topLayoutGuide.length = 200;
//
// setting the length using this property is short for:
//
//      [self constrainAttribute:TTLayoutGuideAttributeLength
//                   toAttribute:NSLayoutAttributeNotAnAttribute
//                        ofView:nil
//                    withOffset:length];
//
@property (nonatomic, assign, readwrite) CGFloat length;

#pragma mark - constrain layout guide length to a property of another view

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view;

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset;

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset
                                multiplier:(CGFloat)multiplier;

- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset
                                multiplier:(CGFloat)multiplier
                                  relation:(NSLayoutRelation)equal;

@end
