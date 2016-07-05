//
//  YCHomeViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFHomeViewController.h"
#import "WXFLoginViewController.h"
#import "WXFWeChatShareHelper.h"
#import "WXFWeiboShareHelper.h"
#import "WXFQQShareHelper.h"

@interface WXFHomeViewController ()

@end

@implementation WXFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createMySubviews];
}

- (void)createMySubviews
{
    
    [self.navigationController setNavigationBarHidden:YES];
//    [self laodWebViewData:@"http://lwinst.zkdxa.com"];
//    {
//        UIButton* button = [[UIButton alloc] init];
//        button.frame = CGRectMake(10, 60, 100, 50);
//        [button setTitle:@"登录" forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
//        [self.view addSubview:button];
//        [button addTarget:self action:@selector(loginbuttonpress) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    {
//        UIButton* button = [[UIButton alloc] init];
//        button.tag = 0;
//        button.frame = CGRectMake(10, 120, 100, 50);
//        [button setTitle:@"QQ" forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
//        [self.view addSubview:button];
//        [button addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    {
//        UIButton* button = [[UIButton alloc] init];
//        button.tag = 1;
//        button.frame = CGRectMake(10, 180, 100, 50);
//        [button setTitle:@"微信好友" forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
//        [self.view addSubview:button];
//        [button addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    {
//        UIButton* button = [[UIButton alloc] init];
//        button.tag = 2;
//        button.frame = CGRectMake(10, 240, 100, 50);
//        [button setTitle:@"朋友圈" forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
//        [self.view addSubview:button];
//        [button addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    {
//        UIButton* button = [[UIButton alloc] init];
//        button.tag = 3;
//        button.frame = CGRectMake(10, 300, 100, 50);
//        [button setTitle:@"微博" forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
//        [self.view addSubview:button];
//        [button addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    }
}


- (void)shareButtonPress:(UIButton*)button
{
    if(button.tag == 0){
        
        [[WXFQQShareHelper sharedQQHelper] shareToQQWithTitle:@"瞭望智库"
                                                          shareImageOrURL:[UIImage imageNamed:@"welcome_iphone6p"]
                                                              description:@"分享到好友" scene:0
                                                               webpageUrl:@"http://www.qq.com"
                                                             callBackFunc:^(int status, int scene) {
                                                                 
                                                                 if(status == 0){
                                                                     [self showToastWithText:@"分享成功"];
                                                                 }
                                                             }];
        
    }else if(button.tag == 1){
        [[WXFWeChatShareHelper sharedWeChatHelper] shareToWechatWithTitle:@"瞭望智库"
                                                          shareImageOrURL:[UIImage imageNamed:@"welcome_iphone6p"]
                                                              description:@"分享到好友" scene:0
                                                               webpageUrl:@"http://www.baidu.com"
                                                             callBackFunc:^(int status, int scene) {
            
            if(status == 0){
                [self showToastWithText:@"分享成功"];
            }
        }];
    }else if(button.tag == 2){
        [[WXFWeChatShareHelper sharedWeChatHelper] shareToWechatWithTitle:@"瞭望智库"
                                                          shareImageOrURL:[UIImage imageNamed:@"welcome_iphone6p"]
                                                              description:@"分享到朋友圈" scene:1
                                                               webpageUrl:@"http://www.baidu.com"
                                                             callBackFunc:^(int status, int scene) {
            if(status == 0){
                [self showToastWithText:@"分享成功"];
            }
        }];
    }else if(button.tag == 3){
        
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
    
}

- (void)loginbuttonpress
{
    WXFLoginViewController* login = [[WXFLoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)pushshLoginViewController
{

}

@end
