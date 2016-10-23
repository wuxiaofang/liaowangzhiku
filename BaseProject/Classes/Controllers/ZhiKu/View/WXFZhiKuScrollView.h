//
//  WXFZhiKuScrollView.h
//  BaseProject
//
//  Created by yongche_w on 16/10/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectBlock)(NSInteger index, NSDictionary* pageDataDic);

@interface WXFZhiKuScrollView : UIView

@property (nonatomic, copy)DidSelectBlock didSelectBlock;

- (void)reloadData:(NSArray*)dataDic;

@end


@class WXFZhiKuSinglePage;
typedef void(^SinglePageDidSelectBlock)(WXFZhiKuSinglePage* page);

@interface WXFZhiKuSinglePage : UIView

@property (nonatomic, assign, readonly) NSInteger index;

@property (nonatomic, strong, readonly) NSDictionary* pageDataDic;

@property (nonatomic, copy) SinglePageDidSelectBlock singlePageDidSelectBlock;

- (void)reloadPageData:(NSDictionary*)pageData index:(NSInteger)index;

@end
