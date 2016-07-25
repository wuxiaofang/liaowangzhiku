//
//  WXFReporterTableViewCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFReporterTableViewCell.h"

@implementation WXFReporterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        self.userImageView = [[UIImageView alloc] init];
        self.userImageView.width = 60;
        self.userImageView.height = 60;
        self.userImageView.layer.masksToBounds = YES;
        self.userImageView.layer.cornerRadius = 30;
        self.userImageView.backgroundColor = UIColorFromRGB(0xcccccc);
        [self addSubview:self.userImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = UIColorFromRGB(0x000000);
        [self addSubview:self.titleLabel];
        
        self.subLabel = [[UILabel alloc] init];
        self.subLabel.font = [UIFont systemFontOfSize:14.0f];
        self.subLabel.textAlignment = NSTextAlignmentLeft;
        self.subLabel.textColor = UIColorFromRGB(0x828282);
        [self addSubview:self.subLabel];
        
        self.subSubLabel = [[UILabel alloc] init];
        self.subSubLabel.font = [UIFont systemFontOfSize:14.0f];
        self.subSubLabel.textAlignment = NSTextAlignmentLeft;
        self.subSubLabel.textColor = UIColorFromRGB(0x828282);
        [self addSubview:self.subSubLabel];
        
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
    
    self.userImageView.left = 10;
    self.userImageView.centerY = self.height / 2;
    
    self.arrowImageView.left = self.width - 9 - self.arrowImageView.width;
    self.arrowImageView.centerY = self.height / 2;
    
    self.seperateLine.left = 0;
    self.seperateLine.top = 0;
    self.seperateLine.width = self.width;
    self.seperateLine.height = 0.5;
    
    CGFloat starty = (self.height - self.titleLabel.height - 2 - self.subLabel.height - self.subSubLabel.height) / 2;
    
    self.titleLabel.left = self.userImageView.right + 5;
    self.titleLabel.top = starty;
    
    self.subLabel.left = self.userImageView.right + 5;
    self.subLabel.top = self.titleLabel.bottom + 2;
    
    self.subSubLabel.left = self.userImageView.right + 5;
    self.subSubLabel.top = self.subLabel.bottom;
    
}



@end
