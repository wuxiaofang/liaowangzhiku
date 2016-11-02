//
//  WXFReportViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/7/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFReportViewController.h"
#import "WXFLoginViewController.h"

@interface WXFReportViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong) UILabel* labele1;

@property (nonatomic, strong) UITextField* textField1;

@property (nonatomic, strong) UILabel* labele2;

@property (nonatomic, strong) UITextField* textField2;

@property (nonatomic, strong) UIView* line1;

@property (nonatomic, strong) UIView* line2;

@property (nonatomic, strong) UIView* line3;

@property (nonatomic, strong) UILabel* labele3;

@property (nonatomic, strong) UIButton* commitButton;

@end

@implementation WXFReportViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望课题申报"];
    
//    self.webviewUrl = [NSString stringWithFormat:@"%@/app/user/circle/form.jspx",kBaseUrl];
//    [self laodWebViewData:self.webviewUrl];
//    self.navigationItem.leftBarButtonItem = nil;
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.labele1 = [[UILabel alloc] init];
    self.labele1.text = @"课题名称";
    self.labele1.font = [UIFont systemFontOfSize:16.0f];
    self.labele1.textAlignment = NSTextAlignmentCenter;
    [self.labele1 sizeToFit];
    [self.bgView addSubview:self.labele1];
    
    self.labele2 = [[UILabel alloc] init];
    self.labele2.text = @"邮箱地址";
    self.labele2.font = [UIFont systemFontOfSize:16.0f];
    self.labele2.textAlignment = NSTextAlignmentCenter;
    [self.labele2 sizeToFit];
    [self.bgView addSubview:self.labele2];
    
    self.textField1 = [[UITextField alloc] init];
    [self.bgView addSubview:self.textField1];
    self.textField1.delegate = self;
    self.textField1.font = [UIFont systemFontOfSize:16];
    self.textField1.textColor = UIColorFromRGB(0x000000);
    [self.bgView addSubview:self.textField1];
    self.textField1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入课题名称" attributes:@{ NSForegroundColorAttributeName:UIColorFromRGB(0x828282), NSFontAttributeName : [UIFont systemFontOfSize:16.0]}];
    self.textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.textField2 = [[UITextField alloc] init];
    [self.bgView addSubview:self.textField2];
    self.textField2.delegate = self;
    
    
    self.textField2.font = [UIFont systemFontOfSize:16];
    self.textField2.textColor = UIColorFromRGB(0x000000);
    [self.bgView addSubview:self.textField2];
    self.textField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入您的邮箱名称" attributes:@{ NSForegroundColorAttributeName: UIColorFromRGB(0x828282), NSFontAttributeName : [UIFont systemFontOfSize:16.0]}];
    self.textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.line1 = [[UIView alloc] init];
    self.line1.backgroundColor = UIColorFromRGB(0xe4e4e4);
    [self.bgView addSubview:self.line1];
    
    self.line2 = [[UIView alloc] init];
    self.line2.backgroundColor = UIColorFromRGB(0xe4e4e4);
    [self.bgView addSubview:self.line2];
    
    self.line3 = [[UIView alloc] init];
    self.line3.backgroundColor = UIColorFromRGB(0xe4e4e4);
    [self.bgView addSubview:self.line3];
    
    self.labele3 = [[UILabel alloc] init];
    self.labele3.text = @"在此请您填写个人信息，系统将自动发送申报模板到您的邮箱，申报书填写完成后请以附件形式邮件至liaowang@zhiku.com,并在标题注明\"XXX项目申报书\"，感谢您的配合。";
    self.labele3.font = [UIFont systemFontOfSize:12.0f];
    self.labele3.textAlignment = NSTextAlignmentLeft;
    self.labele3.numberOfLines = 0;
    self.labele3.lineBreakMode = NSLineBreakByWordWrapping;
    self.labele3.textColor = UIColorFromRGB(0x828282);
    [self.view addSubview:self.labele3];
    CGSize size = [self.labele3.text sizeForFont:self.labele3.font size:CGSizeMake(self.view.width  - 20, 9999) mode:self.labele3.lineBreakMode];
    self.labele3.size = size;
    
    self.commitButton = [[UIButton alloc] init];
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.commitButton setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0x1dbbe6)] forState:UIControlStateNormal];
    [self.view addSubview:self.commitButton];
    [self.commitButton addTarget:self action:@selector(commitButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.textField1.returnKeyType = UIReturnKeyDone;
    self.textField2.returnKeyType = UIReturnKeyDone;
    
}

- (void)commitButtonPress
{
    if([WXFUser instance].isLogin){
        [self commitData];
    }else{
        WXFLoginViewController* login = [[WXFLoginViewController alloc] init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
  
        login.userDidLoginFinishBlock = ^(BOOL isSuccess){
            if(isSuccess){
                [self commitData];
            }
        };
    }
    
    

}

- (void)commitData
{
    if(self.textField1.text.length <= 0){
        [self showToastWithText:@"请输入课题名称"];
    }
    
    if(self.textField2.text.length <= 0){
        [self showToastWithText:@"请输入您的邮箱"];
    }
    
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:self.textField1.text forKey:@"oriTitle"];
    [paramater setValue:self.textField2.text forKey:@"oriEmail"];
    [self showHud];
    [[WXFHttpClient shareInstance] postData:@"/app/user/circle/form.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        [self hiddenHud];
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        NSString* desc = [parser.responseDictionary stringSafeForKey:@"desc"];
        if(code == 1){
            
            [self showSuccessToast:desc];
            self.textField1.text = nil;
            self.textField2.text = nil;
            WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.webviewUrl = [NSString stringWithFormat:@"%@/app/user/circle/success.jspx",kBaseUrl];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else{
            [self showFailedToast:desc];
        }
        
        
        
    }];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.bgView.frame = CGRectMake(0, 15, self.view.width, 88);
    
    self.labele1.left = 20;
    self.labele1.centerY = 22;
    
    self.labele2.left = 20;
    self.labele2.centerY = 66;
    
    self.textField1.left = self.labele1.right + 15;
    self.textField1.width = self.bgView.width - self.labele1.right - 10;
    self.textField1.height = 35;
    self.textField1.centerY = self.labele1.centerY;
    
    self.textField2.left = self.labele2.right + 15;
    self.textField2.width = self.bgView.width - self.labele2.right - 10;
    self.textField2.height = 35;
    self.textField2.centerY = self.labele2.centerY;
    
    self.line1.frame = CGRectMake(0, 0, self.bgView.width, 0.5);
    self.line2.frame = CGRectMake(0, self.bgView.height / 2, self.bgView.width, 0.5);
    self.line3.frame = CGRectMake(0, self.bgView.height - 0.5, self.bgView.width, 0.5);
    
    self.labele3.left = 10;
    self.labele3.top = self.bgView.bottom + 10;
    
    self.commitButton.frame = CGRectMake(10, self.labele3.bottom + 10, self.view.width - 20, 35);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
    
}

@end
