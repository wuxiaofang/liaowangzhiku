//
//  WXFBaseTableViewController.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"

/*
 * tableview 列表的BASE类实现了tableview的初始化，代理等方法
 *
 */

@interface WXFBaseTableViewController : WXFBaseViewController<UITableViewDelegate, UITableViewDataSource>
/*
 * tableView
 **/
@property (nonatomic, strong) UITableView* listTableView;

/*
 * 初始化tableview
 */
- (void)initListTableView;

@end
