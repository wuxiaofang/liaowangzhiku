//
//  WXFHomeHeaderView.h
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXFSearchBar.h"
#import "WXFHomeGridView.h"

#define kHeaderHeigth     304

@interface WXFHomeHeaderView : UIView

@property (nonatomic, strong) UIView* seperateLine;

@property (nonatomic, strong) WXFSearchBar* searchBar;

@property (nonatomic, strong) WXFHomeGridView* gridView;

@end
