//
//  WXFDevice.h
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//判断设备类型
#define DeviceIsIphone4 ([WXFDevice deviceIsIPhone4])
#define DeviceIsIphone5 ([WXFDevice deviceIsIPhone5])
#define DeviceIsIphone6 ([WXFDevice deviceIsIPhone6])
#define DeviceIsIphone6plus ([WXFDevice deviceIsIPhone6p])

@interface WXFDevice : NSObject

+(WXFDevice *)sharedInstance;

/*
 * 获取当前设备的广告ID
 *
 ***/
+ (NSString*)getAdId;


/*
 * 判断设备类型
 * iPhone4
 **/
+ (BOOL)deviceIsIPhone4;

/*
 * 判断设备类型
 * iPhone5
 **/
+ (BOOL)deviceIsIPhone5;

/*
 * 判断设备类型
 * iPhone6
 **/
+ (BOOL)deviceIsIPhone6;

/*
 * 判断设备类型
 * iPhone6p
 **/
+ (BOOL)deviceIsIPhone6p;

/*
 * 图片的scale
 *
 **/
+ (CGFloat)imageScale;

/*
 * 设备剩余空间
 *
 **/
+ (NSInteger)freeDiskSpace;

@end
