//
//  PIMyParkingLotController.m
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyParkingLotController.h"
#import "PIMyParkingLotCell.h"
#import "PIVillageAuthenController.h"

@interface PIMyParkingLotController ()

@end

@implementation PIMyParkingLotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的车位";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - NavBarHeight - 10)];

    self.tableView.estimatedRowHeight = 130;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerClass:[PIMyParkingLotCell class] forCellReuseIdentifier:NSStringFromClass([PIMyParkingLotCell class])];
    
    UIButton *bottomBtn = [[UIButton alloc] initWithImageName:@"add_carlot" font:17 titleColor:PIMainColor title:@"认证车位"];
    bottomBtn.backgroundColor = [UIColor whiteColor];
    bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - TabBarHeight - 9, SCREEN_WIDTH, 60);
    
    [bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
}

- (void)buttonClick {
    
    PIVillageAuthenController *village = [PIVillageAuthenController new];
    
    [self.navigationController pushViewController:village animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIMyParkingLotCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIMyParkingLotCell class])];
    
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
