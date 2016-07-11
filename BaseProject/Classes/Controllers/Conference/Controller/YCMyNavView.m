//
//  YCMyNavView.m
//  iWeidao
//
//  Created by yongche_w on 16/7/11.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "YCMyNavView.h"

@implementation YCMyNavView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.centerX = SCREEN_WIDTH/2;
    self.titleLabel.y = statusBarHeight;
}


- (UIButton *)backButton
{
    
    if(_backButton == nil){
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, 44, 44);
        UIImage *backImage = [UIImage imageNamed:@"icon_back"];
        [_backButton setImage:backImage forState:UIControlStateNormal];
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        [self addSubview:_backButton];
    }
    
    return _backButton;
    
    
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 150, 44)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"我的";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

@end
