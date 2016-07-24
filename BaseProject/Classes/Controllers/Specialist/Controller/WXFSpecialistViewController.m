//
//  WXFSpecialistViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFSpecialistViewController.h"
#import "WXFZhiKuSegment.h"
#import "WXFSegmentPopView.h"
#import "MJRefresh.h"
#import "WXFSpecialistCellTableViewCell.h"

@interface WXFSpecialistViewController ()

@property (nonatomic, strong) WXFZhiKuSegment* zhutiSegment;

@property (nonatomic, strong) NSMutableArray* listArray;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger totalPage;

//0为智能  1为领域
@property (nonatomic, copy) NSString* orderById;

@end

@implementation WXFSpecialistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望专家库"];
    [self showBackButton];
    
    self.zhutiSegment = [[WXFZhiKuSegment alloc] init];
    self.zhutiSegment.item1.titleLabel.text = @"按领域排序";
    self.zhutiSegment.item2.titleLabel.text = @"按智能排序";
    [self.view addSubview:self.zhutiSegment];
    [self.zhutiSegment setSelectIndex:0];
    
    __weak typeof(self)weakSelf = self;
    self.zhutiSegment.zhuTiSegmentSelectBlock = ^(NSInteger index){
        
        if(index == 0){
            NSArray* array = @[@"政治",@"经济",@"新能源",@"文学",@"外交",@"电子",@"互联网",@"其他"];
            WXFSegmentPopView* popview = [[WXFSegmentPopView alloc] init];
            [popview showIn:weakSelf.view frame:CGRectMake(0, 35, weakSelf.view.width, self.view.height - 35) dataArray:array title:@"按领域排序" didSelectBlock:^(NSInteger index) {
                self.orderById = @"1";
                [self.listTableView.mj_header beginRefreshing];
            }];
        }else{
            NSArray* array = @[@"人气最高",@"学历最高"];
            WXFSegmentPopView* popview = [[WXFSegmentPopView alloc] init];
            [popview showIn:weakSelf.view frame:CGRectMake(0, 35, weakSelf.view.width, self.view.height - 35) dataArray:array title:@"智能排序" didSelectBlock:^(NSInteger index) {
                self.orderById = @"0";
                [self.listTableView.mj_header beginRefreshing];
            }];
        }
        
    };
    
    
    [self initListTableView];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        //        [self getRenYuanList:YES];
        [self refreshListData];
    }];
    
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreData)];
    self.orderById = @"1";
    [self refreshListData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.zhutiSegment.frame = CGRectMake(0, 0, self.view.width, 35);
    self.listTableView.frame = CGRectMake(0, 35, self.view.width, self.view.height - 35);
    
}

- (void)refreshListData
{
    
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:self.orderById forKey:@"orderBy"];
    [paramater setValue:@"2" forKey:@"pType"];
    [paramater setValue:@"1" forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"app/comm/user/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        [self hiddenHud];
        [self.listTableView.mj_header endRefreshing];
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        NSString* desc = [parser.responseDictionary stringSafeForKey:@"desc"];
        if(code == 1){
            
            NSDictionary* pagination = [parser.responseDictionary dictionarySafeForKey:@"pagination"];
            self.totalPage = [pagination integerSafeForKey:@"totalPage"];
            self.currentPage = [pagination integerSafeForKey:@"pageNo"];
            
            NSArray* list = [pagination arraySafeForKey:@"list"];
            [self.listArray removeAllObjects];
            if(list.count > 0){
                [self.listArray addObjectsFromArray:list];
            }else{
                [self showToastWithText:@"暂无数据请稍后重试"];
            }
            
            if(self.totalPage > self.currentPage){
                self.listTableView.mj_footer.hidden = NO;
            }else{
                self.listTableView.mj_footer.hidden = YES;
            }
            [self.listTableView reloadData];
            
        }else{
            [self showToastWithText:desc];
        }
        
        
        
    }];
    
}

- (void)reloadMoreData
{
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:self.orderById forKey:@"orderBy"];
    [paramater setValue:@"2" forKey:@"pType"];
    [paramater setValue:[NSString stringWithFormat:@"%ld",(self.currentPage + 1)] forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/user/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
        [self.listTableView.mj_header endRefreshing];
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        NSString* desc = [parser.responseDictionary stringSafeForKey:@"desc"];
        if(code == 1){
            
            NSDictionary* pagination = [parser.responseDictionary dictionarySafeForKey:@"pagination"];
            self.totalPage = [pagination integerSafeForKey:@"totalPage"];
            self.currentPage = [pagination integerSafeForKey:@"pageNo"];
            
            NSArray* list = [pagination arraySafeForKey:@"list"];
            if(list.count > 0){
                [self.listArray addObjectsFromArray:list];
            }
            
            if(self.totalPage > self.currentPage){
                self.listTableView.mj_footer.hidden = NO;
            }else{
                self.listTableView.mj_footer.hidden = YES;
            }
            [self.listTableView reloadData];
            
        }else{
            [self showToastWithText:desc];
        }
        
        
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 5;
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"WXFSpecialistCellTableViewCell";
    WXFSpecialistCellTableViewCell* cell = (WXFSpecialistCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFSpecialistCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if(indexPath.row < self.listArray.count){
        
        NSDictionary* dic = [self.listArray objectAtIndex:indexPath.row];
        cell.titleLabel.text = [dic stringSafeForKey:@"username"];
        cell.subLabel.text = [dic stringSafeForKey:@"position"];
        cell.subSubLabel.text = [dic stringSafeForKey:@"research_field"];
        NSString* imageUrl = [dic stringSafeForKey:@"userImg"];
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if([imageURL.absoluteString isEqualToString:imageUrl]){
                cell.userImageView.image = image;
            }else{
                cell.userImageView.image = nil;
            }
        }];
        
        [cell.titleLabel sizeToFit];
        [cell.subLabel sizeToFit];
        [cell.subSubLabel sizeToFit];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if(indexPath.row < self.listArray.count){
        
        NSDictionary* dic = [self.listArray objectAtIndex:indexPath.row];
        
        NSString* imageUrl = [dic stringSafeForKey:@"url"];
        WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.webviewUrl = imageUrl;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}




@end
