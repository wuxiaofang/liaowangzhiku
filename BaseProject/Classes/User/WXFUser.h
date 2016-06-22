//
//  WXFUser.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/26.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXFUser : NSObject

@property (nonatomic, copy) NSString* userName;

@property (nonatomic, copy) NSString* headimgurl;

@property (nonatomic, copy) NSString* role;

@property (nonatomic, copy) NSString* uid;

- (void)parseUserInfo:(NSDictionary*)dic;

+ (WXFUser*)instance;

- (BOOL)isLogin;

- (BOOL)isNeedModifyPassword;

- (void)logout;

@end
