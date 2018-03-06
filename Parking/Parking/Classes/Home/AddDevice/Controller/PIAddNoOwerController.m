//
//  PIAddNoOwerController.m
//  Parking
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddNoOwerController.h"
#import "PIAddNoOwerHeaderView.h"
#import "PIAddCarHeaderView.h"
#import "PICarNumCell.h"
#import "PIAddWisedomeCarCell.h"
#import "PIAddPersonCell.h"
#import "PIBottomBtn.h"

@interface PIAddNoOwerController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 透视图
@property (nonatomic, strong) PIAddNoOwerHeaderView *headerView;

@end

@implementation PIAddNoOwerController
{
    
    NSInteger _count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加设备";
    
    
    [self setupTableView];
}

- (void)setupTableView {
    
    _count = 1;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 49;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    self.headerView = [[PIAddNoOwerHeaderView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, 240)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerClass:[PICarNumCell class] forCellReuseIdentifier:NSStringFromClass([PICarNumCell class])];
    
    [self.tableView registerClass:[PIAddWisedomeCarCell class] forCellReuseIdentifier:NSStringFromClass([PIAddWisedomeCarCell class])];
    
    [self.tableView registerClass:[PIAddPersonCell class] forCellReuseIdentifier:NSStringFromClass([PIAddPersonCell class])];
    
    PIBottomBtn *bottomBtn = [[PIBottomBtn alloc] initWithFont:17 titleColor:[UIColor whiteColor] title:@"完成添加"];
    
    bottomBtn.x = 0;
    bottomBtn.y = SCREEN_HEIGHT - TabBarHeight;
    bottomBtn.width = SCREEN_WIDTH;
    bottomBtn.height = 50;
    [bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}

- (void)buttonClick {
    
    [MBProgressHUD showMessage:@"正在努力建设中...."];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return _count;
    }else if (section == 0) {
        
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        PICarNumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PICarNumCell class])];
        
        cell.index = indexPath.row + 1;
        
        weakself
        [cell setClickIndex:^(NSInteger index) {
            
            [weakSelf addBtnClick:index];
        }];
        return cell;
        
    }else if (indexPath.section == 0) {
        
        PIAddWisedomeCarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIAddWisedomeCarCell class])];
        
        return cell;
    }
    
    PIAddPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIAddPersonCell class])];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PIAddCarHeaderView *headerView = [PIAddCarHeaderView addcarHeaderView:tableView];
    
    if (section == 0) {
        
        headerView.titles = @"智能车位锁";
    }else if(section == 1){
        
        headerView.titles = @"智能车辆识别仪";
    }else {
        
        headerView.titles = @"智能行人道闸";
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        return 100;
    }else if (indexPath.section == 0){
        
        return 200;
    }else {
        
        return 60;
    }
}
- (void)addBtnClick:(NSInteger)index {
    
    if (index == 1) {
        
        _count += 1;
    }else {
        
        _count -= 1;
    }
    
    [self.tableView reloadData];
  
    
    if (_count > 3) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(_count - 1) inSection:1];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
