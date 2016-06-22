//
//  UIView+HUD.m
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView(HUD)

- (void)showHud
{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"Loading..."];
}

- (void)hiddenHud
{
    [SVProgressHUD dismiss];
}

@end
