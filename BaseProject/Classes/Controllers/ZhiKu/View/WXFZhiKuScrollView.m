//
//  WXFZhiKuScrollView.m
//  BaseProject
//
//  Created by yongche_w on 16/10/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFZhiKuScrollView.h"

@interface WXFZhiKuScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) NSMutableArray* singlePageArray;

@property (nonatomic, strong) UIPageControl* pageControl;

@end

@implementation WXFZhiKuScrollView

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
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        self.pageControl.hidesForSinglePage = YES;
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
    }
    return self;
}

- (void)reloadData:(NSArray*)dataDic
{
    for(UIView* view in self.singlePageArray){
        [view removeFromSuperview];
    }
    [self.singlePageArray removeAllObjects];
    
    for(NSInteger i = 0; i< dataDic.count; i++){
        NSDictionary* dic = [dataDic objectAtIndex:i];
        WXFZhiKuSinglePage* page = [[WXFZhiKuSinglePage alloc] initWithFrame:self.bounds];
        [self.scrollView addSubview:page];
        [self.singlePageArray addObject:page];
        [page reloadPageData:dic index:i];
        
        __weak typeof(self) weakSelf = self;
        page.singlePageDidSelectBlock = ^(WXFZhiKuSinglePage* page){
        
            if(weakSelf.didSelectBlock){
                weakSelf.didSelectBlock(page.index,page.pageDataDic);
            }
        };
    }
    self.pageControl.numberOfPages = self.singlePageArray.count;
    [self relayoutAllPage];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.scrollView.bottom - 50, self.scrollView.width, 10);
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
    self.pageControl.currentPage = (NSInteger)page;
}

@end




@interface WXFZhiKuSinglePage()

@property (nonatomic, strong, readwrite) NSDictionary* pageDataDic;

@property (nonatomic, assign, readwrite) NSInteger index;

@property (nonatomic, strong) UIImageView* picImageView;

@property (nonatomic, strong) UIView* titleLabelBg;

@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation WXFZhiKuSinglePage



- (void)reloadPageData:(NSDictionary*)pageData index:(NSInteger)index
{
    self.pageDataDic = pageData;
    self.index = index;
    NSString* imageUrl = [pageData stringSafeForKey:@"titleImg"];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image && [imageURL.absoluteString isEqualToString:imageUrl]){
            self.picImageView.image = image;
            self.picImageView.contentMode = UIViewContentModeScaleToFill;

        }else{
            self.picImageView.image = [UIImage imageNamed:@"default_img_big"];
            self.picImageView.contentMode = UIViewContentModeCenter;
        }
    }];
    
    NSString* titleText = [pageData stringSafeForKey:@"title"];
    self.titleLabel.text = titleText;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [self addGestureRecognizer:tap];
        self.backgroundColor = UIColorFromRGB(0xcccccc);
    }
    return self;
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer*)tap
{
    if(self.singlePageDidSelectBlock){
        self.singlePageDidSelectBlock(self);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.picImageView.frame = CGRectMake(0, 0, self.width, self.height - 18);;
    
    self.titleLabelBg.frame = CGRectMake(0, self.height - 36, self.width, 36);
    self.titleLabel.frame = CGRectMake(8, self.height - 36, self.width - 16, 36);
    [self bringSubviewToFront:self.titleLabel];
}


- (UIImageView*)picImageView
{
    if(_picImageView == nil){
        _picImageView = [[UIImageView alloc] init];
        [self addSubview:_picImageView];
        _picImageView.image = [UIImage imageNamed:@"default_img_big"];
        _picImageView.contentMode = UIViewContentModeCenter;
    }
    return _picImageView;
}

- (UIView*)titleLabelBg
{
    if(_titleLabelBg == nil){
        _titleLabelBg = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleLabelBg];
        _titleLabelBg.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabelBg;
}

- (UILabel*)titleLabel
{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}


@end
