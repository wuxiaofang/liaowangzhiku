//
//  WXFZhiKuViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFZhiKuViewController.h"
#import "WXFSegmentView.h"
#import "MJRefresh.h"
#import "WXFHomeTableViewCell.h"
#import "WXFZhiKuScrollView.h"


@interface WXFZhiKuViewController ()

@property (nonatomic, strong) WXFSegmentView* segmentView;


@property (nonatomic, strong) UITableView* tableView1;

@property (nonatomic, strong) NSMutableArray* listArray1;

@property (nonatomic, assign) NSInteger currentPage1;

@property (nonatomic, assign) NSInteger totalPage1;

@property (nonatomic, strong) WXFZhiKuScrollView* zhiKuScrollView1;




@property (nonatomic, strong) UITableView* tableView2;

@property (nonatomic, strong) NSMutableArray* listArray2;

@property (nonatomic, assign) NSInteger currentPage2;

@property (nonatomic, assign) NSInteger totalPage2;

@end

@implementation WXFZhiKuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望智库"];
    [self showBackButton];
    self.listArray1 = [NSMutableArray array];
    self.listArray2 = [NSMutableArray array];
    
    self.segmentView = [[WXFSegmentView alloc] init];
    [self.segmentView.button1 setTitle:@"智库观点" forState:UIControlStateNormal];
    [self.segmentView.button2 setTitle:@"智库产品" forState:UIControlStateNormal];
    self.segmentView.frame = CGRectMake(0, 0, self.view.width, 40);
    [self.view addSubview:self.segmentView];
    __weak typeof(self)weakSelf = self;
    self.segmentView.segmentSelectBlock = ^(NSInteger index){
        [weakSelf hiddenHud];
        if(index == 0){
            weakSelf.tableView1.hidden = NO;
            weakSelf.tableView2.hidden = YES;
        }else if(index == 1){
            weakSelf.tableView1.hidden = YES;
            weakSelf.tableView2.hidden = NO;
            if(weakSelf.listArray2.count == 0){
                [weakSelf refreshListData2];
            }
        }
    };
    
    self.tableView1 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.backgroundColor = UIColorFromRGB(0xefeff4);
    self.tableView1.backgroundView = nil;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView1];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.backgroundColor = UIColorFromRGB(0xefeff4);
    self.tableView2.backgroundView = nil;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView2];
    
    
    self.tableView1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        //        [self getRenYuanList:YES];
        [self showHud];
        [self refreshListData1];
    }];
    
    self.tableView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreData1)];
    
    self.tableView2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        //        [self getRenYuanList:YES];
        [self refreshListData2];
    }];
    
    self.tableView2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreData2)];
    
    [self.segmentView setSelectIndex:0];
    weakSelf.tableView1.hidden = NO;
    weakSelf.tableView2.hidden = YES;
    [self showHud];
    [self refreshListData1];
}

- (void)refreshListData1
{
    NSLog(@"refreshListData1   ");
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:@"175" forKey:@"parentId"];
    [paramater setValue:@"1" forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/mechanism/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        [self hiddenHud];
        [self.tableView1.mj_header endRefreshing];
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        NSString* desc = [parser.responseDictionary stringSafeForKey:@"desc"];
        if(code == 1){
            
            NSDictionary* pagination = [parser.responseDictionary dictionarySafeForKey:@"pagination"];
            self.totalPage1 = [pagination integerSafeForKey:@"totalPage"];
            self.currentPage1 = [pagination integerSafeForKey:@"pageNo"];
            
            NSArray* list = [pagination arraySafeForKey:@"list"];
            [self.listArray1 removeAllObjects];
            if(list.count > 0){
                [self.listArray1 addObjectsFromArray:list];
            }else{
                [self showToastWithText:@"暂无数据请稍后重试"];
            }
            [self.tableView1 reloadData];
            if(self.totalPage1 > self.currentPage1){
                self.tableView1.mj_footer.hidden = NO;
                [self.tableView1.mj_footer endRefreshing];
            }else{
                self.tableView1.mj_footer.hidden = NO;
                [self.tableView1.mj_footer endRefreshingWithNoMoreData];
            }
            
            
        }else{
            [self showToastWithText:desc];
        }
        
        
        
    }];
    
    [self reloadScrollViewData1];
    
    
}

