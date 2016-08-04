//
//  YCBaseWebViewController.h
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXFBaseWebViewController : WXFBaseViewController<UIWebViewDelegate>

/*
 * load webview url
 */
@property (nonatomic, strong) NSString* webviewUrl;


/*
 * webviw
 */
@property (nonatomic, strong) UIWebView* webView;

/*
 * 初始化webview
 */
- (void)createWebView;

/*
 * 加载http url
 */
- (void)laodWebViewData:(NSString*)webviewUrl;

@end
