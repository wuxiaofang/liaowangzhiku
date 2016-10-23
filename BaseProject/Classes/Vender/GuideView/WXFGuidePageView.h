//
//  WXFGuidePageView.h
//  BaseProject
//
//  Created by yongche_w on 16/10/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GuidePageViewDidSelectBlock)(NSInteger index);

@interface WXFGuidePageView : UIView


@property (nonatomic, copy) GuidePageViewDidSelectBlock guidePageViewDidSelectBlock;

- (void)setImageContentMode:(UIViewContentMode)contentMode;
- (void)setImagePageWithUrl:(NSString *)url;
- (void)setImagePageWithImage:(UIImage *)image;

@end
