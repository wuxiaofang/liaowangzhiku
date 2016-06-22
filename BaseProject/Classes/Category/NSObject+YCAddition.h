//
//  NSObject+YCAddition.h
//  iYongche
//
//  Created by yongche_w on 16/2/29.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIAlertView+RACSignalSupport.h"

@interface NSObject(YCAddition)

+ (BOOL)isBlankObject:(id)object;

- (RACSignal *)showAlertViewWithMessage:(NSString *)message
                              withTitle:(NSString *)title
                          withMenuTitle:(NSString *)menuTitle
                      otherButtonTitles:(NSString *)otherTitle;
@end
