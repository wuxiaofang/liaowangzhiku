//
//  WXFLoginViewController.h
//  BaseProject
//
//  Created by yongche_w on 16/6/7.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"

typedef void(^UserDidLoginFinishBlock)(BOOL isSuccess);

/*
 * 登录
 **/
@interface WXFLoginViewController : WXFBaseViewController

/*
 * 登陆之后的回调
 */
@property (nonatomic, strong) UserDidLoginFinishBlock userDidLoginFinishBlock;

@end
