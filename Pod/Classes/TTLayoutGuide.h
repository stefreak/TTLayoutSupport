//
//  TTLayoutGuide.h
//  TTLayoutSupport
//
//  Created by Steffen Neubauer on 23/05/15.
//  Copyright (c) 2015 Steffen Neubauer. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *
 *      _______________ _ _  top layout guide AttributeTop
 *     |               |   :
 *     | /_ .. ....    |   I top layout guide AttributeLength
 *     |_\_____________|_ _:
 *     |               |     top layout guide AttributeBottom
 *     | .:::.   .:::. |
 *     |:::::::.:::::::|
 *     |:::::::::::::::|
 *     |':::::::::::::'|     Your UIViewController
 *     |  ':::::::::'  |
 *     |    ':::::'    |
 *     |      ':'      |
 *     |_______________|_ _  bottom layout guide AttributeTop
 *     |    |     |    |   :
 *     | :: | : : | :: |   I bottom layout guide AttributeLength
 *     |____|_____|____|_ _:
 *                           bottom layout guide AttributeBottom
 *
 */
typedef NS_ENUM(NSInteger/*NSLayoutAttribute*/, TTLayoutGuideAttribute){
    /**
     *  For the topLayoutGuide, this is equal to the top edge of the screen.
     *  For the bottomLayoutGuide, this is equal to the `UITabBar`'s top.
     */
    TTLayoutGuideAttributeTop = NSLayoutAttributeTop,
    /**
     *  For the topLayoutGuide, this is equal to the `UINavigationBar`'s bottom.
     *  For the bottomLayoutGuide, this is equal to the bottom edge of the screen.
     */
    TTLayoutGuideAttributeBottom = NSLayoutAttributeBottom,
    /**
     *  This attribute accords to the actual length of the layout guide.
     */
    TTLayoutGuideAttributeLength = NSLayoutAttributeHeight,
};

/**
 * The `TTLayoutGuide` must be used by importing `UIViewController+TTLayoutSupport.h` and
 * accessing `tt_topLayoutGuide` or `tt_bottomLayoutGuide` properties on any `UIViewController`.
 *
 * `TTLayoutGuide` can be used exactly as Apple's `id<UILayoutSupport>` objects returned by
 * `topLayoutGuide` and `bottomLayoutGuide`, only that it adds functionality to change the 
 *  layout guide's length or constrain it relative to other views.
 */
@interface TTLayoutGuide : NSObject<UILayoutSupport>

/**
 *  The constructor should be considered private. Please use `UIViewController+TTLayoutSupport`
 *
 *  @param viewController      the viewController this layout guide belongs to
 *  @param layoutGuideSelector a SEL that can be used to get the top- or bottom layout guide
 *
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithViewController:(UIViewController *)viewController layoutGuideSelector:(SEL)layoutGuideSelector;

#pragma mark - set static layout guide length

/**
 * usage example:
 *
 *      viewController.topLayoutGuide.length = 200;
 *
 * which is a shortcut for:
 *
 *      [self constrainAttribute:TTLayoutGuideAttributeLength
 *                   toAttribute:NSLayoutAttributeNotAnAttribute
 *                        ofView:nil
 *                    withOffset:200];
 *
 */
@property (nonatomic, assign, readwrite) CGFloat length;

#pragma mark - constrain layout guide length to a property of another view

/**
 *  Constrain either top, bottom or length attributes of the layout guide.
 *  
 *  The layout constraint will be automatically installed.
 *
 *  @param guideAttribute attribute of the layout guide to constrain
 *  @param viewAttribute  layout guide attribute will be constrained to this attribute
 *  @param view           layout guide will be constrained to the attribute of this view
 *  @see   NSLayoutConstraint
 *
 *  @return `NSLayoutConstraint` will be returned and can be later removed or modified.
 */
- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view;

/**
 *  Constrain either top, bottom or length attributes of the layout guide.
 *
 *  The layout constraint will be automatically installed.
 *
 *  @param guideAttribute attribute of the layout guide to constrain
 *  @param viewAttribute  layout guide attribute will be constrained to this attribute
 *  @param view           layout guide will be constrained to the attribute of this view
 *  @param offset         offset
 *  @see   NSLayoutConstraint
 *
 *  @return `NSLayoutConstraint` will be returned and can be later removed or modified.
 */
- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset;

/**
 *  Constrain either top, bottom or length attributes of the layout guide.
 *
 *  The layout constraint will be automatically installed.
 *
 *  @param guideAttribute attribute of the layout guide to constrain
 *  @param viewAttribute  layout guide attribute will be constrained to this attribute
 *  @param view           layout guide will be constrained to the attribute of this view
 *  @param offset         offset
 *  @param multiplier     multiplier
 *  @see   NSLayoutConstraint
 *
 *  @return `NSLayoutConstraint` will be returned and can be later removed or modified.
 */
- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset
                                multiplier:(CGFloat)multiplier;

/**
 *  Constrain either top, bottom or length attributes of the layout guide.
 *
 *  The layout constraint will be automatically installed.
 *
 *  @param guideAttribute attribute of the layout guide to constrain
 *  @param viewAttribute  layout guide attribute will be constrained to this attribute
 *  @param view           layout guide will be constrained to the attribute of this view
 *  @param offset         offset
 *  @param multiplier     multiplier
 *  @param relation       relation
 *  @see   NSLayoutConstraint
 *
 *  @return `NSLayoutConstraint` will be returned and can be later removed or modified.
 */
- (NSLayoutConstraint *)constrainAttribute:(TTLayoutGuideAttribute)guideAttribute
                               toAttribute:(NSLayoutAttribute)viewAttribute
                                    ofView:(id)view
                                withOffset:(CGFloat)offset
                                multiplier:(CGFloat)multiplier
                                  relation:(NSLayoutRelation)equal;

@end
