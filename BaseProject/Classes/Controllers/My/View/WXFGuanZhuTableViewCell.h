//
//  WXFGuanZhuTableViewCell.h
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXFGridView;

typedef void(^DidGridViewBlock)();

@interface WXFGuanZhuTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView* seperateLine;

@property (nonatomic, strong) WXFGridView* gridView1;


@property (nonatomic, strong) WXFGridView* gridView2;

@end

@interface WXFGridView : UIView

@property (nonatomic, strong) DidGridViewBlock didGridViewBlock;

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UILabel* subLabel;

@end
