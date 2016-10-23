//
//  WXFGuidePageView.m
//  BaseProject
//
//  Created by yongche_w on 16/10/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFGuidePageView.h"

@interface WXFGuidePageView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation WXFGuidePageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSelfView];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)tapGestureRecognizer:(UITapGestureRecognizer*)tap
{
    if(self.guidePageViewDidSelectBlock){
        self.guidePageViewDidSelectBlock(self.tag);
    }
}


- (void)setupSelfView
{
    [self addSubview:self.imageView];
}

- (void)setImageContentMode:(UIViewContentMode)contentMode
{
    [self.imageView setContentMode:contentMode];
    self.imageView.layer.masksToBounds = YES;
}

- (void)setImagePageWithUrl:(NSString *)url
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

- (void)setImagePageWithImage:(UIImage *)image
{
    _imageView.image = image;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}


@end
