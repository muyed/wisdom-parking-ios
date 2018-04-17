//
//  PIComCertifiController.m
//  Parking
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 GM. All rights reserved.
//  小区

#import "PIComCertifiController.h"
#import "PIComCertiHeaderView.h"
#import "PIComCerBtnCell.h"
#import "PIComCerNumberCell.h"
#import "PIComCerShareCell.h"

@interface PIComCertifiController ()<UITableViewDataSource, UITableViewDelegate>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 导航
@property (nonatomic, weak) UIView *navView;

@end

@implementation PIComCertifiController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNav];
}

- (void)setupNav {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    self.navView = nav;
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我的车位";
    label.font = [UIFont boldSystemFontOfSize:18.0];
    CGFloat top = NavBarHeight - 34;
    label.frame = CGRectMake(0, top, SCREEN_WIDTH, 24);
    
    [nav addSubview:label];
    
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    
    contentView.contentSize = CGSizeMake(contentView.width * 4, 0);
    
    UIButton *btn = [[UIButton alloc] initWithImageName:@"navgation-back"];
    btn.x = 15;
    btn.y = top;
    btn.width = 25;
    btn.height = 25;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:btn];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,contentView.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = 120;
    self.tableView.scrollEnabled = NO;
    [contentView addSubview:self.tableView];
    
    PIComCertiHeaderView *headerView = [PIComCertiHeaderView new];
    headerView.size = CGSizeMake(SCREEN_WIDTH, 140 * Scale_Y);
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerClass:[PIComCerBtnCell class] forCellReuseIdentifier:NSStringFromClass([PIComCerBtnCell class])];
    
    [self.tableView registerClass:[PIComCerNumberCell class] forCellReuseIdentifier:NSStringFromClass([PIComCerNumberCell class])];
    
    [self.tableView registerClass:[PIComCerShareCell class] forCellReuseIdentifier:NSStringFromClass([PIComCerShareCell class])];
    
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
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
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        PIComCerNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIComCerNumberCell class])];
        
        return cell;
        
    }
    
    PIComCerShareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIComCerShareCell class])];
    
    return cell;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
