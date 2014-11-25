//
//  TTLayoutSupportConstraint.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTLayoutSupportConstraint.h"

@implementation TTLayoutSupportConstraint

+ (NSArray *)layoutSupportConstraintsWithView:(UIView *)view topLayoutGuide:(id<UILayoutSupport>)topLayoutGuide
{
    return @[
             [TTLayoutSupportConstraint constraintWithItem:topLayoutGuide
                                                 attribute:NSLayoutAttributeHeight
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:nil
                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                multiplier:1.0
                                                  constant:0.0],
             [TTLayoutSupportConstraint constraintWithItem:topLayoutGuide
                                                 attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:view
                                                 attribute:NSLayoutAttributeTop
                                                multiplier:1.0
                                                  constant:0.0],
             ];
}

+ (NSArray *)layoutSupportConstraintsWithView:(UIView *)view bottomLayoutGuide:(id<UILayoutSupport>)bottomLayoutGuide
{
    return @[
             [TTLayoutSupportConstraint constraintWithItem:bottomLayoutGuide
                                                 attribute:NSLayoutAttributeHeight
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:nil
                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                multiplier:1.0
                                                  constant:0.0],
             [TTLayoutSupportConstraint constraintWithItem:bottomLayoutGuide
                                                 attribute:NSLayoutAttributeBottom
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:view
                                                 attribute:NSLayoutAttributeBottom
                                                multiplier:1.0
                                                  constant:0.0],
             ];
}

@end
