//
//  UIView+Frame.h
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Frame)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = x
 */
@property (nonatomic, assign) CGFloat x;
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic, assign) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic, assign) CGFloat top;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = y
 */
@property (nonatomic, assign) CGFloat y;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic, assign) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic, assign) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic, assign) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic, assign) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 * Shortcut for origin
 *
 * Sets frame.origin = origin
 */
@property (nonatomic, assign) CGPoint origin;

/**
 * Shortcut for size
 *
 * Sets frame.size = size
 */
@property (nonatomic, assign) CGSize size;
@end
