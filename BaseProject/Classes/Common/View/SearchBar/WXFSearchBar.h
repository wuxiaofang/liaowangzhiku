//
//  WXFSearchBar.h
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchBarDidBlock)();

@interface WXFSearchBar : UIView

@property (nonatomic, copy)SearchBarDidBlock searchBarDidBlock;

@property (nonatomic, strong) UIImageView* bgImageView;

@property (nonatomic, strong) UILabel* contentLabel;

@property (nonatomic, strong) UIImageView* searchImageView;

@end
