//
//  WXFHomeTableViewCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFHomeTableViewCell.h"

@implementation WXFHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        
        self.titlelabel = [[UILabel alloc] init];
        self.titlelabel.font = [UIFont systemFontOfSize:16];
        self.titlelabel.textColor = UIColorFromRGB(0x000000);
        self.titlelabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titlelabel];
        
        self.subTitle = [[UILabel alloc] init];
        self.subTitle.font = [UIFont systemFontOfSize:12];
        self.subTitle.textColor = UIColorFromRGB(0x828288);
        self.subTitle.textAlignment = NSTextAlignmentLeft;
        self.subTitle.numberOfLines = 0;
        self.subTitle.lineBreakMode = NSLineBreakByWordWrapping;

        [self addSubview:self.subTitle];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconImageView.left = 9;
    self.iconImageView.top = 8;
    self.iconImageView.height = self.height - 16;
    self.iconImageView.width = self.iconImageView.height + 10;
    
    self.titlelabel.left = self.iconImageView.right + 8;
    self.titlelabel.top = self.iconImageView.top;
    self.titlelabel.height = 20;
    self.titlelabel.width = self.width - self.iconImageView.right - 8 - 8;
    
    self.subTitle.left = self.iconImageView.right + 8;
    self.subTitle.top = self.titlelabel.bottom + 9;
    self.subTitle.height = (self.height - 8 - 8 - self.titlelabel.height - 9);
    self.subTitle.width = self.width - self.iconImageView.right - 8 - 8;
    
    self.seperateLine.left = 0;
    self.seperateLine.top = self.height - 0.5;
    self.seperateLine.width = self.width;
    self.seperateLine.height = 0.5;
}

- (UIView*)seperateLine
{
    if(_seperateLine == nil){
        _seperateLine = [[UIView alloc] init];
        _seperateLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:_seperateLine];
    }
    return _seperateLine;
}

@end
