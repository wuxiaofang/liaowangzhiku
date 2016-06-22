//
//  WXFShareCenter.h
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WXFShareCenter : NSObject

+ (instancetype)instance;


- (void)registerThirdSDK;

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url;



@end
