//
//  WXFWelcomeView.h
//  BaseProject
//
//  Created by yongche_w on 16/6/7.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissWelcomeViewBlock)(NSString* webviewUrl);

@interface WXFWelcomeView : UIView

@property (nonatomic, copy) DismissWelcomeViewBlock dismissWelcomeViewBlock;

@end
