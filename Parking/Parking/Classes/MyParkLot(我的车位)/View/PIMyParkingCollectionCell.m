//
//  PIMyParkingCollectionCell.m
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyParkingCollectionCell.h"
#import "PIComCertiHeaderView.h"
#import "PIComCerBtnCell.h"
#import "PIComCerNumberCell.h"
#import "PIComCerShareCell.h"
#import "PIMyParkModel.h"


@interface PIMyParkingCollectionCell ()<UITableViewDataSource, UITableViewDelegate>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- <#Notes#>
@property (nonatomic, weak) PIComCertiHeaderView *headerView;

@end

@implementation PIMyParkingCollectionCell

-  (instancetype)initWithFrame:(CGRect)frame {
    
    self= [super initWithFrame:frame];
    
    if (self) {
        
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = 120;
    self.tableView.scrollEnabled = NO;
    [self.contentView addSubview:self.tableView];
    
    PIComCertiHeaderView *headerView = [PIComCertiHeaderView new];
    headerView.size = CGSizeMake(SCREEN_WIDTH, 140 * Scale_Y);
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    [self.tableView registerClass:[PIComCerBtnCell class] forCellReuseIdentifier:NSStringFromClass([PIComCerBtnCell class])];
    
    [self.tableView registerClass:[PIComCerNumberCell class] forCellReuseIdentifier:NSStringFromClass([PIComCerNumberCell class])];
    
    [self.tableView registerClass:[PIComCerShareCell class] forCellReuseIdentifier:NSStringFromClass([PIComCerShareCell class])];
    
}

- (void)setModel:(PIMyParkDataModel *)model {
    
    _model = model;
    
    self.headerView.index = self.index;
    self.headerView.lockName = model.alias;
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PIComCerBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIComCerBtnCell class])];
        cell.model = self.model;
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        PIComCerNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIComCerNumberCell class])];
        
        return cell;
        
    }
    
    PIComCerShareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIComCerShareCell class])];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        return 120;
    }else {
        
        return 100;
    }
}


@end
