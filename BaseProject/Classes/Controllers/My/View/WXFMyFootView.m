//
//  WXFMyFootView.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFMyFootView.h"

@interface WXFMyFootView()

@property (nonatomic, strong) UIView* seperateLine;

@end

@implementation WXFMyFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        self.backgroundColor = UIColorFromRGB(0xefeff4);
//        self.backgroundColor = [UIColor grayColor];
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
    self.seperateLine.top = self.height - 0.5;
    self.seperateLine.width = self.width;
    self.seperateLine.height = 0.5;
}


@end
