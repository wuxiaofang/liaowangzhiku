//
//  WXFUser.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/26.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFUser.h"

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
    NSString* username = DefaultValueForKey(@"username");
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

- (void)setUserName:(NSString *)userName
{
    if(userName.length > 0){
        DefaultSetValueForKey(userName, @"username")
    }
}

- (NSString*)userName
{
    NSString* username = DefaultValueForKey(@"username");
    if(username.length > 0){
        return username;
    }
    return @"";
}
- (void)logout
{
    DefaultSetValueForKey(@"", @"username");
    DefaultSetValueForKey(@YES, @"newUser");
}

- (void)parseUserInfo:(NSDictionary*)dic
{
    self.userName = [dic stringSafeForKey:@"user_name"];
    self.headimgurl = [dic stringSafeForKey:@"headimgurl"];
    self.role = [dic stringSafeForKey:@"role"];
    self.uid = [dic stringSafeForKey:@"uid"];
}

@end
