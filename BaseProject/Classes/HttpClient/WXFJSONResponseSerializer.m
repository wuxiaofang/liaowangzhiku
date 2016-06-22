//
//  WXFJSONResponseSerializer.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFJSONResponseSerializer.h"

@implementation WXFJSONResponseSerializer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    return self;
}

@end
