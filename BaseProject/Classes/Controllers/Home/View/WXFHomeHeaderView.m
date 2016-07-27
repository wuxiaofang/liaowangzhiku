//
//  WXFHomeHeaderView.m
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFHomeHeaderView.h"

@implementation WXFHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.searchBar = [[WXFSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
     
    
        [self addSubview:self.searchBar];
        
        self.gridView = [[WXFHomeGridView alloc] initWithFrame:CGRectMake(0, 0, self.width, 250)];
        
        [self addSubview:self.gridView];
        
        self.backgroundColor = UIColorFromRGB(0xefeff4);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.searchBar.frame = CGRectMake(0, 0, self.width, 44);
    self.gridView.frame = CGRectMake(0, 44, self.width, 250);
    
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
