//
//  WXFParser.h
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016 WXF . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXFParser : NSObject

/*
 * http 返回值
 **/
@property (nonatomic, strong)NSDictionary* responseDictionary;

/*
 * Http 状态码
 * statusCode = 200 正常
 **/
@property (nonatomic, assign)NSInteger statusCode;

/*
 * Http 错误
 * statusCode ！= 200 时的错误信息
 **/
@property (nonatomic,strong) NSError *error;


/*
 * 解析Http请求的结果
 * statusCode = 200 时的数据的解析
 * responseDic ： JSON数据
 *
 **/
- (void)parseResponseForSuccess:(NSDictionary*)responseDic
                           task:(NSURLSessionDataTask *)task;

/*
 * 解析Http请求的结果
 * statusCode ！= 200 时的数据的解析
 **/
- (void)parseResponseForFailed:(NSError*)error
                          task:(NSURLSessionDataTask *)task;

@end
