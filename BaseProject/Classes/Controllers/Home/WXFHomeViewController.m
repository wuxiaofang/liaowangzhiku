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
#import "WXFWelcomeView.h"

@interface WXFHomeViewController ()


@end

@implementation WXFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望智库"];
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    WXFWelcomeView* welcomeView = [[WXFWelcomeView alloc] initWithFrame:window.bounds];
    
    welcomeView.dismissWelcomeViewBlock = ^(NSString* webviewUrl){
        
        
    };
    
    [window addSubview:welcomeView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
