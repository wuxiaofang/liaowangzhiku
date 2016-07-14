//
//  WXFGuanZhuTableViewCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFGuanZhuTableViewCell.h"

@implementation WXFGuanZhuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
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
    
}

@end
