//
//  WXFSegmentPopView.m
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFSegmentPopView.h"

@interface WXFSegmentPopView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) DidSegmentPopBlock didSegmentPopBlock;

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSArray* dataArray;

//@property (nonatomic, strong) WXFSegmentPopHeaderView* headerView;

@end

@implementation WXFSegmentPopView

- (UITableView*)tableView
{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
    }
    return _tableView;

}

//- (WXFSegmentPopHeaderView*)headerView
//{
//    if(_headerView == nil){
//        _headerView = [[WXFSegmentPopHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
//    }
//    return _headerView;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"WXFSegmentPopViewCell";
    WXFSegmentPopViewCell* cell = (WXFSegmentPopViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFSegmentPopViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
    }
    cell.myLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.didSegmentPopBlock){
        self.didSegmentPopBlock(indexPath.row);
    }
    [self removeFromSuperview];
}


- (void)showIn:(UIView*)superView
         frame:(CGRect)frame
     dataArray:(NSArray*)dataArray
         title:(NSString*)title
didSelectBlock:(DidSegmentPopBlock)didSelectBlock
{
    self.frame = superView.bounds;
    [superView addSubview:self];
    self.dataArray = dataArray;
    self.didSegmentPopBlock  = didSelectBlock;
//    self.headerView.myLabel.text = title;
//    self.tableView.tableHeaderView = self.headerView;
    
    CGFloat heigth = self.dataArray.count * 40 ;
    if(heigth > frame.size.height - 40){
        heigth = frame.size.height - 40;
    }
    self.tableView.frame = CGRectMake(0, 35, superView.width, heigth);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(!CGRectContainsPoint(self.tableView.frame, point)){
        [self removeFromSuperview];
    }
}

@end

@implementation WXFSegmentPopViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.myLabel = [[UILabel alloc] init];
        self.myLabel.textColor = UIColorFromRGB(0x000000);
        self.myLabel.font = [UIFont systemFontOfSize:12];
        self.myLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.myLabel];
        
        self.seperateLine = [[UIView alloc] init];
        self.seperateLine.backgroundColor = UIColorFromRGB(0xe4e4e4);
        [self addSubview:self.seperateLine];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myLabel.frame = CGRectMake(10, 0, self.width, self.height);
    self.seperateLine.frame = CGRectMake(10, self.height - 0.5, self.width, 0.5);
    
}
@end

@implementation WXFSegmentPopHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.myLabel = [[UILabel alloc] init];
        self.myLabel.textColor = UIColorFromRGB(0x1dbbe6);
        self.myLabel.font = [UIFont systemFontOfSize:12];
        self.myLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.myLabel];
        
        self.seperateLine = [[UIView alloc] init];
        self.seperateLine.backgroundColor = UIColorFromRGB(0x1dbbe6);
        [self addSubview:self.seperateLine];

    }
    return self;
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myLabel.frame = CGRectMake(10, 0, self.width, self.height);
    self.seperateLine.frame = CGRectMake(10, self.height - 0.5, self.width, 0.5);
    
}
@end
