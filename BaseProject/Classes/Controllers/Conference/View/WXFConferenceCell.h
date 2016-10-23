//
//  WXFConferenceCell.h
//  BaseProject
//
//  Created by yongche_w on 16/7/17.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXFConferenceCell : UITableViewCell

@property (nonatomic, strong) UIImageView* iconImageView;

@property (nonatomic, strong) UILabel* titlelabel;

@property (nonatomic, strong) UILabel* subTitle;

@property (nonatomic, strong) UIView* seperateLine;

@property (nonatomic, strong) UIView* myContentView;


- (CGFloat)getSubtitleHeigth;

@end
