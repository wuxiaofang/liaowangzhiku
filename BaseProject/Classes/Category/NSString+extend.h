//
//  NSString+extend.h
//  iYongche
//
//  Created by 张晓飞 on 16/2/17.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (extend)

- (BOOL)versionGreaterThanOrEqualTo:(NSString *)aVersion;

- (BOOL)versionGreaterThan:(NSString*)aVersion;

- (BOOL)versionLessThanOrEqualTo:(NSString*)aVersion;

@end
