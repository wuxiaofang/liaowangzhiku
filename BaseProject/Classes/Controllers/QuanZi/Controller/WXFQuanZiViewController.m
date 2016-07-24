//
//  WXFQuanZiViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFQuanZiViewController.h"
#import "WXFSegmentView.h"
#import "MJRefresh.h"
#import "WXFQuznZITableViewCell.h"

@interface WXFQuanZiViewController ()

@property (nonatomic, strong) WXFSegmentView* segmentView;


@property (nonatomic, strong) UITableView* tableView1;

@property (nonatomic, strong) NSMutableArray* listArray1;

@property (nonatomic, assign) NSInteger currentPage1;

@property (nonatomic, assign) NSInteger totalPage1;




@property (nonatomic, strong) UITableView* tableView2;

@property (nonatomic, strong) NSMutableArray* listArray2;

@property (nonatomic, assign) NSInteger currentPage2;

@property (nonatomic, assign) NSInteger totalPage2;

@end

@implementation WXFQuanZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望圈子"];
    [self showBackButton];
    
    [self showBackButton];
    self.listArray1 = [NSMutableArray array];
    self.listArray2 = [NSMutableArray array];
    
    self.segmentView = [[WXFSegmentView alloc] init];
    [self.segmentView.button1 setTitle:@"讨论圈子" forState:UIControlStateNormal];
    [self.segmentView.button2 setTitle:@"研究课题" forState:UIControlStateNormal];
    self.segmentView.frame = CGRectMake(0, 0, self.view.width, 44);
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
    [paramater setValue:@"1" forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/user/circle/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
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
            
            if(self.totalPage1 > self.currentPage1){
                self.tableView1.mj_footer.hidden = NO;
            }else{
                self.tableView1.mj_footer.hidden = YES;
            }
            [self.tableView1 reloadData];
            
        }else{
            [self showToastWithText:desc];
        }
        
        
        
    }];
    
}

- (void)reloadMoreData1
{
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:[NSString stringWithFormat:@"%ld",(self.currentPage1 + 1)] forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/user/circle/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
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
            
            if(self.totalPage1 > self.currentPage1){
                self.tableView1.mj_footer.hidden = NO;
            }else{
                self.tableView1.mj_footer.hidden = YES;
            }
            [self.tableView1 reloadData];
            
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
    [paramater setValue:@"1" forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/user/topic/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
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

- (void)reloadMoreData2
{
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:[NSString stringWithFormat:@"%ld",(self.currentPage2 + 1)] forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/user/topic/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
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
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 5;
    NSInteger row = 0;
    
    if(tableView == self.tableView1){
        
        row = self.listArray1.count / 2;
        if(self.listArray1.count > 0 && self.listArray1.count % 2 != 0){
            row += 1;
        }
    }else if(tableView == self.tableView2){
        
        row = self.listArray2.count / 2;
        if(self.listArray2.count > 0 && self.listArray2.count % 2 != 0){
            row += 1;
        }
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"WXFQuznZITableViewCell";
    WXFQuznZITableViewCell* cell = (WXFQuznZITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFQuznZITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    __weak typeof(self)weakSelf = self;
    cell.gridView1.quanZiDidBlock = ^(NSDictionary* dic){
        NSString* imageUrl = [dic stringSafeForKey:@"url"];
        WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.webviewUrl = imageUrl;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    cell.gridView2.quanZiDidBlock = ^(NSDictionary* dic){
        NSString* imageUrl = [dic stringSafeForKey:@"url"];
        WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.webviewUrl = imageUrl;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    if(tableView == self.tableView1){
        NSDictionary* dic1 = [self.listArray1 objectAtIndexSafe:indexPath.row];
        NSDictionary* dic2 = [self.listArray1 objectAtIndexSafe:indexPath.row + 1];
        
        if(dic1){
            cell.gridView1.hidden = NO;
            [cell.gridView1 reloadData:dic1];
        }else{
            cell.gridView1.hidden = YES;
        }
        
        if(dic2){
            cell.gridView2.hidden = NO;
            [cell.gridView2 reloadData:dic2];
        }else{
            cell.gridView2.hidden = YES;
        }
        
//        if(indexPath.row < self.listArray1.count){
        
//            NSDictionary* dic = [self.listArray1 objectAtIndex:indexPath.row];
//            cell.titlelabel.text = [dic stringSafeForKey:@"name"];
//            cell.subTitle.text = [dic stringSafeForKey:@"introduction"];
//            NSString* imageUrl = [dic stringSafeForKey:@"titleImg"];
//            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if([imageURL.absoluteString isEqualToString:imageUrl]){
//                    cell.iconImageView.image = image;
//                }else{
//                    cell.iconImageView.image = nil;
//                }
//            }];
        
            
//        }
    }else if(tableView == self.tableView2){
        NSDictionary* dic1 = [self.listArray2 objectAtIndexSafe:indexPath.row];
        NSDictionary* dic2 = [self.listArray2 objectAtIndexSafe:indexPath.row + 1];
        
        if(dic1){
            cell.gridView1.hidden = NO;
            [cell.gridView1 reloadData:dic1];
        }else{
            cell.gridView1.hidden = YES;
        }
        
        if(dic2){
            cell.gridView2.hidden = NO;
            [cell.gridView2 reloadData:dic2];
        }else{
            cell.gridView2.hidden = YES;
        }
        
//        if(indexPath.row < self.listArray2.count){
//        
//            NSDictionary* dic = [self.listArray2 objectAtIndex:indexPath.row];
//            cell.titlelabel.text = [dic stringSafeForKey:@"name"];
//            cell.subTitle.text = [dic stringSafeForKey:@"introduction"];
//            NSString* imageUrl = [dic stringSafeForKey:@"titleImg"];
//            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if([imageURL.absoluteString isEqualToString:imageUrl]){
//                    cell.iconImageView.image = image;
//                }else{
//                    cell.iconImageView.image = nil;
//                }
//            }];
            
            
//        }
    }
    
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if(tableView == self.tableView1){
//        if(indexPath.row < self.listArray1.count){
//            
//            NSDictionary* dic = [self.listArray1 objectAtIndex:indexPath.row];
//            
//            NSString* imageUrl = [dic stringSafeForKey:@"url"];
//            WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.webviewUrl = imageUrl;
//            [self.navigationController pushViewController:vc animated:YES];
//            
//        }
//    }else if(tableView == self.tableView2){
//        if(indexPath.row < self.listArray2.count){
//            
//            NSDictionary* dic = [self.listArray2 objectAtIndex:indexPath.row];
//            
//            NSString* imageUrl = [dic stringSafeForKey:@"url"];
//            WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.webviewUrl = imageUrl;
//            [self.navigationController pushViewController:vc animated:YES];
//            
//        }
//    }
    
    
    
}



@end