- (void)reloadScrollViewData1
{

    
    [[WXFHttpClient shareInstance] postData:@"app/comm/mechanism/scroll/list.jspx" parameters:nil callBack:^(WXFParser *parser) {
        
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
   
        if(code == 1){
            NSArray* list = [parser.responseDictionary arraySafeForKey:@"list"];
            if(list.count > 0){
                [self.zhiKuScrollView1 reloadData:list];
                self.tableView1.tableHeaderView = self.zhiKuScrollView1;
            }else{
                self.tableView1.tableHeaderView = nil;
            }

            
        }
        
        
        
    }];
    
    
}

- (void)reloadMoreData1
{
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:@"175" forKey:@"parentId"];
    [paramater setValue:[NSString stringWithFormat:@"%ld",(self.currentPage1 + 1)] forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/mechanism/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
        [self.tableView1.mj_header endRefreshing];
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        NSString* desc = [parser.responseDictionary stringSafeForKey:@"desc"];
        if(code == 1){
            
            NSDictionary* pagination = [parser.responseDictionary dictionarySafeForKey:@"pagination"];
            self.totalPage1 = [pagination integerSafeForKey:@"totalPage"];
            self.currentPage1 = [pagination integerSafeForKey:@"pageNo"];
            
            NSArray* list = [pagination arraySafeForKey:@"list"];
            if(list.count > 0){
                [self.listArray1 addObjectsFromArray:list];
            }
            [self.tableView1 reloadData];
            if(self.totalPage1 > self.currentPage1){
                self.tableView1.mj_footer.hidden = NO;
                [self.tableView1.mj_footer endRefreshing];
            }else{
                self.tableView1.mj_footer.hidden = NO;
                [self.tableView1.mj_footer endRefreshingWithNoMoreData];
            }
            
            
        }else{
            [self showToastWithText:desc];
        }
        
        
        
    }];
    
    
}

- (void)refreshListData2
{
    NSLog(@"refreshListData2   ");
    NSLog(@"refreshListData1   ");
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:@"174" forKey:@"parentId"];
    [paramater setValue:@"1" forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/mechanism/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        [self hiddenHud];
        [self.tableView2.mj_header endRefreshing];
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        NSString* desc = [parser.responseDictionary stringSafeForKey:@"desc"];
        if(code == 1){
            
            NSDictionary* pagination = [parser.responseDictionary dictionarySafeForKey:@"pagination"];
            self.totalPage2 = [pagination integerSafeForKey:@"totalPage"];
            self.currentPage2 = [pagination integerSafeForKey:@"pageNo"];
            
            NSArray* list = [pagination arraySafeForKey:@"list"];
            [self.listArray2 removeAllObjects];
            if(list.count > 0){
                [self.listArray2 addObjectsFromArray:list];
            }else{
                [self showToastWithText:@"暂无数据请稍后重试"];
            }
            
            [self.tableView2 reloadData];
            if(self.totalPage2 > self.currentPage2){
                self.tableView2.mj_footer.hidden = NO;
                [self.tableView2.mj_footer endRefreshing];
            }else{
                self.tableView2.mj_footer.hidden = NO;
                [self.tableView2.mj_footer endRefreshingWithNoMoreData];
            }
            
            
        }else{
            [self showToastWithText:desc];
        }
        
        
        
    }];
}

