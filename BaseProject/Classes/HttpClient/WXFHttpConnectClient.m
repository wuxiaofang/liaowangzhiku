//
//  WXFHttpConnectClient.m
//  PublicCoursera
//
//  Created by yongche_w on 16/5/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFHttpConnectClient.h"

@interface WXFHttpConnectClient()

@property (nonatomic, strong) NSOperationQueue* queue;

@end

@implementation WXFHttpConnectClient


+ (WXFHttpConnectClient*)shareInstance
{
    
    static WXFHttpConnectClient* shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[WXFHttpConnectClient alloc] init];
    });
    return shareClient;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        self.queue = [[NSOperationQueue alloc]init];
    }
    return self;
}

- (void)sendRequestData:(NSString*)urlString
            requestData:(NSString*)requestData
                 handle:(void (^)(NSURLResponse* __nullable response, NSData* __nullable data, NSError* __nullable connectionError)) handler
{
//    NSData *postData = [requestData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    NSString* stringPreHttpUrl = @"http://xhappws.m1c.cn/XHApp!";
//    NSString* stringPreHttpUrl = @"http://172.18.90.73/XHApp!";
    NSString* stringPreHttpUrl = @"http://125.215.37.57:9153/XHApp!";
    NSString* newUrl = [NSString stringWithFormat:@"%@%@?data=%@",stringPreHttpUrl,urlString,[requestData stringByURLEncode]];
    NSURL *url = [NSURL URLWithString:newUrl ];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:postData];
    [request setTimeoutInterval:30.0];
    
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(handler){
                handler(response,data,connectionError);
            }
        });
    }];
    
    
    
}

@end
