//
//  WXFHttpClient.h
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/24.
//  Copyright © 2016 WXF . All rights reserved.
//

#import <UIKit/UIKit.h>



@class WXFParser;

@interface WXFHttpClient : NSObject

+ (WXFHttpClient*)shareInstance;

/*
 * HTTP GET Method
 * 登录状态下才能使用
 * 使用access_token访问服务器，刷新access_token使用getRefreshToken
 *
 **/
- (void)getData:(NSString *)URLString
     parameters:(id)parameters
       callBack:(void (^)(WXFParser *parser))callBackBlock;

/*
 * HTTP POST Method
 * 登录状态下才能使用
 * 使用access_token访问服务器，刷新access_token使用getRefreshToken
 *
 **/
- (void)postData:(NSString *)URLString
      parameters:(id)parameters
        callBack:(void (^)(WXFParser *parser))callBackBlock;

@end
