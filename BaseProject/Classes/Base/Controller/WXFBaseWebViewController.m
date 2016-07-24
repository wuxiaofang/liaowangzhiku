//
//  YCBaseWebViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseWebViewController.h"
#import "WXFLoginViewController.h"

@interface WXFBaseWebViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, assign) NSInteger requestCount;

@property (nonatomic, assign) BOOL showLoading;

@end

@implementation WXFBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createWebView];
    if(self.webviewUrl){
        [self laodWebViewData:self.webviewUrl];
    }
    [self showBackButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout) name:kUserLogoutNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userLogout
{
    [self.webView reload];
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
        NSDictionary *query = [request.URL.query queryContentsUsingEncoding:NSUTF8StringEncoding];
        if([absoluteString rangeOfString:@"pengyouquan"].location != NSNotFound){
            [self shareToWeiXinPengYouQuan:query];
            return NO;
        }else if([absoluteString rangeOfString:@"weixin"].location != NSNotFound){
            [self shareToWeiXinFriends:query];
            return NO;
        
        }else if([absoluteString rangeOfString:@"weibo"].location != NSNotFound){
            [self shareToSinaWeibo:query];
            return NO;
        }else if([absoluteString rangeOfString:@"qqzone"].location != NSNotFound){
            [self shareToQQ:query];
            return NO;
        }
    }else if([scheme isEqualToString:@"win"]){
        NSDictionary *query = [request.URL.query queryContentsUsingEncoding:NSUTF8StringEncoding];
        if([absoluteString rangeOfString:@"close"].location != NSNotFound){
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }else if([absoluteString rangeOfString:@"open"].location != NSNotFound){
            [self openNewWebviewVC:query];
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
    [self setCustomLabelForNavTitle:[self.webView pageTitle]];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [self reduceRequestCount];
}

- (void)addRequestCount
{
    self.requestCount += 1;
    if(self.requestCount > 0 && !self.showLoading){
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


- (void)shareToQQ:(NSDictionary*)query
{
   
    NSString* title = [[query arraySafeForKey:@"title"] objectAtIndexSafe:0];
    NSString* imageurl = [[query arraySafeForKey:@"imageurl"] objectAtIndexSafe:0];
    NSString* webpage = [[query arraySafeForKey:@"webpage"] objectAtIndexSafe:0];
    NSString* description = [[query arraySafeForKey:@"description"] objectAtIndexSafe:0];
    [[WXFQQShareHelper sharedQQHelper] shareToQQWithTitle:title
                                          shareImageOrURL:imageurl
                                              description:description
                                                    scene:0
                                               webpageUrl:webpage
                                             callBackFunc:^(int status, int scene) {
                                                 
                                                 if(status == 0){
                                                     [self showToastWithText:@"分享成功"];
                                                 }
                                             }];
}

- (void)shareToWeiXinFriends:(NSDictionary*)query
{
    NSString* title = [[query arraySafeForKey:@"title"] objectAtIndexSafe:0];
    NSString* imageurl = [[query arraySafeForKey:@"imageurl"] objectAtIndexSafe:0];
    NSString* webpage = [[query arraySafeForKey:@"webpage"] objectAtIndexSafe:0];
    NSString* description = [[query arraySafeForKey:@"description"] objectAtIndexSafe:0];
    
    [[WXFWeChatShareHelper sharedWeChatHelper] shareToWechatWithTitle:title
                                                      shareImageOrURL:imageurl
                                                          description:description
                                                                scene:0
                                                           webpageUrl:webpage
                                                         callBackFunc:^(int status, int scene) {
                                                             
                                                             if(status == 0){
                                                                 [self showToastWithText:@"分享成功"];
                                                             }
                                                         }];
}

- (void)shareToWeiXinPengYouQuan:(NSDictionary*)query
{
    
    NSString* title = [[query arraySafeForKey:@"title"] objectAtIndexSafe:0];
    NSString* imageurl = [[query arraySafeForKey:@"imageurl"] objectAtIndexSafe:0];
    NSString* webpage = [[query arraySafeForKey:@"webpage"] objectAtIndexSafe:0];
    NSString* description = [[query arraySafeForKey:@"description"] objectAtIndexSafe:0];
    
    [[WXFWeChatShareHelper sharedWeChatHelper] shareToWechatWithTitle:title
                                                      shareImageOrURL:imageurl
                                                          description:description
                                                                scene:1
                                                           webpageUrl:webpage
                                                         callBackFunc:^(int status, int scene) {
                                                             if(status == 0){
                                                                 [self showToastWithText:@"分享成功"];
                                                             }
                                                         }];

}

- (void)shareToSinaWeibo:(NSDictionary*)query
{
    NSString* title = [[query arraySafeForKey:@"title"] objectAtIndexSafe:0];
    NSString* imageurl = [[query arraySafeForKey:@"imageurl"] objectAtIndexSafe:0];
    NSString* webpage = [[query arraySafeForKey:@"webpage"] objectAtIndexSafe:0];
//    NSString* description = [[query arraySafeForKey:@"description"] objectAtIndexSafe:0];
    [[WXFWeiboShareHelper sharedWeiBoHelper] shareToWeiboWithTitle:title
                                                   shareImageOrURL:imageurl
                                                        webpageUrl:webpage
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
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
    
//    [self.navigationController presentViewController:login animated:YES completion:^{
//        
//    }];
    login.userDidLoginFinishBlock = ^(BOOL isSuccess){
        if(isSuccess){
            NSString* string = DefaultValueForKey(kJSESSIONID);
            
            if(string.length > 0){
                NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
                [cookieDict setObject:kJSESSIONID forKey:NSHTTPCookieName];
                [cookieDict setObject:string forKey:NSHTTPCookieValue];
                NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDict];
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
            [self.webView reload];
        }
    };
}

- (void)laodWebViewData:(NSString*)webviewUrl
{
    if(webviewUrl.length > 0){
        NSString* string = DefaultValueForKey(kJSESSIONID);
        
        if(string.length > 0){
            NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
            [cookieDict setObject:kJSESSIONID forKey:NSHTTPCookieName];
            [cookieDict setObject:string forKey:NSHTTPCookieValue];
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDict];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
        
        NSURL* url = [NSURL URLWithString:webviewUrl];
        NSURLRequest* urlRequest = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:urlRequest];
    }
    
}

- (void)openNewWebviewVC:(NSDictionary*)query
{
     NSString* title = [[query arraySafeForKey:@"url"] objectAtIndexSafe:0];
    WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.webviewUrl = title;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setImagePickerSelecteImage{
    UIActionSheet *actionSheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"拍摄照片", @"从图片库中选取", nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"从图片库中选取", nil];
    }
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        NSInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (buttonIndex == 0) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                sourceType = UIImagePickerControllerSourceTypeCamera;
            }
        }
        [self showImagePickerController:sourceType];
    }
}

- (void)showImagePickerController:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate  = self;
    pickerController.sourceType = sourceType;
    pickerController.allowsEditing = YES;
    if (IOS8) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }else{
        self.modalPresentationStyle =    UIModalPresentationCustom;
    }
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - UIImagPIckerControllder
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
    CGSize  imgSize = CGSizeMake(1600, 960);
    UIImage* imagePickerSelecteImage = [UIImage compressImage:resultImage
                                               toSize:imgSize
                               withCompressionQuality:0.0];
    [self uploadUserProfile:imagePickerSelecteImage];
}

- (void)uploadUserProfile:(UIImage*)image
{

}

@end
