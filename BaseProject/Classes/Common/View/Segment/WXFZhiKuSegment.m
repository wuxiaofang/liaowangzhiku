//
//  WXFZhiKuSegment.m
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFZhiKuSegment.h"

@implementation WXFZhiKuSegment

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@interface WXFZhiKuSegmentItem()



@end

@implementation WXFZhiKuSegmentItem

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    [self.arrowImageView sizeToFit];
    
    if(self.arrowImageView.hidden){
        self.titleLabel.centerX = self.width / 2;
        
    }else{
        CGFloat startX = (self.width - self.titleLabel.width - 5 - self.arrowImageView.width) / 2;
        self.titleLabel.left = startX;
        self.arrowImageView.left = self.titleLabel.right + 5;
    }
    self.titleLabel.centerY = self.height / 2;
    self.arrowImageView.centerY = self.height / 2;
}

@end
