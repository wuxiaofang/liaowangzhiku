//
//  WXFAFXMLParserResponseSerializer.m
//  PublicCoursera
//
//  Created by yongche_w on 16/5/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFAFXMLParserResponseSerializer.h"

@implementation WXFAFXMLParserResponseSerializer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/plain",@"text/html",nil];
    
    return self;
}

@end
