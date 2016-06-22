//
//  YCBaseWebViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseWebViewController.h"
#import "WXFLoginViewController.h"

@interface WXFBaseWebViewController ()

@property (nonatomic, assign) NSInteger requestCount;

@property (nonatomic, assign) BOOL showLoading;

@end

@implementation WXFBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)createWebView
{
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}



#pragma mark -  UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* scheme = [[request URL] scheme];
    NSString*  absoluteString = [[request URL] absoluteString];
    NSLog(@"%@",absoluteString);
    if([scheme isEqualToString:@"share"]){
        if([absoluteString rangeOfString:@"pengyouquan"].location != NSNotFound){
            [self shareToWeiXinPengYouQuan];
            return NO;
        }else if([absoluteString rangeOfString:@"weixin"].location != NSNotFound){
            [self shareToWeiXinFriends];
            return NO;
        
        }else if([absoluteString rangeOfString:@"weibo"].location != NSNotFound){
            [self shareToSinaWeibo];
            return NO;
        }else if([absoluteString rangeOfString:@"qqzone"].location != NSNotFound){
            [self shareToQQ];
            return NO;
        }
    }else if([absoluteString rangeOfString:@"/login.jspx"].location != NSNotFound){
        [self pushLoginViewController];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self addRequestCount];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self reduceRequestCount];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [self reduceRequestCount];
}

- (void)addRequestCount
{
    self.requestCount += 1;
    if(self.requestCount > 0 && self.showLoading){
        self.showLoading = YES;
        [self showHud];
    }
}

- (void)reduceRequestCount
{
    self.requestCount -= 1;
    if(self.requestCount <=0){
        self.requestCount = 0;
        self.showLoading = NO;
        [self hiddenHud];
    }
}


- (void)shareToQQ
{
    [[WXFQQShareHelper sharedQQHelper] shareToQQWithTitle:@"瞭望智库"
                                          shareImageOrURL:[UIImage imageNamed:@"welcome_iphone6p"]
                                              description:@"分享到好友" scene:0
                                               webpageUrl:@"http://www.qq.com"
                                             callBackFunc:^(int status, int scene) {
                                                 
                                                 if(status == 0){
                                                     [self showToastWithText:@"分享成功"];
                                                 }
                                             }];
}

- (void)shareToWeiXinFriends
{
    [[WXFWeChatShareHelper sharedWeChatHelper] shareToWechatWithTitle:@"瞭望智库"
                                                      shareImageOrURL:[UIImage imageNamed:@"welcome_iphone6p"]
                                                          description:@"分享到好友" scene:0
                                                           webpageUrl:@"http://www.baidu.com"
                                                         callBackFunc:^(int status, int scene) {
                                                             
                                                             if(status == 0){
                                                                 [self showToastWithText:@"分享成功"];
                                                             }
                                                         }];
}

- (void)shareToWeiXinPengYouQuan
{
    [[WXFWeChatShareHelper sharedWeChatHelper] shareToWechatWithTitle:@"瞭望智库"
                                                      shareImageOrURL:[UIImage imageNamed:@"welcome_iphone6p"]
                                                          description:@"分享到朋友圈" scene:1
                                                           webpageUrl:@"http://www.baidu.com"
                                                         callBackFunc:^(int status, int scene) {
                                                             if(status == 0){
                                                                 [self showToastWithText:@"分享成功"];
                                                             }
                                                         }];

}

- (void)shareToSinaWeibo
{
    [[WXFWeiboShareHelper sharedWeiBoHelper] shareToWeiboWithTitle:@"瞭望智库"
                                                   shareImageOrURL:[UIImage imageNamed:@"welcome_iphone6p"]
                                                        webpageUrl:@"http://www.baidu.com"
                                           presentedViewController:self
                                                      callBackFunc:^(int status, int scene) {
                                                          if(status == 0){
                                                              [self showToastWithText:@"分享成功"];
                                                          }
                                                      }];

}

- (void)pushLoginViewController
{
    WXFLoginViewController* login = [[WXFLoginViewController alloc] init];
    
    [self.navigationController presentViewController:login animated:YES completion:^{
        
    }];
    login.userDidLoginFinishBlock = ^(BOOL isSuccess){
        if(isSuccess){
            [self.webView reload];
        }
    };
}


@end
