//
//  WXFMyLogoutTableViewCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/14.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFMyLogoutTableViewCell.h"

@implementation WXFMyLogoutTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = UIColorFromRGB(0x000000);
        self.titleLabel.text = @"退出登录";
        [self addSubview:self.titleLabel];
        
        
        self.seperateLine = [[UIView alloc] init];
        [self addSubview:self.seperateLine];
        
        self.seperateLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.seperateLine.left = 0;
    self.seperateLine.top = 0;
    self.seperateLine.width = self.width;
    self.seperateLine.height = 0.5;
    
    self.titleLabel.frame = self.bounds;
    
}

@end
