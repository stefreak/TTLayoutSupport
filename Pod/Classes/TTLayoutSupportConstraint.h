//
//  TTLayoutSupportConstraint.h
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTLayoutSupportConstraint : NSLayoutConstraint

+ (NSArray *)layoutSupportConstraintsWithView:(UIView *)view topLayoutGuide:(id<UILayoutSupport>)topLayoutGuide;

+ (NSArray *)layoutSupportConstraintsWithView:(UIView *)view bottomLayoutGuide:(id<UILayoutSupport>)bottomLayoutGuide;

@end
