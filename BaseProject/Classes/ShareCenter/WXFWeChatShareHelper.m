//
//  WXFWeChatShareHelper.m
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFWeChatShareHelper.h"

@implementation WXFWeChatShareHelper

+ (WXFWeChatShareHelper *)sharedWeChatHelper{
    static id sharedWeChatHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWeChatHelper = [[WXFWeChatShareHelper alloc]  init];
    });
    return sharedWeChatHelper;
}

-(BOOL)handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)shareToWechatWithTitle:(NSString *)title
               shareImageOrURL:(id)shareImageOrURL
                   description:(NSString *)description
                         scene:(NSInteger)scene
                    webpageUrl:(NSString *)webpageUrl callBackFunc:(void(^)(int status, int scene))callBackFunc{
    
    if ([WXApi isWXAppInstalled]) {
        if ([WXApi isWXAppSupportApi]) {
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
            
            //创建消息对象
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = shareTitle;
            message.description = shareText;
            
            
            
            if ([remote_shareImage isKindOfClass:[UIImage class]]) {
                
                message.thumbData = [remote_shareImage changeToWeChatShareThumbData];
            }
            
            //创建跳转链接
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = webpageUrl;
            message.mediaObject = ext;
            
            //创建请求对象
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = scene;
            
            [WXApi sendReq:req];

        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"微信版本过低,请升级版本" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请安装微信客户端" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
    }
    
    
}

- (void)shareToWechatWithImage:(UIImage *)shareImage thumbImage:(UIImage *)thumbImage scene:(int)scene {
    if ([WXApi isWXAppInstalled]) {
        if ([WXApi isWXAppSupportApi]) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"瞭望智库";
            
            if ([thumbImage isKindOfClass:[UIImage class]]) {
                message.thumbData = [thumbImage changeToWeChatShareThumbData];
            }
            
            WXImageObject *ext = [WXImageObject object];
            if (UIImagePNGRepresentation(shareImage) == nil) {
                ext.imageData = UIImageJPEGRepresentation(shareImage, 1);
            } else {
                ext.imageData = UIImagePNGRepresentation(shareImage);
            }
            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = scene;
            [WXApi sendReq:req];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"微信版本过低,请升级版本" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请安装微信客户端" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
    }
}

- (void)onResp:(BaseResp *)resp {
    // 用于区分是支付回调，还是分享回调
    if (resp.errCode == WXSuccess) {
        //            [[YCLoadingHUD toastHUD:@"分享成功"] showViewInSuperView:nil];
    } else if (resp.errCode == WXErrCodeSentFail) {
        //            [[YCLoadingHUD toastHUD:@"分享失败"] showViewInSuperView:nil];
    }
    if (self.callBack) {
        self.callBack(resp.errCode,resp.type);
    }
}


@end
