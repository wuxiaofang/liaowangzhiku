//
//  UIColor+WXFColor.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "UIColor+WXFColor.h"
#import "UIColor+Factory.h"

@implementation UIColor(WXFColor)


+ (NSString *)colorString:(NSString *)colorString
{
    if (colorString.length <= 6) {
        return nil;
    }
    
    return [colorString substringWithRange:NSMakeRange(colorString.length -6-1, 6)];
}

+ (UIColor *)fastGetColorWithString:(NSString *)colorString
{
    return [self colorWithHexString:[self colorString:colorString]];
}


+(UIColor *)c_ff5252
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//白色
+ (UIColor *)c_ffffff
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//灰色
+ (UIColor *)c_fafafa
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//绿色
+ (UIColor *)c_28d29b
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//蓝色
+ (UIColor *)c_5578A8
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//黑色
+ (UIColor *)c_323232
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//灰色
+ (UIColor *)c_646464
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//灰色
+ (UIColor *)c_888888
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//灰色
+ (UIColor *)c_c8c8c8
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//蓝色
+ (UIColor *)c_1e82e6
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//灰色
+ (UIColor *)c_e1e1e1
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//红色
+ (UIColor *)c_e54a4a
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}

//白色
+ (UIColor *)c_e5e5e5
{
    return [self fastGetColorWithString:[NSString stringWithFormat:@"%s", __func__]];
}


@end


