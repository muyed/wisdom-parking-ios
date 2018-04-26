//
//  PIMyVillageDetailController.m
//  Parking
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyVillageDetailController.h"
#import "PIMyVillageListModel.h"
#import "PIMyParkingLotCell.h"
#import "PIOrderViewCell.h"


@interface PIMyVillageDetailController ()

@end

@implementation PIMyVillageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.communityName;
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - NavBarHeight + 50)];
    
    //self.tableView.rowHeight = 130;
    
    [self.tableView registerClass:[PIOrderViewCell class] forCellReuseIdentifier:NSStringFromClass([PIOrderViewCell class])];
    
     [self.tableView registerClass:[PIMyParkingLotCell class] forCellReuseIdentifier:NSStringFromClass([PIMyParkingLotCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.model.type == 3) {
        
        return section ? 0 : 1;
    }
    return section ? self.model.carportList.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PIOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIOrderViewCell class])];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.model = self.model;
        return cell;
    }
  
    
    PIMyParkingLotCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIMyParkingLotCell class])];
    
    cell.isCanBind = self.model.type == 2 ? YES : NO;
    cell.model = self.model.carportList[indexPath.row];
    cell.address = self.model.addr;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section ? 90 : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? 130 : 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 79)];
        header.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:header];
        
        NSString *tip;
        NSString *bottomStr;
        if (self.model.type == 3) {
            
            tip = @"拒绝原因";
            bottomStr = self.model.reason.length == 0 ? @"暂无" : self.model.reason;
        }else {
            
            tip = @"车位信息";
            bottomStr = [NSString stringWithFormat:@"该小区共绑定%lu个车位", self.model.carportList.count];
        }
        UILabel *tipLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor text:tip];
        tipLabel.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 20);
        [header addSubview:tipLabel];
       
        
        UILabel *bottomLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
        bottomLabel.frame = CGRectMake(15, 50, SCREEN_WIDTH - 120, 20);
        bottomLabel.text = bottomStr;
        [header addSubview:bottomLabel];
        
        return bgView;
    }
    
    return nil;
}


@end
