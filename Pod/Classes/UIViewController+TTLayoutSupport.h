//
//  UIViewController+TTLayoutSupport.h
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TTLayoutSupport)

// reading from this property is equivalent to reading the bottomLayoutGuide.length property
// writing to this property means changing the bottomLayoutGuide.length property
@property (assign, nonatomic) CGFloat tt_bottomLayoutGuideLength;

// reading from this property is equivalent to reading the topLayoutGuide.length property
// writing to this property means changing the topLayoutGuide.length property
@property (assign, nonatomic) CGFloat tt_topLayoutGuideLength;

@end
