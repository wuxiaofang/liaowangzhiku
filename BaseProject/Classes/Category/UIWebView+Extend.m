//
//  UIWebView+Extend.m
//  iWeidao
//
//  Created by Mango on 14/11/5.
//  Copyright (c) 2014年 yongche. All rights reserved.
//

#import "UIWebView+Extend.h"

@implementation UIWebView (Extend)

- (NSString *)pageTitle
{
    NSString *str = [self stringByEvaluatingJavaScriptFromString:@"document.title"];
    return str;
}

- (NSString *)pageDescription
{
    NSString *str = [self stringByEvaluatingJavaScriptFromString:@"document.description"];
    return str;
}

- (NSString *)pageUrl
{
    NSString *url = [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    return [NSString stringWithFormat:@"%@?app=ios",url];
}

- (NSString *)imageUrl
{
    NSString *allHTML = [self stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    NSArray *array = [allHTML componentsSeparatedByString:@"<img src="];
    NSString *imageUrl = nil;
    if(array.count > 1){
        NSArray* myArray = [array[1] componentsSeparatedByString:@"width="];
        
        if(myArray.count > 0){
            NSString *url = myArray[0];
            if(url.length > 3){
                NSRange range = NSMakeRange(1, url.length - 3); //取出双冒号
                imageUrl = [url substringWithRange:range];
            }
            
        }
        
    }
    
    return imageUrl;
}

- (NSString *)changeCity
{
    return nil;
}

@end
