//
//  WXFSegmentPopView.h
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSegmentPopBlock)(NSInteger index);

@interface WXFSegmentPopView : UIView

- (void)showIn:(UIView*)superView
         frame:(CGRect)frame
     dataArray:(NSArray*)dataArray
         title:(NSString*)title
didSelectBlock:(DidSegmentPopBlock)didSelectBlock;

@end

@interface WXFSegmentPopViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* myLabel;

@property (nonatomic, strong) UIView* seperateLine;

@end

@interface WXFSegmentPopHeaderView : UIView

@property (nonatomic, strong) UILabel* myLabel;

@property (nonatomic, strong) UIView* seperateLine;

@end

