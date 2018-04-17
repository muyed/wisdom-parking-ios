//
//  PIBaseTableViewController.h
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"


@interface PIBaseTableViewController : PIBaseViewController<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 类型
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

- (void)setupTableViewWithFrame:(CGRect) tableViewFrame;

@end
