//
//  WXFReporterViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/7/22.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFReporterViewController.h"
#import "WXFZhiKuSegment.h"
#import "WXFSegmentPopView.h"
#import "MJRefresh.h"
#import "WXFReporterTableViewCell.h"

@interface WXFReporterViewController ()

@property (nonatomic, strong) WXFZhiKuSegment* zhutiSegment;

@property (nonatomic, strong) NSMutableArray* listArray;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger totalPage;

//0为智能  1为领域
@property (nonatomic, copy) NSString* orderById;

@property (nonatomic, copy) NSString* fieldById;

@property (nonatomic, strong) NSArray* fieldList;

@property (nonatomic, strong) NSArray* orderList;

@end

@implementation WXFReporterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getConditionList];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望记者库"];
    self.listArray = [NSMutableArray array];
    [self showBackButton];
    
    self.zhutiSegment = [[WXFZhiKuSegment alloc] init];
    self.zhutiSegment.item1.titleLabel.text = @"按领域排序";
    self.zhutiSegment.item2.titleLabel.text = @"按智能排序";
    [self.view addSubview:self.zhutiSegment];
    [self.zhutiSegment setSelectIndex:0];
    
    __weak typeof(self)weakSelf = self;
    self.zhutiSegment.zhuTiSegmentSelectBlock = ^(NSInteger index){
        
        if(index == 0){
            NSMutableArray* muArray = [NSMutableArray array];
            for(NSDictionary* dic in weakSelf.fieldList){
                NSString* value = [dic stringSafeForKey:@"value"];
                if(value.length > 0){
                    [muArray addObject:value];
                }
            }
            WXFSegmentPopView* popview = [[WXFSegmentPopView alloc] init];
            [popview showIn:weakSelf.view frame:CGRectMake(0, 35, weakSelf.view.width, self.view.height - 35) dataArray:muArray title:@"按领域排序" didSelectBlock:^(NSInteger index) {
                NSDictionary* filterDic = [self.fieldList objectAtIndexSafe:index];
                self.fieldById = [filterDic stringSafeForKey:@"key"];
                [self.listTableView.mj_header beginRefreshing];
            }];
        }else{
            NSMutableArray* muArray = [NSMutableArray array];
            for(NSDictionary* dic in weakSelf.orderList){
                NSString* value = [dic stringSafeForKey:@"value"];
                if(value.length > 0){
                    [muArray addObject:value];
                }
            }
            WXFSegmentPopView* popview = [[WXFSegmentPopView alloc] init];
            [popview showIn:weakSelf.view frame:CGRectMake(0, 35, weakSelf.view.width, self.view.height - 35) dataArray:muArray title:@"智能排序" didSelectBlock:^(NSInteger index) {
                NSDictionary* filterDic = [self.orderList objectAtIndexSafe:index];
                self.orderById = [filterDic stringSafeForKey:@"key"];
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
    [self refreshListData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [paramater setValue:@"1" forKey:@"pType"];
    [paramater setValue:@"1" forKey:@"pageNo"];
    
    if(self.orderById.length > 0){
        [paramater setValue:self.orderById forKey:@"orderBy"];
    }else{
        [paramater setValue:@"" forKey:@"orderBy"];
    }
    
    if(self.fieldById.length > 0){
        [paramater setValue:self.fieldById forKey:@"field"];
    }else{
        [paramater setValue:@"" forKey:@"field"];
    }
    
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
    
    [paramater setValue:@"1" forKey:@"pType"];
    [paramater setValue:[NSString stringWithFormat:@"%ld",(self.currentPage + 1)] forKey:@"pageNo"];
    
    if(self.orderById.length > 0){
        [paramater setValue:self.orderById forKey:@"orderBy"];
    }else{
        [paramater setValue:@"" forKey:@"orderBy"];
    }
    
    if(self.fieldById.length > 0){
        [paramater setValue:self.fieldById forKey:@"field"];
    }else{
        [paramater setValue:@"" forKey:@"field"];
    }
    
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
    NSString* cellIdentify = @"WXFReporterTableViewCell";
    WXFReporterTableViewCell* cell = (WXFReporterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFReporterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if(indexPath.row < self.listArray.count){
        
        NSDictionary* dic = [self.listArray objectAtIndex:indexPath.row];
        cell.titleLabel.text = [dic stringSafeForKey:@"username"];
        cell.subLabel.text = [dic stringSafeForKey:@"position"];
        cell.subSubLabel.text = [dic stringSafeForKey:@"research_field"];
        NSString* imageUrl = [dic stringSafeForKey:@"userImg"];
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_head"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(image && [imageURL.absoluteString isEqualToString:imageUrl]){
                cell.userImageView.image = image;
                cell.userImageView.contentMode = UIViewContentModeScaleToFill;
            }else{
                cell.userImageView.image = [UIImage imageNamed:@"default_head"];
                cell.userImageView.contentMode = UIViewContentModeCenter;
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

- (void)getConditionList
{
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:@"1" forKey:@"pType"];
    
    
    [[WXFHttpClient shareInstance] getData:@"/app/comm/user/condition.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"success"];
        if(code == 1){
            self.orderList  = [parser.responseDictionary arraySafeForKey:@"orderList"];
            self.fieldList = [parser.responseDictionary arraySafeForKey:@"fieldList"];
            
        }
        
        
        
    }];
    
}



@end