- (void)reloadMoreData2
{
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:@"174" forKey:@"parentId"];
    [paramater setValue:[NSString stringWithFormat:@"%ld",(self.currentPage2 + 1)] forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/mechanism/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
        [self.tableView2.mj_header endRefreshing];
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        NSString* desc = [parser.responseDictionary stringSafeForKey:@"desc"];
        if(code == 1){
            
            NSDictionary* pagination = [parser.responseDictionary dictionarySafeForKey:@"pagination"];
            self.totalPage2 = [pagination integerSafeForKey:@"totalPage"];
            self.currentPage2 = [pagination integerSafeForKey:@"pageNo"];
            
            NSArray* list = [pagination arraySafeForKey:@"list"];
            if(list.count > 0){
                [self.listArray2 addObjectsFromArray:list];
            }
            
            if(self.totalPage2 > self.currentPage2){
                self.tableView2.mj_footer.hidden = NO;
            }else{
                self.tableView2.mj_footer.hidden = YES;
            }
            [self.tableView2 reloadData];
            
        }else{
            [self showToastWithText:desc];
        }
        
        
        
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView1.frame = CGRectMake(0, self.segmentView.height, self.view.width, self.view.height - self.segmentView.height);
    
    self.tableView2.frame = CGRectMake(0, self.segmentView.height, self.view.width, self.view.height - self.segmentView.height);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 5;
    NSInteger row = 0;
    
    if(tableView == self.tableView1){
        row = self.listArray1.count;
    }else if(tableView == self.tableView2){
        row = self.listArray2.count;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"WXFHomeTableViewCell";
    WXFHomeTableViewCell* cell = (WXFHomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if(tableView == self.tableView1){
        if(indexPath.row < self.listArray1.count){
            
            NSDictionary* dic = [self.listArray1 objectAtIndex:indexPath.row];
            cell.titlelabel.text = [dic stringSafeForKey:@"name"];
            cell.subTitle.text = [dic stringSafeForKey:@"introduction"];
            NSString* imageUrl = [dic stringSafeForKey:@"titleImg"];
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_img"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(image && [imageURL.absoluteString isEqualToString:imageUrl]){
                    cell.iconImageView.image = image;
                    cell.iconImageView.contentMode = UIViewContentModeScaleToFill;
                }else{
                    cell.iconImageView.image = [UIImage imageNamed:@"default_img"];
                    cell.iconImageView.contentMode = UIViewContentModeCenter;
                }
            }];
            
            
        }
    }else if(tableView == self.tableView2){
        if(indexPath.row < self.listArray2.count){
            
            NSDictionary* dic = [self.listArray2 objectAtIndex:indexPath.row];
            cell.titlelabel.text = [dic stringSafeForKey:@"name"];
            cell.subTitle.text = [dic stringSafeForKey:@"introduction"];
            NSString* imageUrl = [dic stringSafeForKey:@"titleImg"];
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_img"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(image && [imageURL.absoluteString isEqualToString:imageUrl]){
                    cell.iconImageView.image = image;
                    cell.iconImageView.contentMode = UIViewContentModeScaleToFill;
                }else{
                    cell.iconImageView.image = [UIImage imageNamed:@"default_img"];
                    cell.iconImageView.contentMode = UIViewContentModeCenter;
                }
            }];
            
            
        }
    }
    
    

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView == self.tableView1){
        if(indexPath.row < self.listArray1.count){
            
            NSDictionary* dic = [self.listArray1 objectAtIndex:indexPath.row];
            
            NSString* imageUrl = [dic stringSafeForKey:@"url"];
            WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.webviewUrl = imageUrl;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }else if(tableView == self.tableView2){
        if(indexPath.row < self.listArray2.count){
            
            NSDictionary* dic = [self.listArray2 objectAtIndex:indexPath.row];
            
            NSString* imageUrl = [dic stringSafeForKey:@"url"];
            WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.webviewUrl = imageUrl;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
    
    
}

- (WXFZhiKuScrollView*)zhiKuScrollView1
{
    if(_zhiKuScrollView1 == nil){
    
        NSInteger heigth = self.view.width / (CGFloat)1.875 + 36;
        _zhiKuScrollView1 = [[WXFZhiKuScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, heigth)];
        
        __weak typeof(self)weakSelf = self;
        
        _zhiKuScrollView1.didSelectBlock = ^(NSInteger index, NSDictionary* pageDataDic){
            NSString* imageUrl = [pageDataDic stringSafeForKey:@"url"];
            WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.webviewUrl = imageUrl;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _zhiKuScrollView1;

}



@end
