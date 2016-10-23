//
//  WXFGuideView.h
//  BaseProject
//
//  Created by yongche_w on 16/10/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DidGuideSelectBlock)(NSInteger index);

@interface WXFGuideView : UIView

@property (nonatomic, copy)DidGuideSelectBlock didSelectBlock;

- (void)reloadImages:(NSArray*)images;

@end
