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

/*
 * 用户基本信息
 */
@property (nonatomic, strong) NSDictionary* userInfo;

/*
 * 用户名
 */
@property (nonatomic, copy) NSString* userName;

/*
 * 用户头像
 */
@property (nonatomic, copy) NSString* userImg;

/*
 * 研究领域
 */
@property (nonatomic, copy) NSString* research_field;

/*
 * 职位
 */
@property (nonatomic, copy) NSString* position;

/*
 * 关注记者的数量
 */
@property (nonatomic, copy) NSString* rnum;

/*
 *  关注专家的数量
 */
@property (nonatomic, copy) NSString* enum_l;

/*
 * 用户的ID
 */
@property (nonatomic, copy) NSString* uid;


/*
 * 解析用户数据
 */
- (void)parseUserInfo:(NSDictionary*)dic;

/*
 * 单例模式
 */
+ (WXFUser*)instance;

/*
 * 判断用户是否登录
 * YES：登录状态；NO：非登录状态
 */
- (BOOL)isLogin;


- (BOOL)isNeedModifyPassword;

/*
 * 退出登录
 */
- (void)logout;

/*
 * 获取用户的登录信息
 * getUserInfoFinishBlock：回调的结果
 **/
- (void)getUserInfo:(GetUserInfoFinishBlock)getUserInfoFinishBlock;

@end
