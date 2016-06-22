//
//  WXFDevice.m
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "WXFDevice.h"
#import <AdSupport/AdSupport.h>


typedef enum
{
    WXFDeviceTypeForNone = -1,
    WXFDeviceTypeForIPhone4 = 1,
    WXFDeviceTypeForIPhone5 = 2,
    WXFDeviceTypeForIPhone6 = 3,
    WXFDeviceTypeForIPhone6p = 4,
    WXFDeviceTypeForOther = 1000
}WXFDeviceType;

@interface WXFDevice()

@property (nonatomic, assign) WXFDeviceType deviceType;

@end

@implementation WXFDevice

+(WXFDevice *)sharedInstance
{
    static WXFDevice *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WXFDevice alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        _deviceType = WXFDeviceTypeForIPhone6;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        if(CGSizeEqualToSize(CGSizeMake(320, 480), screenSize)){
            _deviceType = WXFDeviceTypeForIPhone4;
        }else if(CGSizeEqualToSize(CGSizeMake(320, 568), screenSize)){
            _deviceType = WXFDeviceTypeForIPhone5;
        }else if(CGSizeEqualToSize(CGSizeMake(375, 667), screenSize)){
            _deviceType = WXFDeviceTypeForIPhone6;
        }else if(CGSizeEqualToSize(CGSizeMake(414, 736), screenSize)){
            _deviceType = WXFDeviceTypeForIPhone6p;
        }
    }
    return self;
}

+ (NSString*)getAdId
{
    NSString *adId = [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
    if (!adId) {
        adId = @"";
    }
    return adId;
}


+ (BOOL)deviceIsIPhone4
{
    if([WXFDevice sharedInstance].deviceType == WXFDeviceTypeForIPhone4){
        return YES;
    }
    return NO;
}

+ (BOOL)deviceIsIPhone5
{
    if([WXFDevice sharedInstance].deviceType == WXFDeviceTypeForIPhone5){
        return YES;
    }
    return NO;
}

+ (BOOL)deviceIsIPhone6
{
    if([WXFDevice sharedInstance].deviceType == WXFDeviceTypeForIPhone6){
        return YES;
    }
    return NO;
}

+ (BOOL)deviceIsIPhone6p
{
    if([WXFDevice sharedInstance].deviceType == WXFDeviceTypeForIPhone6p){
        return YES;
    }
    return NO;
}

+ (CGFloat)imageScale
{
    CGFloat scale = [UIScreen mainScreen].scale;
    if(![WXFDevice deviceIsIPhone6p] && (scale > 2)){
        scale = 2;
    }
    return scale;
}

+ (NSInteger)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    if(fattributes){
        NSNumber * fileSystemSizeInBytes = [fattributes objectForKey:NSFileSystemFreeSize];;
        double totalSpace = [fileSystemSizeInBytes doubleValue];
        totalSpace = totalSpace / 1024 / 1024;
        return (NSInteger)totalSpace;
    }
    return 0;
    
}

@end