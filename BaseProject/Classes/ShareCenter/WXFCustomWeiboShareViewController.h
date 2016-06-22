//
//  WXFCustomWeiboShareViewController.h
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"

@interface WXFCustomWeiboShareViewController : WXFBaseViewController

@property(nonatomic,copy) void(^callBack)(int status, int scene);
- (id)initWithTitle:(NSString *)shareTitle
    shareImageOrURL:(id)shareImageOrURL
            pageUrl:(NSString *)sharePageUrl callBackFunc:(void(^)(int status, int scene))callBackFunc;

@end
