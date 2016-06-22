//
//  NSObject+YCAddition.m
//  iYongche
//
//  Created by yongche_w on 16/2/29.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "NSObject+YCAddition.h"

@implementation NSObject(YCAddition)


/**
 *  判断object为空
 *
 *  @param object id
 *
 *  @return YES就是空
 */
+ (BOOL)isBlankObject:(id)object
{
    if (object == nil) {
        return YES;
    }
    if (object == NULL) {
        return YES;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]]) {
        if ([[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return YES;
        } else {
            const char *str = [object UTF8String];
            if (str && strlen(str) == 0) {
                return YES;
            }
        }
    }
    return NO;
}

- (RACSignal *)showAlertViewWithMessage:(NSString *)message
                              withTitle:(NSString *)title
                          withMenuTitle:(NSString *)menuTitle
                      otherButtonTitles:(NSString *)otherTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:menuTitle
                                          otherButtonTitles:otherTitle, nil];
    [alert show];
    return [alert rac_buttonClickedSignal];
}

@end
