//
//  PIMineViewController.m
//  Parking
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 GM. All rights reserved.
//  个人中心

#import "PIMineViewController.h"
#import "PIMineCenterView.h"
#import "PIMineViewCell.h"

@interface PIMineViewController ()<UITableViewDelegate, UITableViewDataSource>

///-- 导航
@property (nonatomic, weak) UIView *navView;
///-- 头部视图
@property (nonatomic, strong) UIImageView *iconView;
///-- 登录按钮
@property (nonatomic, strong) UIButton *loginBtn;
///-- 中间
@property (nonatomic, strong) PIMineCenterView *centerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PIMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)setupNav {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight + 180 * Scale_Y)];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    self.navView = nav;
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我的";
    label.font = [UIFont boldSystemFontOfSize:18.0];
    CGFloat top = NavBarHeight - 34;
    label.frame = CGRectMake(0, top, SCREEN_WIDTH, 24);
    
    [nav addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithImageName:@"navgation-back"];
    btn.x =  15;
    btn.y = top;
    btn.width = 25;
    btn.height = 25;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:btn];
    
    [self.navView addSubview:self.iconView];
    [self.navView addSubview:self.loginBtn];
    [self.view addSubview:self.centerView];
    
    weakself
    
    CGFloat iconWH = 70 * Scale_Y;
    CGFloat margin = 20 * Scale_Y;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.navView).offset(margin);
        make.top.equalTo(btn.mas_bottom).offset(margin);
        make.height.and.width.mas_equalTo(iconWH);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.iconView.mas_right).offset(margin);
        make.centerY.equalTo(weakSelf.iconView.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40 *Scale_Y);
    }];
    
    self.iconView.layer.cornerRadius = iconWH * 0.5;
    self.iconView.clipsToBounds = YES;
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(margin);
        make.right.equalTo(weakSelf.view).offset(-margin);
        make.top.equalTo(weakSelf.view).offset(NavBarHeight + 110 * Scale_Y);
        make.height.mas_equalTo(150 * Scale_Y);
    }];
    
    CGFloat tableViewY = NavBarHeight + 260 * Scale_Y;
    
    NSLog(@"%lf", tableViewY);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, SCREEN_WIDTH, SCREEN_HEIGHT - tableViewY) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[PIMineViewCell class] forCellReuseIdentifier:NSStringFromClass([PIMineViewCell class])];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if (indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = indexPath.row == 0 ? @"常见问题" : @"更多";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         return cell;
    }
   
    PIMineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIMineViewCell class])];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15 * Scale_Y;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return SCREEN_WIDTH * 0.25;
    }else {
        
        return 60 * Scale_Y;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 懒加载
- (UIImageView *)iconView {
    
    if (!_iconView) {
        
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor redColor];
    }
    
    return _iconView;
}

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        
        _loginBtn = [[UIButton alloc] initWithFont:15 titleColor:[UIColor whiteColor] title:@"登录/注册"];
        _loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _loginBtn.layer.borderWidth = 1;
        _loginBtn.layer.cornerRadius = 5;
        _loginBtn.clipsToBounds = YES;
    }
    
    return _loginBtn;
}

- (PIMineCenterView *)centerView {
    
    if (!_centerView) {
        
        _centerView = [PIMineCenterView new];
    }
    
    return _centerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
