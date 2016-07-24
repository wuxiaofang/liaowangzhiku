//
//  WXFReportViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/7/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFReportViewController.h"

@interface WXFReportViewController ()

@end

@implementation WXFReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望课题申报"];
    
    self.webviewUrl = [NSString stringWithFormat:@"%@/app/user/circle/form.jspx",kBaseUrl];
    [self laodWebViewData:self.webviewUrl];
    self.navigationItem.leftBarButtonItem = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    [self setCustomLabelForNavTitle:@"瞭望课题申报"];
    
}

@end
