//
//  YCBaseWebViewController.h
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXFBaseWebViewController : WXFBaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView* webView;

- (void)createWebView;

- (void)laodWebViewData:(NSString*)webviewUrl;

@end
