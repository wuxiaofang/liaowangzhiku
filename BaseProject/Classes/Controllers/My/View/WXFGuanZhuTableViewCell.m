//
//  WXFGuanZhuTableViewCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFGuanZhuTableViewCell.h"

@interface WXFGuanZhuTableViewCell()

@property (nonatomic, strong) UIView* middleLine;

@end

@implementation WXFGuanZhuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.seperateLine = [[UIView alloc] init];
        [self addSubview:self.seperateLine];
        
        self.middleLine = [[UIView alloc] init];
        [self addSubview:self.middleLine];
        
        self.seperateLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        self.middleLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        
        self.gridView1 = [[WXFGridView alloc] init];
        self.gridView1.backgroundColor = [UIColor clearColor];
        [self addSubview:self.gridView1];
        
        self.gridView2 = [[WXFGridView alloc] init];
        [self addSubview:self.gridView2];
        
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
    
    self.middleLine.left = self.width / 2;
    self.middleLine.top = 0;
    self.middleLine.width = 0.5;
    self.middleLine.height = self.height;
    
    self.gridView1.left = 0;
    self.gridView1.top = 0;
    self.gridView1.width = self.width / 2;
    self.gridView1.height = self.height;
    
    self.gridView2.left = self.width / 2;
    self.gridView2.top = 0;
    self.gridView2.width = self.width / 2;
    self.gridView2.height = self.height;
    
}

@end

@implementation WXFGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapGesture
{
    if(self.didGridViewBlock){
        self.didGridViewBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat starty = (self.height - self.titleLabel.height - self.subLabel.height)/2;
    self.titleLabel.centerX = self.width / 2;
    self.titleLabel.top = starty;
    
    self.subLabel.centerX = self.width / 2;
    self.subLabel.top = self.titleLabel.bottom;
}

- (UILabel*)titleLabel
{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorFromRGB(0x1dbbe6);
        _titleLabel.font = [UIFont systemFontOfSize:30];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @" ";
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel*)subLabel
{
    if(_subLabel == nil){
        _subLabel = [[UILabel alloc] init];
        _subLabel.textColor = UIColorFromRGB(0x888888);
        _subLabel.font = [UIFont systemFontOfSize:12];
        _subLabel.textAlignment = NSTextAlignmentCenter;
        _subLabel.text = @" ";
        [self addSubview:_subLabel];
    }
    return _subLabel;
}


@end
