//
//  WXFHomeGridView.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFHomeGridView.h"
#import "WXFHomeIconButton.h"

@interface WXFHomeGridView()

@property (nonatomic, strong) UIView* hSeperateLine1;

@property (nonatomic, strong) UIView* hSeperateLine2;

@property (nonatomic, strong) UIView* hSeperateLine3;

@property (nonatomic, strong) UIView* sSeperateLine1;

@property (nonatomic, strong) WXFHomeIconButton* iconButton1;
@property (nonatomic, strong) WXFHomeIconButton* iconButton2;
@property (nonatomic, strong) WXFHomeIconButton* iconButton3;
@property (nonatomic, strong) WXFHomeIconButton* iconButton4;

@end

@implementation WXFHomeGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        {
            WXFHomeIconButton* button = [[WXFHomeIconButton alloc] init];
            button.iconImageView.image = [UIImage imageNamed:@"home_01btn4_1"];
            button.label.text = @"专家";
            button.tag = 0;
            [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            self.iconButton1 = button;
        }
        
        {
            WXFHomeIconButton* button = [[WXFHomeIconButton alloc] init];
            button.iconImageView.image = [UIImage imageNamed:@"home_01btn4_2"];
            button.label.text = @"记者";
            button.tag = 1;
            [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            self.iconButton2 = button;
        }
        
        {
            WXFHomeIconButton* button = [[WXFHomeIconButton alloc] init];
            button.iconImageView.image = [UIImage imageNamed:@"home_01btn4_3"];
            button.label.text = @"智库";
            button.tag = 2;
            [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            self.iconButton3 = button;
        }
        
        {
            WXFHomeIconButton* button = [[WXFHomeIconButton alloc] init];
            button.iconImageView.image = [UIImage imageNamed:@"home_01btn4_4"];
            button.label.text = @"圈子";
            button.tag = 3;
            [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            self.iconButton4 = button;
        }
        
    }
    return self;
}

- (void)buttonPress:(UIControl*)control
{

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.hSeperateLine1.left = 0;
    self.hSeperateLine1.top = 0;
    self.hSeperateLine1.width = self.width;
    self.hSeperateLine1.height = 0.5;
    
    self.hSeperateLine2.left = 0;
    self.hSeperateLine2.top = self.height / 2;
    self.hSeperateLine2.width = self.width;
    self.hSeperateLine2.height = 0.5;
    
    self.hSeperateLine3.left = 0;
    self.hSeperateLine3.top = self.height - 0.5;
    self.hSeperateLine3.width = self.width;
    self.hSeperateLine3.height = 0.5;
    
    self.sSeperateLine1.left = self.width / 2;
    self.sSeperateLine1.top = 0.5;
    self.sSeperateLine1.width = 0.5;
    self.sSeperateLine1.height = self.height - 1;
    
    self.iconButton1.left = 0;
    self.iconButton1.top = 0;
    self.iconButton1.width = self.width / 2;
    self.iconButton1.height = self.height / 2;
    
    self.iconButton2.left = self.width / 2;
    self.iconButton2.top = 0;
    self.iconButton2.width = self.width / 2;
    self.iconButton2.height = self.height / 2;
    
    self.iconButton3.left = 0;
    self.iconButton3.top = self.height / 2;
    self.iconButton3.width = self.width / 2;
    self.iconButton3.height = self.height / 2;
    
    self.iconButton4.left = self.width / 2;
    self.iconButton4.top = self.height / 2;
    self.iconButton4.width = self.width / 2;
    self.iconButton4.height = self.height / 2;
}


- (UIView*)hSeperateLine1
{
    if(_hSeperateLine1 == nil){
        _hSeperateLine1 = [[UIView alloc] init];
        _hSeperateLine1.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:_hSeperateLine1];
    }
    return _hSeperateLine1;
}

- (UIView*)hSeperateLine2
{
    if(_hSeperateLine2 == nil){
        _hSeperateLine2 = [[UIView alloc] init];
        _hSeperateLine2.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:_hSeperateLine2];
    }
    return _hSeperateLine2;
}

- (UIView*)hSeperateLine3
{
    if(_hSeperateLine3 == nil){
        _hSeperateLine3 = [[UIView alloc] init];
        _hSeperateLine3.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:_hSeperateLine3];
    }
    return _hSeperateLine3;
}

- (UIView*)sSeperateLine1
{
    if(_sSeperateLine1 == nil){
        _sSeperateLine1 = [[UIView alloc] init];
        _sSeperateLine1.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:_sSeperateLine1];
    }
    return _sSeperateLine1;
}

@end
