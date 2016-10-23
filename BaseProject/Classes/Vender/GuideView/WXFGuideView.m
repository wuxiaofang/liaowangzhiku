//
//  WXFGuideView.m
//  BaseProject
//
//  Created by yongche_w on 16/10/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFGuideView.h"


#import "WXFGuidePageView.h"

@interface WXFGuideView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) NSMutableArray* singlePageArray;


@end

@implementation WXFGuideView

- (void)reloadImages:(NSArray*)images
{
    for(UIView* view in self.singlePageArray){
        [view removeFromSuperview];
    }
    [self.singlePageArray removeAllObjects];
    
    for(NSInteger i = 0; i< images.count; i++){
        NSString* imageName = [images objectAtIndex:i];
        WXFGuidePageView* page = [[WXFGuidePageView alloc] initWithFrame:self.bounds];
        [self.scrollView addSubview:page];
        
        [self.singlePageArray addObject:page];
        [page setImagePageWithImage:[UIImage imageNamed:imageName]];
        page.tag = i;
        __weak typeof(self) weakSelf = self;
                page.guidePageViewDidSelectBlock = ^(NSInteger index){
        
                    if(weakSelf.didSelectBlock){
                        weakSelf.didSelectBlock(index);
                    }
                };
    }
    
    [self relayoutAllPage];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.scrollView];
        self.singlePageArray = [NSMutableArray array];
        self.scrollView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}
- (void)relayoutAllPage
{
    NSInteger width = self.singlePageArray.count * self.width;
    self.scrollView.contentSize = CGSizeMake(width, self.height);
    
    for(NSInteger i = 0; i< self.singlePageArray.count; i++){
        UIView* view = [self.singlePageArray objectAtIndex:i];
        view.frame = CGRectMake(i * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x/scrollView.width+0.5;
    
}


@end
