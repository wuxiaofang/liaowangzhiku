//
//  WXFQQShareHelper.h
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"



@interface WXFQQShareHelper : NSObject

+ (WXFQQShareHelper *)sharedQQHelper;

@property (nonatomic, copy) void(^callBack)(int status, int scene);
- (BOOL)handleOpenURL:(NSURL *)url;
- (void)shareToQQWithTitle:(NSString *)title
               shareImageOrURL:(id)shareImageOrURL
                   description:(NSString *)description
                         scene:(NSInteger)scene
                    webpageUrl:(NSString *)webpageUrl callBackFunc:(void(^)(int status, int scene))callBackFunc;

@end
