//
//  WXFSearchBar.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFSearchBar.h"

@implementation WXFSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.bgImageView.backgroundColor = [UIColor whiteColor];
        self.bgImageView.layer.cornerRadius = 3;
        self.bgImageView.layer.masksToBounds = YES;
        self.bgImageView.layer.borderColor = UIColorFromRGB(0xe4e4e4).CGColor;
        self.bgImageView.layer.borderWidth = 0.5;
        
        self.searchImageView.image = [UIImage imageNamed:@"Magnifier"];
        [self.searchImageView sizeToFit];
        self.searchImageView.frame = CGRectIntegral(self.searchImageView.frame);
        
        self.contentLabel.text = @"输入专家、记者、智库、圈子";
        [self.contentLabel sizeToFit];
        self.contentLabel.frame = CGRectIntegral(self.contentLabel.frame);
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapGesture
{
    if(self.searchBarDidBlock){
        self.searchBarDidBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgImageView.left = 10;
    self.bgImageView.top = 8;
    self.bgImageView.height = self.height - 16;
    self.bgImageView.width = self.width - 20;
    
    self.searchImageView.left = 20;
    self.searchImageView.centerY = self.height / 2;
    
    self.contentLabel.left = self.searchImageView.right + 5;
    self.contentLabel.centerY = self.height / 2;
}

- (UIImageView*)bgImageView
{
    if(_bgImageView == nil){
        _bgImageView = [[UIImageView alloc] init];
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UIImageView*)searchImageView
{
    if(_searchImageView == nil){
        _searchImageView = [[UIImageView alloc] init];
        [self addSubview:_searchImageView];
    }
    return _searchImageView;
}

- (UILabel*)contentLabel
{
    if(_contentLabel == nil){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = UIColorFromRGB(0x828282);
        _contentLabel.font = [UIFont systemFontOfSize:12.0f];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.userInteractionEnabled = YES;
        [self addSubview:_contentLabel];
        
        
    }
    return _contentLabel;
}

@end
