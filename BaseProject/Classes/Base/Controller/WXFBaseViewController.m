//
//  WXFBaseViewController.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"
#import "AppDelegate.h"

@interface WXFBaseViewController ()

@end

@implementation WXFBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    self.edgesForExtendedLayout = UIRectEdgeNone;
}



- (void)setCustomLabelForNavTitle:(NSString*)title
{
    UILabel* label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:19];
    label.textColor = UIColorFromRGB(0xffffff);
    label.text = title;
    [label sizeToFit];
    label.frame = CGRectIntegral(label.frame);
    self.navigationItem.titleView = label;
}

- (void)showHud
{
 
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"Loading..."];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];;
}

- (void)hiddenHud
{
    [SVProgressHUD dismiss];
}

- (void)showToastWithText:(NSString*)text
{
//    [SVProgressHUD showSuccessWithStatus:text];
//    [SVProgressHUD dismissWithDelay:1];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showImage:nil status:text];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismissWithDelay:1.0];
    });
    
    
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:text message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [alert show];
}

- (void)showSuccessToast
{
    [self showToastWithText:@"Success"];
}

- (void)showFailedToast
{
    [self showToastWithText:@"Failed"];
  
}

- (void)showSuccessToast:(NSString *)text
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:text];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismissWithDelay:1.0];
    });
}

- (void)showFailedToast:(NSString *)text
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showErrorWithStatus:text];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismissWithDelay:1.0];
    });
    
}

- (void)showLeftButtonWithTitle:(NSString *)title
{
    UIButton *button = [self createButtonWithTitle:title];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self
               action:@selector(backBarButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button sizeToFit];
    
    button.frame = CGRectIntegral(button.frame);
    return button;
}

- (void)showBackButton
{
    UIImage *image = [UIImage imageNamed:@"nav_back_btn"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self
               action:@selector(backBarButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)backBarButtonPressed:(id)object
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (CGFloat)cellHeigth
{
    CGFloat hei = self.count * 35;
    if(hei < 60){
        hei = 60;
    }
    return hei;
}

- (void)showMyButton
{
    {
        UIButton* myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        //        self.logoutButton.imageView.image = [UIImage imageNamed:@"main_icon"];

        [myButton addTarget:self action:@selector(myButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [myButton setImage:[UIImage imageNamed:@"nav_menu"] forState:UIControlStateNormal];
       
        UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:myButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    }

}

@end
