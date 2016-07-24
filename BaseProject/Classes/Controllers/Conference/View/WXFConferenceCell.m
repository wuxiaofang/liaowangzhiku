//
//  WXFConferenceCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/17.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFConferenceCell.h"

@implementation WXFConferenceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.backgroundColor = [UIColor clearColor];
        self.myContentView = [[UIView alloc] init];
        self.myContentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.myContentView];
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.backgroundColor = UIColorFromRGB(0xcccccc);
        [self.myContentView addSubview:self.iconImageView];
        
        self.titlelabel = [[UILabel alloc] init];
        self.titlelabel.font = [UIFont systemFontOfSize:16];
        self.titlelabel.textColor = UIColorFromRGB(0x000000);
        self.titlelabel.textAlignment = NSTextAlignmentLeft;
        [self.myContentView addSubview:self.titlelabel];
        
        self.subTitle = [[UILabel alloc] init];
        self.subTitle.font = [UIFont systemFontOfSize:12];
        self.subTitle.textColor = UIColorFromRGB(0x828288);
        self.subTitle.textAlignment = NSTextAlignmentLeft;
        self.subTitle.numberOfLines = 0;
        self.subTitle.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.myContentView addSubview:self.subTitle];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.myContentView.left = 0;
    self.myContentView.top = 0;
    self.myContentView.height = self.height - 8;
    self.myContentView.width = self.width;
    
    self.iconImageView.left = 0;
    self.iconImageView.top = 0;
    self.iconImageView.height = 180;
    self.iconImageView.width = self.myContentView.width;
    
    self.titlelabel.left = 9;
    self.titlelabel.top = self.iconImageView.bottom + 10;
    self.titlelabel.height = 20;
    self.titlelabel.width = self.width - 16;
    
    self.subTitle.left = 9;
    self.subTitle.top = self.titlelabel.bottom + 13;
    self.subTitle.height = 40;
    self.subTitle.width = self.width - 20;
    
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
