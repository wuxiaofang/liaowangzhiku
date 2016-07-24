//
//  WXFLoginViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/6/7.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFLoginViewController.h"
#import "WXFModifyPasswordViewController.h"

@interface WXFLoginViewController ()

@property (nonatomic, strong) UIImageView* logoImageView;

@property (nonatomic, strong) UITextField* phoneNumberTextField;

@property (nonatomic, strong) UITextField* phoneVerifyCodeTextField;

@property (nonatomic, strong) UIImageView* phoneNumberTextFieldBg;

@property (nonatomic, strong) UIImageView* phoneVerifyCodeTextFieldBg;

@property (nonatomic, strong) UIButton* loginButton;

@property (nonatomic, strong) UIButton* modifyPasswordButton;

@property (nonatomic, strong) UIButton* getUserAccountButton;

@property (nonatomic, strong) UIImageView* bgImageView;

@property (nonatomic, strong) UIButton* closeButton;

@end

@implementation WXFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"登陆"];
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBg"]];
    [self.view addSubview:self.bgImageView];
    
    self.phoneNumberTextFieldBg = [[UIImageView alloc] init];
    self.phoneNumberTextFieldBg.image = [[UIImage imageNamed:@"textField_bg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    self.phoneNumberTextFieldBg.layer.cornerRadius = 3;
    self.phoneNumberTextFieldBg.layer.masksToBounds = YES;
    [self.view addSubview:self.phoneNumberTextFieldBg];
    
    self.phoneVerifyCodeTextFieldBg = [[UIImageView alloc] init];
    self.phoneVerifyCodeTextFieldBg.image = [[UIImage imageNamed:@"textField_bg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    self.phoneVerifyCodeTextFieldBg.layer.cornerRadius = 3;
    self.phoneVerifyCodeTextFieldBg.layer.masksToBounds = YES;
    [self.view addSubview:self.phoneVerifyCodeTextFieldBg];
    
    UIImage* image = [UIImage imageNamed:@"back_button"];
    
    self.closeButton = [[UIButton alloc] init];
    [self.closeButton setImage:image forState:UIControlStateNormal];
    self.closeButton.size = image.size;
    [self.closeButton addTarget:self action:@selector(closeButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
}

- (void)closeButtonPress
{
    if(self.userDidLoginFinishBlock){
        self.userDidLoginFinishBlock(NO);
    }
    [self.navigationController popViewControllerAnimated:YES];

    
//    [self dismissViewControllerAnimated:YES completion:^{
//        if(self.userDidLoginFinishBlock){
//            self.userDidLoginFinishBlock(NO);
//        }
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.bgImageView.frame = self.view.bounds;
    
    if(DeviceIsIphone4){
        self.logoImageView.top = 35;
    }else{
        self.logoImageView.top = 96;
    }
    self.logoImageView.centerX = self.view.width / 2;
    
    
    
    self.phoneNumberTextField.left = 22.5;
    self.phoneNumberTextField.top = self.logoImageView.bottom + 22;
    self.phoneNumberTextField.width = self.view.width - 45;
    self.phoneNumberTextField.height = 40;
    
    self.phoneNumberTextFieldBg.frame = self.phoneNumberTextField.frame;
    
    self.phoneVerifyCodeTextField.left = 22.5;
    self.phoneVerifyCodeTextField.top = self.phoneNumberTextField.bottom  + 10;
    self.phoneVerifyCodeTextField.width = self.view.width - 45;
    self.phoneVerifyCodeTextField.height = 40;
    self.phoneVerifyCodeTextFieldBg.frame = self.phoneVerifyCodeTextField.frame;
    
    self.loginButton.left = 22.5;
    self.loginButton.top = self.phoneVerifyCodeTextField.bottom  + 20;
    self.loginButton.width = self.view.width - 45;
    self.loginButton.height = 40;
    
    self.modifyPasswordButton.left = 22.5;
    self.modifyPasswordButton.top = self.loginButton.bottom  + 10;
    
    self.getUserAccountButton.left = self.view.width - 22.5 - self.getUserAccountButton.width;
    self.getUserAccountButton.top = self.loginButton.bottom  + 10;
    
    
    self.closeButton.left = 20;
    self.closeButton.top = self.view.height - self.closeButton.height - 30;
    
}

- (UITextField*)phoneNumberTextField
{
    if(_phoneNumberTextField == nil){
        _phoneNumberTextField = [self createTextField:@"请输入用户名"
                                        lefrImageName:@"login_input_name"];
        _phoneNumberTextField.keyboardType = UIKeyboardTypeDefault;
        _phoneNumberTextField.font = [UIFont systemFontOfSize:14.0f];
        [self.view addSubview:_phoneNumberTextField];

        _phoneNumberTextField.returnKeyType = UIReturnKeyDone;
        
    }
    return _phoneNumberTextField;
}

- (UITextField*)phoneVerifyCodeTextField
{
    if(_phoneVerifyCodeTextField == nil){
        _phoneVerifyCodeTextField = [self createTextField:@"请输入密码"
                                            lefrImageName:@"login_input_password"];
        
        [self.view addSubview:_phoneVerifyCodeTextField];
        _phoneVerifyCodeTextField.keyboardType = UIKeyboardTypeDefault;

        _phoneVerifyCodeTextField.font = [UIFont systemFontOfSize:14.0f];
        _phoneVerifyCodeTextField.returnKeyType = UIReturnKeyDone;
    }
    return _phoneVerifyCodeTextField;
}


- (UITextField*)createTextField:(NSString*)placeholder
                  lefrImageName:(NSString*)lefrImageName
{
    UITextField* textField = [[UITextField alloc] init];
    textField.background = nil;
    textField.backgroundColor = [UIColor clearColor];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:12.0]}];
                                       
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont systemFontOfSize:12.0f];
    textField.textColor = [UIColor whiteColor];
    textField.delegate = self;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:lefrImageName]];
    imageView.backgroundColor = [UIColor clearColor];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 26)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:imageView];
    imageView.left = 15;
    imageView.centerY = view.height / 2;
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

