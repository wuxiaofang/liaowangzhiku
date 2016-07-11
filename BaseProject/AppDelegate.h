//
//  AppDelegate.h
//  BaseProject
//
//  Created by yongche_w on 16/5/31.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFHomeViewController.h"
#import "WXFTabbarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) WXFHomeViewController* homeViewController;

@property (nonatomic, strong) WXFTabbarViewController * tabbarController;

@end

