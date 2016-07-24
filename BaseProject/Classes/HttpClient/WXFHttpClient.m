//
//  WXFHttpClient.m
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/24.
//  Copyright © 2016 WXF . All rights reserved.
//

#import "WXFHttpClient.h"
#import "WXFParser.h"



@interface WXFHttpClient()



@end

@implementation WXFHttpClient

+ (WXFHttpClient*)shareInstance
{

    static WXFHttpClient* shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[WXFHttpClient alloc] init];
    });
    return shareClient;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        NSURL* baseUrl = [NSURL URLWithString:kBaseUrl];
        self.httpSessionManager = [[WXFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    }
    return self;
}

- (void)clearAllSessionManager
{
    NSURL* baseUrl = [NSURL URLWithString:kBaseUrl];
    self.httpSessionManager = [[WXFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
}

/*
 * HTTP GET Method
 * 登录状态下才能使用
 * 使用access_token访问服务器，刷新access_token使用getRefreshToken
 *
 **/
- (void)getData:(NSString *)URLString
     parameters:(id)parameters
       callBack:(void (^)(WXFParser *parser))callBackBlock
{
    NSString* string = DefaultValueForKey(kJSESSIONID);
    if(string.length > 0){
        [self.httpSessionManager.requestSerializer setValue:string forHTTPHeaderField:@"JSESSIONID"];
    }
    
    [self.httpSessionManager GET:URLString
                      parameters:parameters
                        progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             if(callBackBlock){
//                                 NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

//                                 NSString *theXML = [[NSString alloc] initWithBytes: [responseObject mutableBytes] length:[responseObject length] encoding:NSUTF8StringEncoding];
                                 WXFParser* parse = [[WXFParser alloc] init];
                                 [parse parseResponseForSuccess:responseObject
                                                           task:task];
                                 callBackBlock(parse);
                             }
                        }
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                             if(callBackBlock){
                                 WXFParser* parse = [[WXFParser alloc] init];
                                 [parse parseResponseForFailed:error
                                                          task:task];
                                 callBackBlock(parse);
                             }
        
                         }];
}

/*
 * HTTP POST Method
 * 登录状态下才能使用
 * 使用access_token访问服务器，刷新access_token使用getRefreshToken
 *
 **/
- (void)postData:(NSString *)URLString
      parameters:(id)parameters
        callBack:(void (^)(WXFParser *parser))callBackBlock
{
    NSString* string = DefaultValueForKey(kJSESSIONID);
    if(string.length > 0){
        [self.httpSessionManager.requestSerializer setValue:string forHTTPHeaderField:@"JSESSIONID"];
    }
    
    [self.httpSessionManager POST:URLString
                       parameters:parameters
                         progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable  responseObject) {
                              if(callBackBlock){
                                  WXFParser* parse = [[WXFParser alloc] init];
                                  [parse parseResponseForSuccess:responseObject
                                                            task:task];
                                  DLog(@"%@",parse.responseDictionary);
                                  callBackBlock(parse);
                              }
                          }
                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                              if(callBackBlock){
                                  WXFParser* parse = [[WXFParser alloc] init];
                                  [parse parseResponseForFailed:error
                                                           task:task];
                                  callBackBlock(parse);
                              }
                             
                          }];
}


- (void)postFile:(NSString *)filePath
    andUrlString:(NSString*)url
      parameters:(NSDictionary *)parameters
       keyString:(NSString*)key
        mimeType:(NSString *)type
         callBack:(void (^)(WXFParser *parser))callBackBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString* string = DefaultValueForKey(kJSESSIONID);
    if(string.length > 0){
        [self.httpSessionManager.requestSerializer setValue:string forHTTPHeaderField:@"JSESSIONID"];
    }
    
//    []
    [self.httpSessionManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:filePath]) {
            DLog(@"post file is not exist");
        }
        
        [formData appendPartWithFileData:data
                                    name:key
                                fileName:[filePath lastPathComponent]
                                mimeType:type];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(callBackBlock){
            WXFParser* parse = [[WXFParser alloc] init];
            [parse parseResponseForSuccess:responseObject
                                      task:task];
            DLog(@"%@",parse.responseDictionary);
            callBackBlock(parse);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(callBackBlock){
            WXFParser* parse = [[WXFParser alloc] init];
            [parse parseResponseForFailed:error
                                     task:task];
            callBackBlock(parse);
        }
    }];
    

}

@end
