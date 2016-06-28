//
//  WXFShareCenter.m
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFShareCenter.h"

@interface WXFShareCenter()

@end

@implementation WXFShareCenter

+ (instancetype)instance
{
    static WXFShareCenter* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WXFShareCenter alloc] init];
    });
    return _instance;
}

- (void)registerThirdSDK
{
    [WeiboSDK registerApp:kWeiBoKey];
    [WeiboSDK enableDebugMode:YES];
    [WXApi registerApp:kWechatKey];
}


- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    BOOL openSources = NO;
    openSources = [[WXFWeiboShareHelper sharedWeiBoHelper] handleOpenURL:url];
    if(!openSources){
        openSources = [[WXFQQShareHelper sharedQQHelper] handleOpenURL:url];
    }
    
    if(!openSources){
        openSources = [[WXFWeChatShareHelper sharedWeChatHelper] handleOpenURL:url];
    }
    
    return openSources;
    
}



@end
