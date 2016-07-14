//
//  WXFCategoryCommonHeader.h
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016年 yongche. All rights reserved.
//

#ifndef WXFCategoryCommonHeader_h
#define WXFCategoryCommonHeader_h

#import "YYKitMacro.h"
#import "NSData+YYAdd.h"
#import "NSNumber+YYAdd.h"
#import "NSString+YYAdd.h"
#import "UIDevice+YYAdd.h"
#import "UIView+Frame.h"
#import "NSDictionary+SafeData.h"
#import "NSObject+YCAddition.h"
#import "NSString+extend.h"
#import "UIColor+Factory.h"
#import "WXFDevice.h"
#import "UIImage+Extension.h"
#import "NSArray+Common.h"
#import "UIWebView+Extend.h"

//文件路径
#define kPATH_OF_APP_HOME       NSHomeDirectory()
#define kPATH_OF_TEMP           NSTemporaryDirectory()
#define kPATH_OF_DOCUMENT       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPATH_OF_CACHES         [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


//NSUserDefaults

#define DefaultValueForKey(key)             [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define DefaultSetValueForKey(value,key)    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

//NSLog
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


//Screen
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* WXFCategoryCommonHeader_h */
