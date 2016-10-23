//
//  WXFZhiKuSegment.m
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFZhiKuSegment.h"

@interface WXFZhiKuSegment()

@property (nonatomic, strong) UIView* bottomLine;

@property (nonatomic, strong) UIView* middleLine;


@end

@implementation WXFZhiKuSegment

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.item1 = [[WXFZhiKuSegmentItem alloc] init];
        [self addSubview:self.item1];
        [self.item1 addTarget:self action:@selector(item1DidPress) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.item2 = [[WXFZhiKuSegmentItem alloc] init];
        [self addSubview:self.item2];
        [self.item2 addTarget:self action:@selector(item2DidPress) forControlEvents:UIControlEventTouchUpInside];
        
        self.bottomLine = [[UIView alloc] init];
        self.bottomLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:self.bottomLine];
        
        self.middleLine = [[UIView alloc] init];
        self.middleLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:self.middleLine];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.item1.frame = CGRectMake(0, 0, self.width / 2, self.height);
    self.item2.frame = CGRectMake(self.width / 2, 0, self.width / 2, self.height);
    
    self.middleLine.frame = CGRectMake(self.width / 2, 0, 0.5, self.height - 0.5);
    self.bottomLine.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

- (void)setSelectIndex:(NSInteger)index
{
    if(index == 0){
        self.item1.selected = YES;
        self.item2.selected = NO;
    }else{
        self.item1.selected = NO;
        self.item2.selected = YES;
    }
}

- (void)item1DidPress
{
    [self setSelectIndex:0];
    if(self.zhuTiSegmentSelectBlock){
        self.zhuTiSegmentSelectBlock(0);
    }
}

- (void)item2DidPress
{
   [self setSelectIndex:1];
    if(self.zhuTiSegmentSelectBlock){
        self.zhuTiSegmentSelectBlock(1);
    }
}

@end




@implementation WXFZhiKuSegmentItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        self.arrowImageView = [[UIImageView alloc] init];
        [self addSubview:self.arrowImageView];
        
        self.titleLabel.textColor = UIColorFromRGB(0x828282);
        self.arrowImageView.image = [UIImage imageNamed:@"arrow_up"];
    }
    return self;
}

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

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
//    if(selected){
//        self.titleLabel.textColor = UIColorFromRGB(0x1dbbe6);
//        self.arrowImageView.image = [UIImage imageNamed:@"arrow_up"];
//    }else{
//        self.titleLabel.textColor = UIColorFromRGB(0x828282);
//        self.arrowImageView.image = [UIImage imageNamed:@"arrow_down"];
//    }
}
@end
