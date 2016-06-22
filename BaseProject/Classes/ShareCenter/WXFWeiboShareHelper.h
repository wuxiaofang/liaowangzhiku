//
//  WXFWeiboShareHelper.h
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXFWeiboShareHelper : NSObject

+ (WXFWeiboShareHelper *)sharedWeiBoHelper;
@property(nonatomic,copy) void(^callBack)(int status, int scene);
- (BOOL)handleOpenURL:(NSURL *)url;
- (void)shareToWeiboWithTitle:(NSString *)title
              shareImageOrURL:(id)shareImageOrURL
                   webpageUrl:(NSString *)webpageUrl
      presentedViewController:(UIViewController *)presentedViewController callBackFunc:(void(^)(int status, int scene))callBackFunc;

@end
