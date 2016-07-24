//
//  WXFZhiKuSegment.h
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXFZhiKuSegmentItem;

typedef void(^ZhuTiSegmentSelectBlock)(NSInteger index);

@interface WXFZhiKuSegment : UIView

@property (nonatomic, copy) ZhuTiSegmentSelectBlock zhuTiSegmentSelectBlock;

@property (nonatomic, strong)WXFZhiKuSegmentItem* item1;

@property (nonatomic, strong)WXFZhiKuSegmentItem* item2;

- (void)setSelectIndex:(NSInteger)index;

@end


@interface WXFZhiKuSegmentItem : UIControl

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIImageView* arrowImageView;

@end