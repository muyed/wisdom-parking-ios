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

@interface PIOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PIOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
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
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    PIOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIOrderViewCell class])];
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIOrderDetailController *detail = [PIOrderDetailController new];
    
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
