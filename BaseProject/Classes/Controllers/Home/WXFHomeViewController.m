//
//  YCHomeViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/6/6.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFHomeViewController.h"
#import "WXFLoginViewController.h"
#import "WXFWeChatShareHelper.h"
#import "WXFWeiboShareHelper.h"
#import "WXFQQShareHelper.h"
#import "WXFWelcomeView.h"
#import "WXFHomeHeaderView.h"
#import "MJRefresh.h"
#import "WXFHomeTableViewCell.h"

@interface WXFHomeViewController ()

@property (nonatomic, strong) WXFHomeHeaderView* tableHeaderView;

@property (nonatomic, strong) NSMutableArray* listArray;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger totalPage;

@end

@implementation WXFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"瞭望智库"];
    self.listArray = [NSMutableArray array];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    WXFWelcomeView* welcomeView = [[WXFWelcomeView alloc] initWithFrame:window.bounds];
    
    welcomeView.dismissWelcomeViewBlock = ^(NSString* webviewUrl){
        [self showHud];
        [self refreshListData];
        self.listTableView.mj_footer.hidden = YES;
        
        
    };
    
    [window addSubview:welcomeView];
    
    [self initListTableView];
    
    self.tableHeaderView = [[WXFHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 304)];
    self.listTableView.tableHeaderView = self.tableHeaderView;
    
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
//        [self getRenYuanList:YES];
        [self refreshListData];
    }];
    
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreData)];

    
//    [self refreshListData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.listTableView.frame = self.view.bounds;
}


//{
//    desc = "\U6570\U636e\U8bf7\U6c42\U6210\U529f\Uff01";
//    pagination =     {
//        firstResult = 0;
//        list =         (
//        );
//        nextPage = 1;
//        pageNo = 1;
//        pageSize = 20;
//        prePage = 1;
//        totalCount = 0;
//        totalPage = 1;
//    };
//    success = 1;
//}
- (void)refreshListData
{
 
    NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
    [paramater setValue:@"172" forKey:@"channelId"];
    [paramater setValue:@"1" forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/content/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
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
    [paramater setValue:@"172" forKey:@"channelId"];
    [paramater setValue:[NSString stringWithFormat:@"%ld",(self.currentPage + 1)] forKey:@"pageNo"];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/content/list.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
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
    NSString* cellIdentify = @"WXFHomeTableViewCell";
    WXFHomeTableViewCell* cell = (WXFHomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if(indexPath.row < self.listArray.count){
        
        NSDictionary* dic = [self.listArray objectAtIndex:indexPath.row];
        cell.titlelabel.text = [dic stringSafeForKey:@"title"];
        cell.subTitle.text = [dic stringSafeForKey:@"title"];
        NSString* imageUrl = [dic stringSafeForKey:@"titleImg"];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if([imageURL.absoluteString isEqualToString:imageUrl]){
                cell.iconImageView.image = image;
            }else{
                cell.iconImageView.image = nil;
            }
        }];
        
        
    }
    
//    cell.titlelabel.text = @"阿贾克斯的那份；阿里水电费啊；塑料袋开发哪里上的看法";
//    cell.subTitle.text = @";sldfn;lsdfg;kls,df挨批卡马克是发到奥斯卡的逆反；阿里可能的发；拉克是你的；案例可是你的发；案例可是你；那拉克是南方了少年方阿斯利康能否啊";
//    NSString* imageUrl = @"http://y2.ifengimg.com/958dcda298b573f7/2012/1201/rdn_50b961be428bd.jpg";
//    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if([imageURL.absoluteString isEqualToString:imageUrl]){
//            cell.iconImageView.image = image;
//        }else{
//            cell.iconImageView.image = nil;
//        }
//    }];

    
    
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
