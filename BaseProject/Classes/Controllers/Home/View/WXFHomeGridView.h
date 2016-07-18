//
//  WXFHomeGridView.h
//  BaseProject
//
//  Created by yongche_w on 16/7/13.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GridViewDidBlock)(NSInteger index);

@interface WXFHomeGridView : UIView

@property (nonatomic, copy)GridViewDidBlock gridViewDidBlock;

@end
