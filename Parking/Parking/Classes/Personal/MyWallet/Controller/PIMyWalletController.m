//
//  PIMyWalletController.m
//  Parking
//
//  Created by apple on 2018/5/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyWalletController.h"
#import "PIMyWalletHeaderView.h"
#import "PIPayOrderTypeCell.h"
#import "PIBottomBtn.h"
#import "PIPutForwardController.h"

@interface PIMyWalletController ()

///-- 导航
@property (nonatomic, weak) UIView *navView;
///-- 头部视图
@property (nonatomic, weak) PIMyWalletHeaderView *headerView;

@end

@implementation PIMyWalletController
{
    
    NSInteger _selectIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight - 20)];
    
    [self.tableView registerClass:[PIPayOrderTypeCell class] forCellReuseIdentifier:NSStringFromClass([PIPayOrderTypeCell class])];
    
    PIMyWalletHeaderView *headerView = [PIMyWalletHeaderView new];
    headerView.size = CGSizeMake(SCREEN_WIDTH, 350 * Scale_Y);
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)setupNav {

    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    self.navView = nav;

    UILabel *label = [[UILabel alloc] init];

    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我的钱包";
    label.font = [UIFont boldSystemFontOfSize:18.0];
    CGFloat top = NavBarHeight - 34;
    label.frame = CGRectMake(0, top, SCREEN_WIDTH, 24);

    [nav addSubview:label];

    UIButton *btn = [[UIButton alloc] initWithImageName:@"navgation-back"];
    btn.x = 15;
    btn.y = top;
    btn.width = 25;
    btn.height = 25;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:btn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithTitle:@"提现"];
    rightBtn.x = SCREEN_WIDTH - 60;
    rightBtn.y = top;
    rightBtn.width = 60;
    rightBtn.height = 25;
    [rightBtn addTarget:self action:@selector(putForward) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:rightBtn];
    

    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabBarHeight - 20, SCREEN_WIDTH, 70)];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bottomView];
    
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    
    bottomBtn.x = btnBorderM;
    bottomBtn.y = 10;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50;
    bottomBtn.layer.cornerRadius = 25;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [bottomView addSubview:bottomBtn];
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)putForward {
    
    PIPutForwardController *putForward = [PIPutForwardController new];
    
    [self.navigationController pushViewController:putForward animated:YES];
}
- (void)bottomBtnClick {
    
    NSLog(@"立即充值");
    
    NSLog(@"---> %lu", _selectIndex);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIPayOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPayOrderTypeCell class])];
    
    if (indexPath.row == 0) {
        
        cell.imageName = @"order_alipay";
        cell.titleStr = @"支付宝";
        cell.selected = YES;
        
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }else {
        
        cell.imageName = @"order_wx";
        cell.titleStr = @"微信";
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectIndex = indexPath.row;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    UILabel *label = [[UILabel alloc] initWithFont:16 textColor:txtMainColor text:@"选择支付方式"];
    label.frame = CGRectMake(20* Scale_Y, 0, SCREEN_WIDTH - 40 * Scale_Y, 40);
    [header addSubview:label];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 80 * Scale_Y;
}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
