//
//  NSDictionary+SafeData.h
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016年 yongche. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSDictionary(SafeData)

- (id)objectSafeForKey:(NSString*)key;

- (NSArray*)arraySafeForKey:(NSString*)key;

- (NSDictionary*)dictionarySafeForKey:(NSString*)key;

- (NSString*)stringSafeForKey:(NSString*)key;

- (NSMutableArray*)mutableArraySafeForKey:(NSString*)key;

- (NSMutableDictionary*)mutableDictionarySafeForKey:(NSString*)key;

- (NSInteger)integerSafeForKey:(NSString*)key;

- (CGFloat)floatSafeForKey:(NSString*)key;

- (double)doubleSafeForKey:(NSString*)key;

- (NSNumber*)numberSafeForKey:(NSString*)key;

- (int)intSafeForKey:(NSString*)key;

@end
