//
//  PIOrderViewController.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIOrderViewController.h"
#import "PIOrderViewCell.h"
#import "PIOrderDetailController.h"
#import "PIOrderModel.h"

@interface PIOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 数据源
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation PIOrderViewController
{
    
    NSInteger _pageIndex;
    NSInteger _pageSize;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的停车单";
    _pageSize = 20;
    
    [self setupUI];
}

- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 130;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[PIOrderViewCell class] forCellReuseIdentifier:NSStringFromClass([PIOrderViewCell class])];
    
    [self setupRefresh];
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    
    [self.tableView.mj_footer endRefreshing];
    
    _pageIndex = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNo"] = @(_pageIndex);
    params[@"pageSize"] = @(_pageSize);
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];
    
    if (self.dataArr.count > 0) {
        
        [self.dataArr removeAllObjects];
    }
    weakself
    [PIHttpTool piGet:urlPath(@"api/ticket/myTicket") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIOrderModel *model = [PIOrderModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            [weakSelf.dataArr addObjectsFromArray:model.data];
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        [MBProgressHUD showMessage:@"加载失败"];
    }];
}

- (void)loadMoreData {
    
    [self.tableView.mj_header endRefreshing];
    
    _pageIndex++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNo"] = @(_pageIndex);
    params[@"pageSize"] = @(_pageSize);
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];
    

    weakself
    [PIHttpTool piGet:urlPath(@"api/ticket/myTicket") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIOrderModel *model = [PIOrderModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            [weakSelf.dataArr addObjectsFromArray:model.data];
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
            _pageIndex--;
        }
        
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showMessage:@"加载失败"];
        _pageIndex--;
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    PIOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIOrderViewCell class])];
    
    
    cell.listModel = self.dataArr[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIOrderDetailController *detail = [PIOrderDetailController new];
    
    detail.listData = self.dataArr[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
