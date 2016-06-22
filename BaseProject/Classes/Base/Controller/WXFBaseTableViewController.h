//
//  WXFBaseTableViewController.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"

@interface WXFBaseTableViewController : WXFBaseViewController<UITableViewDelegate, UITableViewDataSource>



@property (nonatomic, strong) UITableView* listTableView;

- (void)initListTableView;

@end
