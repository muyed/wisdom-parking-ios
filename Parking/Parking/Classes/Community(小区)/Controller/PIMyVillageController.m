//
//  PIMyVillageController.m
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyVillageController.h"
#import "PIVillageAuthenController.h"
#import "PIMyVillageListModel.h"

#import "PIMyVillageViewCell.h"
#import "PIMyVillageDetailController.h"

@interface PIMyVillageController ()

///-- 数据源
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation PIMyVillageController
{
    
    NSInteger _pageIndex;
    NSInteger _pageSize;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的小区";
    [self setupUI];
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.isSuccess) {
        
        [self.tableView.mj_header beginRefreshing];
    }
}
- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - NavBarHeight + 50)];
    
    self.tableView.rowHeight = 130;
    
    self.tableView.estimatedRowHeight = 130;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerClass:[PIMyVillageViewCell class] forCellReuseIdentifier:NSStringFromClass([PIMyVillageViewCell class])];
    
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer= [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData {
    
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    _pageIndex = 1;
    _pageSize = 15;
    
    params[@"pageNo"] = @(_pageIndex);
    params[@"pageSize"] = @(_pageSize);
    
    weakself
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];
    
    if (self.dataArr.count > 0) {
        
        [self.dataArr removeAllObjects];
    }
    
    [PIHttpTool piGet:urlPath(@"api/community/user/list") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIMyVillageListModel *model  = [PIMyVillageListModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            [weakSelf.dataArr addObjectsFromArray:model.data];
            [weakSelf.tableView reloadData];
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"加载失败!"];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)loadMoreData {
    
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    _pageIndex++;
    params[@"pageNo"] = @(_pageIndex);
    params[@"pageSize"] = @(_pageSize);
    
    weakself
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];
    
    [PIHttpTool piGet:urlPath(@"api/community/user/list") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIMyVillageListModel *model  = [PIMyVillageListModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            [weakSelf.dataArr addObjectsFromArray:model.data];
            [weakSelf.tableView reloadData];
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
            _pageIndex--;
        }
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        _pageIndex--;
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"加载失败!"];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIMyVillageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIMyVillageViewCell class])];
    
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIMyVillageDetailController *detail = [PIMyVillageDetailController new];
    detail.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)buttonClick {
    
    PIVillageAuthenController *village = [PIVillageAuthenController new];
    
    [self.navigationController pushViewController:village animated:YES];
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
