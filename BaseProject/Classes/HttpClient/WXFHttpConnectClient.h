//
//  WXFHttpConnectClient.h
//  PublicCoursera
//
//  Created by yongche_w on 16/5/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"

@interface WXFHttpConnectClient : NSObject

+ (WXFHttpConnectClient*)shareInstance;

- (void)sendRequestData:(NSString*)urlString
            requestData:(NSString*)requestData
                 handle:(void (^)(NSURLResponse* __nullable response, NSData* __nullable data, NSError* __nullable connectionError)) handler;

@end
