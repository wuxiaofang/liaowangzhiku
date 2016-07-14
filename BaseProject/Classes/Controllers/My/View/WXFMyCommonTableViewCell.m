//
//  WXFMyCommonTableViewCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/14.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFMyCommonTableViewCell.h"

@implementation WXFMyCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.width = 20;
        self.iconImageView.height = 20;

        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = UIColorFromRGB(0x000000);
        [self addSubview:self.titleLabel];
        
        
        self.arrowImageView = [[UIImageView alloc] init];
        self.arrowImageView.width = 5;
        self.arrowImageView.height = 8;
        self.arrowImageView.image = [UIImage imageNamed:@"cell_rightArrow"];
        [self addSubview:self.arrowImageView];
        
        self.seperateLine = [[UIView alloc] init];
        [self addSubview:self.seperateLine];
        
        self.seperateLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageView.left = 10;
    self.iconImageView.centerY = self.height / 2;
    
    self.titleLabel.left = self.iconImageView.right + 15;
    self.titleLabel.width = 300;
    self.titleLabel.height = 20;
    self.titleLabel.centerY = self.height / 2;
    
    self.arrowImageView.left = self.width - 9 - self.arrowImageView.width;
    self.arrowImageView.centerY = self.height / 2;
    
    self.seperateLine.left = 0;
    self.seperateLine.top = 0;
    self.seperateLine.width = self.width;
    self.seperateLine.height = 0.5;
    
}

@end
