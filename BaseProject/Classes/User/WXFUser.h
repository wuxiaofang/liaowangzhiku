//
//  WXFUser.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/26.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetUserInfoFinishBlock)(BOOL isSuccess);

@interface WXFUser : NSObject

@property (nonatomic, strong) NSDictionary* userInfo;

@property (nonatomic, copy) NSString* userName; //名字

@property (nonatomic, copy) NSString* userImg;  //头像

@property (nonatomic, copy) NSString* research_field; //研究领域

@property (nonatomic, copy) NSString* position; //职位

@property (nonatomic, copy) NSString* rnum; //关注记者的数量

@property (nonatomic, copy) NSString* enum_l; //关注专家的数量

- (void)parseUserInfo:(NSDictionary*)dic;

+ (WXFUser*)instance;

- (BOOL)isLogin;

- (BOOL)isNeedModifyPassword;

- (void)logout;

- (void)getUserInfo:(GetUserInfoFinishBlock)getUserInfoFinishBlock;

@end
