//
//  WXFHomeIconButton.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFHomeIconButton.h"

@implementation WXFHomeIconButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];

        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = UIColorFromRGB(0x000000);
        self.label.font = [UIFont systemFontOfSize:16.0f];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView sizeToFit];
    [self.label sizeToFit];
//    
//    CGFloat starty = (self.height - self.iconImageView.height - 5 - self.label.height) / 2;
    
    self.iconImageView.top = 24;
    self.iconImageView.centerX = self.width / 2;
    
    self.label.top = self.iconImageView.bottom + 5;
    self.label.centerX = self.width / 2;
}



@end
