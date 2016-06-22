//
//  NSString+extend.m
//  iYongche
//
//  Created by 张晓飞 on 16/2/17.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "NSString+extend.h"

@implementation NSString (extend)

- (BOOL)versionGreaterThanOrEqualTo:(NSString *)aVersion{
    return ![self versionLessThan:aVersion];
}

- (BOOL)versionGreaterThan:(NSString*)aVersion{
    
    return ![self versionLessThanOrEqualTo:aVersion];
}

- (BOOL)versionLessThanOrEqualTo:(NSString*)aVersion{
    return [self versionLessThan:aVersion] || [self versionEqualTo:aVersion];
}

#pragma mark -  字符串版本号大小比较
- (NSArray *)versionNumbers{
    NSString * string = [self stringByReplacingOccurrencesOfString:@"_" withString:@"."];
    return [string componentsSeparatedByString:@"."];
}

- (BOOL)versionLessThan:(NSString *)aVersion{
    NSArray *nums = [self versionNumbers];
    NSArray *aNums = [aVersion versionNumbers];
    
    __block BOOL lessThan = NO;
    __block BOOL decide = NO;
    [nums enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        long long v = [obj longLongValue];
        if ([aNums count] > idx) {
            long long aV = [[aNums objectAtIndex:idx] longLongValue];
            if (v < aV) {
                lessThan = YES;
                decide = YES;
                *stop = YES;
            } else if (v > aV) {
                lessThan = NO;
                decide = YES;
                *stop = YES;
            }
        } else {
            *stop = YES;
        }
    }];
    
    if ([aNums count] > [nums count] && decide == NO) {
        for (NSInteger i = [nums count]; i < [aNums count]; i ++) {
            long long num = [[aNums objectAtIndex:i] longLongValue];
            if (num != 0) {
                lessThan = YES;
                break;
            }
        }
    }
    
    return lessThan;
}

- (BOOL)versionEqualTo:(NSString*)aVersion{
    NSArray *nums = [self versionNumbers];
    NSArray *aNums = [aVersion versionNumbers];
    
    __block BOOL equal = YES;
    __block BOOL decide = NO;
    [nums enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        long long v = [obj longLongValue];
        if ([aNums count] > idx) {
            long long aV = [[aNums objectAtIndex:idx] longLongValue];
            if (v != aV) {
                equal = NO;
                decide = YES;
                *stop = YES;
            }
        } else {
            if (v != 0) {
                equal = NO;
                decide = YES;
            }
        }
    }];
    
    if ([aNums count] > [nums count] && decide == NO) {
        for (NSInteger i = [nums count]; i < [aNums count]; i ++) {
            long long num = [[aNums objectAtIndex:i] longLongValue];
            if (num != 0) {
                equal = NO;
                break;
            }
        }
    }
    
    return equal;
}


- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding
{
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 1 || kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSMutableArray* values = [pairs objectForKey:key];
            if (nil == values) {
                values = [NSMutableArray array];
                [pairs setObject:values forKey:key];
            }
            if (kvPair.count == 1) {
                [values addObject:[NSNull null]];
                
            } else if (kvPair.count == 2) {
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:encoding];
                [values addObject:value];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}



@end
