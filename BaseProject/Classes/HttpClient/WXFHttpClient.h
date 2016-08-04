//
//  WXFHttpClient.h
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/24.
//  Copyright © 2016 WXF . All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXFHTTPSessionManager.h"

@class WXFParser;

@interface WXFHttpClient : NSObject

@property (nonatomic, strong) WXFHTTPSessionManager* httpSessionManager;

/*
 * HTTPClient 单例模式
 **/
+ (WXFHttpClient*)shareInstance;

/*
 * HTTP GET Method
 * GET方式获取网络数据
 * @param： 
        URLString：http地址
        parameters： http参数
        callBackBlock：http完成之后的回调
 *
 **/
- (void)getData:(NSString *)URLString
     parameters:(id)parameters
       callBack:(void (^)(WXFParser *parser))callBackBlock;

/*
 * HTTP POST Method
 * POST方式获取网络数据
 * @param：
        URLString：http地址
        parameters： http参数
        callBackBlock：http完成之后的回调
 *
 **/
- (void)postData:(NSString *)URLString
      parameters:(id)parameters
        callBack:(void (^)(WXFParser *parser))callBackBlock;

/*
 * HTTP POST File Method
 * POST方式上传文件到服务器
 * @param：
        filePath：上传的文件的路径
        url：http地址
        parameters： http参数
        key：上传的文件的名字
        type：上传文件的类型
        callBackBlock：http完成之后的回调
 *
 **/
- (void)postFile:(NSString *)filePath
    andUrlString:(NSString*)url
      parameters:(NSDictionary *)parameters
       keyString:(NSString*)key
        mimeType:(NSString *)type
        callBack:(void (^)(WXFParser *parser))callBackBlock;
@end
