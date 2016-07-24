//
//  WXFSegmentView.h
//  BaseProject
//
//  Created by yongche_w on 16/7/17.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmentSelectBlock)(NSInteger index);

@interface WXFSegmentView : UIView

@property (nonatomic, strong) UIButton* button1;

@property (nonatomic, strong) UIButton* button2;

@property (nonatomic, copy) SegmentSelectBlock segmentSelectBlock;

- (void)setSelectIndex:(NSInteger)index;

@end
