//
//  WXFDevice.m
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "WXFDevice.h"
#import <AdSupport/AdSupport.h>
#import "SFHFKeychainUtils.h"
#define ServiceName   @"liaowangzhiku"

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

@property (nonatomic, strong) NSString* yongcheIdfv;

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

- (NSString*)yongcheIdfv
{
    if(_yongcheIdfv == nil){
        NSError *error = nil;
        NSString *userName = @"YONGCHEUUID";
        NSString *uuid;
        
        /** 保存用户的密码*/
        
        
        NSString *theUUID = [SFHFKeychainUtils getPasswordForUsername:userName
                                                       andServiceName:ServiceName
                                                                error:&error];
        if(error){
            NSLog(@"从Keychain里获取密码出错：%@", error);
        }
        
        BOOL isnotexist = NO;
        
        if (theUUID == nil || theUUID == NULL || theUUID.length == 0 || [theUUID isKindOfClass:[NSNull class]] || [theUUID isEqual:[NSNull null]]) {
            isnotexist = YES;
        }
        if ([[theUUID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
        {
            isnotexist = YES;
        }
        
        if (isnotexist) {
            uuid = [[[[[UIDevice currentDevice] identifierForVendor] UUIDString] md5String] lowercaseString];
            
            BOOL saved = [SFHFKeychainUtils storeUsername:userName
                                              andPassword:uuid
                                           forServiceName:ServiceName
                                           updateExisting:YES
                                                    error:&error ];
            if (!saved) {
                NSLog(@"保存密码时出错：%@", error);
            }
            theUUID = [NSString stringWithFormat:@"%@",uuid];
        }
        
        
        _yongcheIdfv = theUUID;
    }
    return _yongcheIdfv;
    
}

+ (NSString*)getIdentifierForVendor
{
    return [WXFDevice sharedInstance].yongcheIdfv;
}

@end