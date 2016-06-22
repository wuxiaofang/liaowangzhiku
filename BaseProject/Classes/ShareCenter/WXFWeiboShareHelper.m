//
//  WXFWeiboShareHelper.m
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFWeiboShareHelper.h"
#import "WeiboSDK.h"
#import <SDWebImage/SDImageCache.h>
#import "WXFCustomWeiboShareViewController.h"


@interface WXFWeiboShareHelper()<WeiboSDKDelegate>
@property(nonatomic,copy) NSString *wbtoken;
@property(nonatomic,weak) UIViewController *localPresentedViewController;
//分享需要的参数
@property(nonatomic,copy) NSString *shareTitle;
@property(nonatomic,copy) NSString *imageOrURL;
@property(nonatomic,copy) NSString *pageURL;
@end

@implementation WXFWeiboShareHelper

+ (WXFWeiboShareHelper *)sharedWeiBoHelper{
    static id sharedWeiboHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWeiboHelper = [[WXFWeiboShareHelper alloc]  init];
    });
    return sharedWeiboHelper;
}

-(BOOL)handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark -- 微博分享
- (void)shareToWeiboWithTitle:(NSString *)title
              shareImageOrURL:(id)shareImageOrURL
                   webpageUrl:(NSString *)webpageUrl
      presentedViewController:(UIViewController *)presentedViewController callBackFunc:(void (^)(int, int))callBackFunc{
    self.shareTitle = title;
    self.imageOrURL = shareImageOrURL;
    self.pageURL = webpageUrl;
    if (callBackFunc) {
        self.callBack = callBackFunc;
    }
    self.localPresentedViewController = presentedViewController;
    self.wbtoken = getValueForKeyFromUserDefault(kWeiboAccessTokenKey);
    NSDate *tokenExpireDate = getValueForKeyFromUserDefault(kWeiboExpireDateKey);
    NSTimeInterval timeInterval = 0;
    if (tokenExpireDate) {
        timeInterval = [tokenExpireDate timeIntervalSinceDate:[NSDate date]];
    }
    if (self.wbtoken.length > 0 && timeInterval > 0) {
        //如果有token就打开自定义分享页面
        [self showCustomWeiboViewController];
    }else{
        //没有就请求认证
        //重置窗口
        
        [self sendAuthorizedRequest];
    }
}

- (void)showCustomWeiboViewController{
    WXFCustomWeiboShareViewController *customWeiboShareVC = [[WXFCustomWeiboShareViewController alloc] initWithTitle:self.shareTitle shareImageOrURL:self.imageOrURL pageUrl:self.pageURL callBackFunc:self.callBack];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:customWeiboShareVC];
    [self.localPresentedViewController presentViewController:navC animated:YES completion:nil];
}

- (BOOL)sendAuthorizedRequest{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kWeiboRedirectURL;
    authRequest.scope = @"all";
    return [WeiboSDK sendRequest:authRequest];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    DLog(@"%@",request);
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]){
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken){
            self.wbtoken = accessToken;
        }
    }else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if ([response statusCode] == WeiboSDKResponseStatusCodeUserCancel) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"发送失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
        } else if ([response statusCode] == WeiboSDKResponseStatusCodeSuccess){
            self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
            NSDate *expireDate = [(WBAuthorizeResponse *)response expirationDate];
            setValueAndKeyToUserDefault(self.wbtoken, kWeiboAccessTokenKey);
            setValueAndKeyToUserDefault(expireDate, kWeiboExpireDateKey);
            [self showCustomWeiboViewController];
        }
    }
}


@end