- (UIImageView*)logoImageView
{
    if(_logoImageView == nil){
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"login_top_img"];
        [self.view addSubview:_logoImageView];
        [_logoImageView sizeToFit];
    }
    return _logoImageView;
}


- (UIButton*)loginButton
{
    if(_loginButton == nil){
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"登录"
                      forState:UIControlStateNormal];
        [_loginButton setTitleColor:UIColorFromRGB(0xffffff)
                           forState:UIControlStateNormal];
        _loginButton.font = [UIFont systemFontOfSize:17.0f];
        [_loginButton addTarget:self
                         action:@selector(loginButtonPress)
               forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setBackgroundImage:[[UIImage createImageWithColor:UIColorFromRGB(0x1dbbe6)] stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateNormal];
        
        
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}



- (void)loginButtonPress
{
    if(self.phoneNumberTextField.text <= 0){
        [self showToastWithText:@"用户名不能为空"];
    }
    
    if(self.phoneVerifyCodeTextField.text <= 0){
        [self showToastWithText:@"密码不能为空"];
    }
    [self showHud];
    NSString* social_id = [[UIDevice currentDevice] uuid];
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:social_id forKey:@"social_id"];
    [paramater setValue:self.phoneNumberTextField.text forKey:@"user_name"];
    [paramater setValue:self.phoneVerifyCodeTextField.text forKey:@"password"];
    [paramater setValue:self.phoneNumberTextField.text forKey:@"alias"];
    [paramater setValue:@"1" forKey:@"os_type"];
    [paramater setValue:@"1" forKey:@"channel"];
    [paramater setValue:[UIDevice currentDevice].systemVersion forKey:@"system_version"];
    [paramater setValue:@"safari" forKey:@"user_agent"];
    
    NSString* jpushId = [JPUSHService registrationID];
    if(jpushId.length <= 0){
        jpushId = @"";
    }
    [paramater setValue:jpushId forKey:@"device_token"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/user/login.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
        NSString* msg = [parser.responseDictionary stringSafeForKey:@"msg"];
        
        NSInteger code = [parser.responseDictionary integerSafeForKey:@"code"];
        if(code == 0){
            NSString* jssession = [parser.responseDictionary stringSafeForKey:kJSESSIONID];
            if(jssession.length > 0){
                DefaultSetValueForKey(jssession, kJSESSIONID);
                NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
                [cookieDict setObject:kJSESSIONID forKey:NSHTTPCookieName];
                [cookieDict setObject:jssession forKey:NSHTTPCookieValue];
                NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDict];
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

            }
            [JPUSHService setTags:[NSSet setWithObjects:@"ios",@"dev",@"test", nil] alias:self.phoneNumberTextField.text fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                NSLog(@"%@",iAlias);
            }];
            
            
            [self loginSuccess];
            [self showSuccessToast:(msg.length > 0?msg:@"登录成功")];
        }else{
            [self showFailedToast:(msg.length > 0?msg:@"登录失败")];
        }
        
    }];
    
    
}

