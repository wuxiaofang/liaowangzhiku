//
//  WXFParser.m
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016 WXF . All rights reserved.
//

#import "WXFParser.h"

@implementation WXFParser

- (void)parseResponseForSuccess:(NSDictionary*)responseDic
                           task:(NSURLSessionDataTask *)task
{
    NSHTTPURLResponse* httpUrlResponse = nil;
    if([task.response isKindOfClass:[NSHTTPURLResponse class]]){
        httpUrlResponse = (NSHTTPURLResponse*)task.response;
        self.statusCode = httpUrlResponse.statusCode;
    }else{
        self.statusCode = 200;
    }
    if([responseDic isKindOfClass:[NSDictionary class]]){
        self.responseDictionary = responseDic;
    }else{
        self.responseDictionary = nil;
    }
}

- (void)parseResponseForFailed:(NSError*)error
                          task:(NSURLSessionDataTask *)task
{
    NSHTTPURLResponse* httpUrlResponse = nil;
    if(task && [task.response isKindOfClass:[NSHTTPURLResponse class]]){
        httpUrlResponse = (NSHTTPURLResponse*)task.response;
        self.statusCode = httpUrlResponse.statusCode;
    }else{
        self.statusCode = 0;
    }
    
    self.error = error;
}

@end
