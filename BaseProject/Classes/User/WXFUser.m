//
//  WXFUser.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/26.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFUser.h"

#define kUserInfo      @"userinfo"

@implementation WXFUser

+ (WXFUser*)instance
{
    static WXFUser* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WXFUser alloc] init];
    });
    return _instance;
}

- (BOOL)isLogin
{
    NSString* username = DefaultValueForKey(kJSESSIONID);
    if(username.length > 0){
        return YES;
    }
    return NO;
}

- (BOOL)isNeedModifyPassword
{
    BOOL modify = [DefaultValueForKey(@"newUser") boolValue];
    if(modify){
        return NO;
    }
    
    return YES;
}


- (void)logout
{
    DefaultSetValueForKey(@"", kJSESSIONID);
    DefaultSetValueForKey(@{}, kUserInfo);
    DefaultSetValueForKey(@YES, @"newUser");
    NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
    [cookieDict setObject:kJSESSIONID forKey:NSHTTPCookieName];
    [cookieDict setObject:@"" forKey:NSHTTPCookieValue];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDict];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogoutNotification object:nil];
}

- (void)parseUserInfo:(NSDictionary*)dic
{
//    self.userName = [dic stringSafeForKey:@"user_name"];
//    self.headimgurl = [dic stringSafeForKey:@"headimgurl"];
//    self.role = [dic stringSafeForKey:@"role"];
//    self.uid = [dic stringSafeForKey:@"uid"];
}


//desc = "\U7528\U6237\U4fe1\U606f\U83b7\U53d6\U6210\U529f\Uff01";
//enum = 0;
//id = 89;
//position = "\U4e13\U5bb6";
//"research_field" = "\U653f\U6cbb,\U6587\U5b66,\U5916\U4ea4";
//rnum = 0;
//success = 1;
//userImg = "/user/images/201607/08161406smkr.jpg";
//username = "\U738b\U5c0f\U5bd2";
- (void)getUserInfo:(GetUserInfoFinishBlock)getUserInfoFinishBlock
{
    [[WXFHttpClient shareInstance] postData:@"/app/comm/center/main.jspx" parameters:nil callBack:^(WXFParser *parser) {
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        if(code == 1){
            DefaultSetValueForKey(parser.responseDictionary, kUserInfo);
            self.userInfo = parser.responseDictionary;
            if(getUserInfoFinishBlock){
                getUserInfoFinishBlock(YES);
            }
        }else{
            if(getUserInfoFinishBlock){
                getUserInfoFinishBlock(NO);
            }
        }
        
       
        
    }];

}


- (NSString*)userName
{
    NSDictionary* dic = DefaultValueForKey(kUserInfo);
    return [dic stringSafeForKey:@"username"];
}

- (NSString*)userImg
{
    NSDictionary* dic = DefaultValueForKey(kUserInfo);
    return [dic stringSafeForKey:@"userImg"];
}

- (NSString*)research_field
{
    NSDictionary* dic = DefaultValueForKey(kUserInfo);
    return [dic stringSafeForKey:@"research_field"];
}

- (NSString*)position
{
    NSDictionary* dic = DefaultValueForKey(kUserInfo);
    return [dic stringSafeForKey:@"position"];
}

- (NSString*)rnum
{
    NSDictionary* dic = DefaultValueForKey(kUserInfo);
    return [dic stringSafeForKey:@"rnum"];
}

- (NSString*)enum_l
{
    NSDictionary* dic = DefaultValueForKey(kUserInfo);
    return [dic stringSafeForKey:@"enum"];
}

@end
