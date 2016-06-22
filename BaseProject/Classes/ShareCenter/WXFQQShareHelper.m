//
//  WXFQQShareHelper.m
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFQQShareHelper.h"

@interface WXFQQShareHelper()<QQApiInterfaceDelegate,TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth* tencentOauth;

@end

@implementation WXFQQShareHelper

- (instancetype)init
{
    self = [super init];
    if(self){
        self.tencentOauth = [[TencentOAuth alloc] initWithAppId:kQQOpenID andDelegate:self];
    }
    return self;
}

+ (WXFQQShareHelper *)sharedQQHelper{
    static id sharedWeiboHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWeiboHelper = [[WXFQQShareHelper alloc]  init];
    });
    return sharedWeiboHelper;
}

- (void)shareToQQWithTitle:(NSString *)title
               shareImageOrURL:(id)shareImageOrURL
                   description:(NSString *)description
                         scene:(NSInteger)scene
                    webpageUrl:(NSString *)webpageUrl callBackFunc:(void(^)(int status, int scene))callBackFunc
{
//    QQApiTextObject* txtObj = [QQApiTextObject objectWithText:@"goog"];
//    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:txtObj];
//    
//    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//    
//    return;
    
    if ([QQApiInterface isQQInstalled]) {
        if ([QQApiInterface isQQSupportApi]) {
            if (callBackFunc) {
                self.callBack = callBackFunc;
            }
            
            UIImage * remote_shareImage = shareImageOrURL;
            if ([shareImageOrURL isKindOfClass:[NSString class]]) {
                NSString *imageURL = shareImageOrURL;
                if (imageURL.length > 0) {
                    remote_shareImage = nil;
                    //添加本地缓存
                    remote_shareImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
                    if(remote_shareImage == nil){
                        remote_shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
                        [[SDImageCache sharedImageCache] storeImage:remote_shareImage forKey:imageURL];
                    }
                }
            }
            
            NSString *shareText;
            NSString *shareTitle;
            
            shareText = title;
            shareTitle = title;
            if(description && description.length > 0){
                shareText = description;
            }
            
            NSData* data = [remote_shareImage changeToWeChatShareThumbData];;
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:[NSURL URLWithString:webpageUrl] title:shareTitle description:shareText previewImageData:data];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
//            QQApiTextObject* txtObj = [QQApiTextObject objectWithText:shareTitle];
//            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:txtObj];
//            
//            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            NSLog(@"sssd  %d",sent);
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"QQ版本过低,请升级版本" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请安装QQ客户端" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
    }

    
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [QQApiInterface handleOpenURL:url delegate:self];
}

#pragma mark - QQApiInterfaceDelegate
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req
{
    NSLog(@"%@",req);
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp
{
    if([resp.result isEqualToString:@"-4"]){
        if (self.callBack) {
            self.callBack(-4,resp.type);
        }
    }else if([resp.result isEqualToString:@"0"]){
        if (self.callBack) {
            self.callBack(0,resp.type);
        }
    }else{
        if (self.callBack) {
            self.callBack(-1,resp.type);
        }
    }
    
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
    NSLog(@"sdla;sldkfa;lksdf");
}

- (void)addShareResponse:(APIResponse*) response
{
    NSLog(@"sdla;sldkfa;lksdf");
}

@end
