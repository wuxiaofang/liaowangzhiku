//
//  WXFLoginViewController.h
//  BaseProject
//
//  Created by yongche_w on 16/6/7.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"

typedef void(^UserDidLoginFinishBlock)(BOOL isSuccess);

@interface WXFLoginViewController : WXFBaseViewController

@property (nonatomic, strong) UserDidLoginFinishBlock userDidLoginFinishBlock;

@end
