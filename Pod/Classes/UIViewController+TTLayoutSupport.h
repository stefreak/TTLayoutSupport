//
//  UIViewController+TTLayoutSupport.h
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTLayoutGuide.h"

/**
 *  The `UIViewController+TTLayoutSupport` category makes it very easy to change
 *  either the position of a `UIViewController`s `topLayoutGuide` or `bottomLayoutGuide`.
 *
 *  The ViewController will automatically adjust scroll view insets according to it's
 *  top- or bottom layout guides.
 *
 *  If you don't want that, set `automaticallyAdjustsScrollViewInsets` to `NO`.
 * 
 *  @see TTLayoutGuide
 */
@interface UIViewController (TTLayoutSupport)

/**
 *  Returns an instance representing the top layout guide.
 *  Can be used to change the position of the top layout guide.
 */
@property (nonatomic, readonly) TTLayoutGuide* tt_topLayoutGuide;

/**
 *  Returns an instance representing the bottom layout guide.
 *  Can be used to change the position of the bottom layout guide.
 */
@property (nonatomic, readonly) TTLayoutGuide* tt_bottomLayoutGuide;

@end
