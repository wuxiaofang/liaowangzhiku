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
        self.iconImageView.contentMode = UIViewContentModeCenter;
        self.iconImageView.backgroundColor = UIColorFromRGB(0xcccccc);
        [self addSubview:self.iconImageView];
        
        self.titlelabel = [[UILabel alloc] init];
        self.titlelabel.font = [UIFont systemFontOfSize:18];
        self.titlelabel.textColor = UIColorFromRGB(0x000000);
        self.titlelabel.textAlignment = NSTextAlignmentLeft;
        self.titlelabel.text = @"  ";
        [self.titlelabel sizeToFit];
        [self addSubview:self.titlelabel];
        
        self.subTitle = [[UILabel alloc] init];
        self.subTitle.font = [UIFont systemFontOfSize:14];
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
    self.iconImageView.left = 8;
    self.iconImageView.top = (self.height - 57)/2;
    self.iconImageView.height = 57;
    self.iconImageView.width = 76;
    
    self.titlelabel.left = self.iconImageView.right + 10;
    self.titlelabel.top = self.iconImageView.top;
//    self.titlelabel.height = 20;
    self.titlelabel.width = self.width - self.iconImageView.right - 10 - 10;
    
    CGSize size = [self.subTitle.text sizeForFont:self.subTitle.font size:CGSizeMake(self.width - self.iconImageView.right - 10 - 10, 9999) mode:self.subTitle.lineBreakMode];
    
    NSString* teststring = @"你好\r\n智库";
    CGSize testsize = [teststring sizeForFont:self.subTitle.font size:CGSizeMake(self.width - self.iconImageView.right - 10 - 10, 9999) mode:self.subTitle.lineBreakMode];
    
    if(size.height > testsize.height + 3){
        size.height = testsize.height;
    }
    
    self.subTitle.left = self.iconImageView.right + 10;
    self.subTitle.top = self.titlelabel.bottom + 3;
    self.subTitle.height = size.height;
    self.subTitle.width = size.width;
    
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
