//
//  PIAcountCashController.m
//  Parking
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAcountCashController.h"
#import "PIAcountCashHeaderView.h"
#import "PIPIAcountCashCell.h"
#import "PIMyParkModel.h"
#import "PIPayForCashController.h"
#import "PIPutForwardController.h"


@interface PIAcountCashController ()<PIAcountCashCellDelegate>

///-- 头部视图
@property (nonatomic, strong)PIAcountCashHeaderView *headerView;
///-- 数据源
@property (nonatomic, strong) PIMyParkModel *model;

@end

@implementation PIAcountCashController
{
    
    NSInteger _selectIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"押金";
    [self setupUI];
    
    [self loadData];
    
    [PINotification addObserver:self selector:@selector(putCarportCashSuccess) name:@"PutCarportCashSuccess" object:nil];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50)];
    
    self.tableView.rowHeight = 80;
    
    self.headerView = [PIAcountCashHeaderView new];
    self.headerView.size = CGSizeMake(SCREEN_WIDTH, 120);
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerClass:[PIPIAcountCashCell class] forCellReuseIdentifier:NSStringFromClass([PIPIAcountCashCell class])];
}

- (void)loadData {
    
    weakself
    [PIHttpTool piGet:urlPath(@"api/carport/myCarport") params:nil success:^(id response) {
        
        weakSelf.model = [PIMyParkModel mj_objectWithKeyValues:response];
        
        if (weakSelf.model.code == 200) {
            
            [weakSelf.tableView reloadData];
            
        }else {
            
            [MBProgressHUD showMessage:weakSelf.model.errMsg];
        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showMessage:@"获取失败"];
    }];
}

- (void)putCarportCashSuccess {
    
    [self.tableView reloadData];
}

#pragma PIAcountCashCellDelegate

- (void)clickButtonWithIndex:(NSInteger)index {
    
    _selectIndex = index;
    
    PIMyParkDataModel *dataModel = self.model.data[index];
    
    if (dataModel.deposit.floatValue > 0.00) {
        
        PIPutForwardController *put = [PIPutForwardController new];
        
        put.isCash = YES;
        put.dataModel = dataModel;
    
        [self.navigationController pushViewController:put animated:YES];
        
    }else {
        
        PIPayForCashController *pay = [PIPayForCashController new];
        pay.isCarportCash = YES;
        pay.orderNum = dataModel.payNum;
        [self.navigationController pushViewController:pay animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIPIAcountCashCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPIAcountCashCell class])];
    
    cell.dataModel = self.model.data[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//
//}

- (void)dealloc {
    
    [PINotification removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
