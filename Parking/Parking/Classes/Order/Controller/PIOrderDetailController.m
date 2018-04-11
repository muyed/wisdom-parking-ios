//
//  PIOrderDetailController.m
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIOrderDetailController.h"
#import "PIOrderDetailViewCell.h"
#import "PIOrderDetailCenterCell.h"
#import "PIBottomBtn.h"
#import "PIPayOrderController.h"

@interface PIOrderDetailController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 数据源
@property (nonatomic, copy) NSArray *titleArr;
///-- 内容
@property (nonatomic, copy) NSArray *contentArr;

@end

@implementation PIOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    [self setupUI];
}

- (void)setupUI {
    
    self.titleArr = @[@[@"订单编号:", @"手机号码:", @"下单时间:", @"取消时间:"], @[@"应付:"]];
    self.contentArr = @[@[@"00000000122", @"15737865198", @"2018-03-25 13:34:36", @"2018-03-25 13:34:36"], @[@"￥4.00"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 60;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
     [self.tableView registerClass:[PIOrderDetailViewCell class] forCellReuseIdentifier:NSStringFromClass([PIOrderDetailViewCell class])];
    
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    
    bottomBtn.x = btnBorderM;
    bottomBtn.y = SCREEN_HEIGHT - NavBarHeight - 20 * Scale_Y - TabBarHeight;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50 * Scale_Y;
    bottomBtn.layer.cornerRadius = 50 * Scale_Y * 0.5;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"支付" forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)bottomBtnClick {
    
    PIPayOrderController *pay = [PIPayOrderController new];
    
    [self.navigationController pushViewController:pay animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }else if(section == 1){
        
        return 4;
    }else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 1) {
//
//
//    }
    
    if (indexPath.section == 0) {
        
        PIOrderDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIOrderDetailViewCell class])];
        
        return cell;
    }
    
    PIOrderDetailCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIOrderDetailCenterCell class])];
    
    if (!cell) {
        
        cell = [[PIOrderDetailCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PIOrderDetailCenterCell class])];
    }
    
    cell.titleStr = self.titleArr[indexPath.section - 1][indexPath.row];
    cell.contentStr = self.contentArr[indexPath.section- 1][indexPath.row];
    
    cell.isPrice = indexPath.section == 2 ? YES : NO;
    
    return cell;
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15 * Scale_Y;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 175 * Scale_Y;
    }else if(indexPath.section == 1){
        
        return 40 * Scale_Y;
        
    }else {
        
        return 60 * Scale_Y;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
