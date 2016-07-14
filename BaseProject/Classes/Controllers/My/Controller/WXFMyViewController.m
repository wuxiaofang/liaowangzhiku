//
//  WXFMyViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/7/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFMyViewController.h"
#import "WXFMyInfoTableViewCell.h"
#import "WXFMyFootView.h"
#import "WXFMyCommonTableViewCell.h"
@interface WXFMyViewController ()

@end

@implementation WXFMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomLabelForNavTitle:@"个人中心"];
    
    self.listTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = UIColorFromRGB(0xefeff4);
    self.listTableView.backgroundView = nil;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    if(section == 0){
        row = 1;
    }else if(section == 1){
        row = 1;
    }else if(section == 2){
        row = 4;
    }else if(section == 3){
        row = 1;
    }else if(section == 4){
        row = 2;
    }
    return row;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([WXFUser instance].isLogin){
        return 6;
    }
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth = 0;
    if(indexPath.section == 0){
        heigth = 84;
    }else if(indexPath.section == 1){
        heigth = 72;
    }else if(indexPath.section == 2){
        heigth = 40;
    }else if(indexPath.section == 3){
        heigth = 40;
    }else if(indexPath.section == 4){
        heigth = 40;
    }else if(indexPath.section == 5){
        heigth = 60;
    }
    
    return heigth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if([WXFUser instance].isLogin){
        if(section == 5){
        
        }else{
            WXFMyFootView* footView = [[WXFMyFootView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 8)];
            return footView;
        }
    }else {
        if(section == 4){
        
        }else{
            WXFMyFootView* footView = [[WXFMyFootView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 8)];
            return footView;
        }
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"UITableViewCell";
    
    if(indexPath.section == 0){
        cellIdentify = @"WXFMyInfoTableViewCell";
    }else if(indexPath.section == 1){

    }else if(indexPath.section == 2){
        cellIdentify = @"WXFMyCommonTableViewCell";
    }else if(indexPath.section == 3){
        cellIdentify = @"WXFMyCommonTableViewCell";
    }else if(indexPath.section == 4){
        cellIdentify = @"WXFMyCommonTableViewCell";
    }else if(indexPath.section == 5){
        cellIdentify = @"WXFMyCommonTableViewCell";
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[NSClassFromString(cellIdentify) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }

    if(indexPath.section == 0){
        WXFMyInfoTableViewCell* myInfoCell = (WXFMyInfoTableViewCell*)cell;
        
        
    }else if(indexPath.section == 1){
        
    }else if(indexPath.section == 2){
        WXFMyCommonTableViewCell* commonCell = (WXFMyCommonTableViewCell*)cell;
        if(indexPath.row == 0){
            commonCell.titleLabel.text = @"我的圈子";
            commonCell.iconImageView.image = [UIImage imageNamed:@"me01"];
        }else if(indexPath.row == 1){
            commonCell.titleLabel.text = @"我的课题";
            commonCell.iconImageView.image = [UIImage imageNamed:@"me02"];
        }else if(indexPath.row == 2){
            commonCell.titleLabel.text = @"我的收藏";
            commonCell.iconImageView.image = [UIImage imageNamed:@"me03"];
        }else if(indexPath.row == 3){
            commonCell.titleLabel.text = @"推送消息";
            commonCell.iconImageView.image = [UIImage imageNamed:@"me04"];
        }
        
    }else if(indexPath.section == 3){
        WXFMyCommonTableViewCell* commonCell = (WXFMyCommonTableViewCell*)cell;
        if(indexPath.row == 0){
            commonCell.titleLabel.text = @"推荐注册";
            commonCell.iconImageView.image = [UIImage imageNamed:@"me05"];
        }
    }else if(indexPath.section == 4){
        WXFMyCommonTableViewCell* commonCell = (WXFMyCommonTableViewCell*)cell;
        if(indexPath.row == 0){
            commonCell.titleLabel.text = @"修改密码";
            commonCell.iconImageView.image = [UIImage imageNamed:@"me06"];
        }else if(indexPath.row == 1){
            commonCell.titleLabel.text = @"意见反馈";
            commonCell.iconImageView.image = [UIImage imageNamed:@"me07"];
        }
    }else if(indexPath.section == 5){
        
    }
    
    return cell;
}
@end
