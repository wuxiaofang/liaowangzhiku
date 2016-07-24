//
//  WXFSegmentView.m
//  BaseProject
//
//  Created by yongche_w on 16/7/17.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFSegmentView.h"


@interface WXFSegmentView()



@property (nonatomic, strong) UIView* line;

@property (nonatomic, assign) NSInteger indexSelect;

@end

@implementation WXFSegmentView

- (instancetype)init
{
    self = [super init];
    if(self){
        [self setSelectIndex:0];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button1.left = 0;
    self.button1.top = 0;
    self.button1.width = self.width / 2;
    self.button1.height = self.height - 2;
    
    self.button2.left = self.width / 2;
    self.button2.top = 0;
    self.button2.width = self.width / 2;
    self.button2.height = self.height - 2;
    
    if(self.indexSelect == 0){
        self.line.left = 0;
        self.line.width = self.width / 2;
        self.line.top = self.height - 2;
        self.line.height = 2;
    }else{
        self.line.left = self.width / 2;
        self.line.width = self.width / 2;
        self.line.top = self.height - 2;
        self.line.height = 2;
    }
}

- (UIButton*)button1{
    if(_button1 == nil){
        _button1 = [[UIButton alloc] init];
        _button1.font = [UIFont systemFontOfSize:15];
        [_button1 setTitle:@"将召开会议" forState:UIControlStateNormal];
        [_button1 setTitleColor:UIColorFromRGB(0x323232) forState:UIControlStateNormal];
        [_button1 setTitleColor:UIColorFromRGB(0x1dbbe6) forState:UIControlStateSelected];
        [_button1 addTarget:self action:@selector(addButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_button1 setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xffffff)] forState:UIControlStateSelected];
        [_button1 setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xefeff4)] forState:UIControlStateNormal];
        _button1.tag = 0;
        [self addSubview:_button1];
    }
    return _button1;
}

- (UIButton*)button2{
    if(_button2 == nil){
        _button2 = [[UIButton alloc] init];
        _button2.font = [UIFont systemFontOfSize:15];
        [_button2 setTitle:@"已召开会议" forState:UIControlStateNormal];
        [_button2 setTitleColor:UIColorFromRGB(0x323232) forState:UIControlStateNormal];
        [_button2 setTitleColor:UIColorFromRGB(0x1dbbe6) forState:UIControlStateSelected];
        [_button2 addTarget:self action:@selector(addButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_button2 setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xffffff)] forState:UIControlStateSelected];
        [_button2 setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xefeff4)] forState:UIControlStateNormal];
        _button2.tag = 1;
        [self addSubview:_button2];
    }
    return _button2;
}

- (UIView*)line
{
    if(_line == nil){
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIColorFromRGB(0x1dbbe6);
        [self addSubview:_line];
    }
    return _line;
}

- (void)addButtonPress:(UIButton*)button
{
    [self setSelectIndex:button.tag];
    if(self.segmentSelectBlock){
        self.segmentSelectBlock(self.indexSelect);
    }
}

- (void)setSelectIndex:(NSInteger)index
{
    self.button1.selected = NO;
    self.button2.selected = NO;
    
    if(index == 0){
        self.button1.selected = YES;
        
    }else if(index == 1){
        self.button2.selected = YES;
    }
    self.indexSelect = index;
    
    if(self.indexSelect == 0){
        self.line.left = 0;
        self.line.width = self.width / 2;
        self.line.top = self.height - 2;
        self.line.height = 2;
    }else{
        self.line.left = self.width / 2;
        self.line.width = self.width / 2;
        self.line.top = self.height - 2;
        self.line.height = 2;
    }
}

@end
