//
//  UIViewController+TTLayoutSupport.h
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTLayoutGuide.h"

@interface UIViewController (TTLayoutSupport)

@property (nonatomic, readonly) TTLayoutGuide* tt_topLayoutGuide;

@property (nonatomic, readonly) TTLayoutGuide* tt_bottomLayoutGuide;

@end
