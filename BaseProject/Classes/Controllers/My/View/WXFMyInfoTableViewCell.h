//
//  WXFMyInfoTableViewCell.h
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXFMyInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView* userImageView;

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UILabel* subLabel;

@property (nonatomic, strong) UILabel* subSubLabel;

@property (nonatomic, strong) UIImageView* arrowImageView;

@property (nonatomic, strong) UIView* seperateLine;

- (void)reloadData;

@end
