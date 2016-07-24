//
//  WXFQuznZITableViewCell.h
//  BaseProject
//
//  Created by yongche_w on 16/7/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXFQuznZIGridView;


@interface WXFQuznZITableViewCell : UITableViewCell

@property (nonatomic, strong) WXFQuznZIGridView* gridView1;

@property (nonatomic, strong) WXFQuznZIGridView* gridView2;

@end


typedef void(^QuanZiDidBlock)(NSDictionary* dic);

@interface WXFQuznZIGridView : UIView

@property (nonatomic, copy) QuanZiDidBlock quanZiDidBlock;

@property (nonatomic, strong) UIImageView* profileImageView;

@property (nonatomic, strong) UIImageView* userHeaderImageView;

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UILabel* usernameLabel;

@property (nonatomic, strong) NSDictionary* dic;

- (void)reloadData:(NSDictionary*)dictionary;

@end