- (UIButton*)modifyPasswordButton
{
    if(_modifyPasswordButton == nil){
        _modifyPasswordButton = [[UIButton alloc] init];
        [_modifyPasswordButton setTitle:@"忘记密码?"
                               forState:UIControlStateNormal];
        [_modifyPasswordButton setTitleColor:[UIColor whiteColor]
                                    forState:UIControlStateNormal];
        _modifyPasswordButton.font = [UIFont systemFontOfSize:14.0f];
        [_modifyPasswordButton addTarget:self
                                  action:@selector(modifyPasswordButtonPress)
                        forControlEvents:UIControlEventTouchUpInside];
        [_modifyPasswordButton sizeToFit];
        
        
        
        [self.view addSubview:_modifyPasswordButton];
    }
    return _modifyPasswordButton;
}

- (UIButton*)getUserAccountButton
{
    if(_getUserAccountButton == nil){
        _getUserAccountButton = [[UIButton alloc] init];
        [_getUserAccountButton setTitle:@"获取用户名"
                               forState:UIControlStateNormal];
        [_getUserAccountButton setTitleColor:[UIColor whiteColor]
                                    forState:UIControlStateNormal];
        _getUserAccountButton.font = [UIFont systemFontOfSize:14.0f];
        [_getUserAccountButton addTarget:self
                                  action:@selector(getUserAccountButtonPress)
                        forControlEvents:UIControlEventTouchUpInside];
        [_getUserAccountButton sizeToFit];
        
        
        
        [self.view addSubview:_getUserAccountButton];
    }
    return _getUserAccountButton;
}

- (void)modifyPasswordButtonPress
{
    WXFModifyPasswordViewController* modify = [[WXFModifyPasswordViewController alloc] init];
    modify.webviewUrl = @"http://lwinst.zkdxa.com/app/comm/center/user/password/find.jspx";
    
    [self.navigationController pushViewController:modify animated:YES];
}

- (void)getUserAccountButtonPress
{
    WXFModifyPasswordViewController* modify = [[WXFModifyPasswordViewController alloc] init];
    modify.webviewUrl = @"http://lwinst.zkdxa.com/app/comm/center/user/username/obtain.jspx";
    
    [self.navigationController pushViewController:modify animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


- (void)loginSuccess
{
    
    
    [[WXFUser instance] getUserInfo:^(BOOL isSuccess) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(self.userDidLoginFinishBlock){
            self.userDidLoginFinishBlock(YES);
        }
    });
//    [self dismissViewControllerAnimated:YES completion:^{
//        if(self.userDidLoginFinishBlock){
//            self.userDidLoginFinishBlock(YES);
//        }
//    }];
}

@end
