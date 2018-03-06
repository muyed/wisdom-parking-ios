//
//  PIAddPayViewController.m
//  Parking
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddPayViewController.h"
#import "PIAddPayViewCell.h"
#import "PIBottomBtn.h"

@interface PIAddPayViewController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 押金
@property (nonatomic, strong) UILabel *moneyLabel;
///-- 立即支付按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIAddPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付押金";
    
    [self setupNav];
    [self setupTableView];
    
}

- (void)setupNav {
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"navgation-back" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 49;
    self.tableView.rowHeight = 100;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[PIAddPayViewCell class] forCellReuseIdentifier:NSStringFromClass([PIAddPayViewCell class])];
    
    self.bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"立即支付"];
    
    self.bottomBtn.x = 30;
    self.bottomBtn.y = SCREEN_HEIGHT - 200;
    self.bottomBtn.width = SCREEN_WIDTH - 60;
    self.bottomBtn.height = 45;
    self.bottomBtn.layer.cornerRadius = 10;
    self.bottomBtn.clipsToBounds = YES;
    
    [self.bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomBtn];
    
    UILabel *label = [[UILabel alloc] initWithFont:15 textColor:txtSeconColor textAlignment:Center text:@"押金随时可退，中国工商银行监管  缴纳后即表示同意《用户守则》"];
    label.numberOfLines = 2;
    label.x = 15;
    label.y = CGRectGetMaxY(self.bottomBtn.frame) + 15;
    label.width = SCREEN_WIDTH - 30;
    label.height = 50;
    [self.view addSubview:label];
}

- (void)buttonClick {
    
    [MBProgressHUD showMessage:@"正在努力建设中..."];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIAddPayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIAddPayViewCell class])];
    if (indexPath.row == 0) {
        
        cell.imageName = @"home_add_zhifu";
        cell.descString = @"支付宝支付";
        
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }else {
        
        cell.imageName = @"share0";
        cell.descString = @"微信支付";
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.x = 15;
    self.moneyLabel.y = 10;
    self.moneyLabel.width = SCREEN_WIDTH - 30;
    self.moneyLabel.height = 29;
    self.moneyLabel.font = PISYS_FONT(17);
    self.moneyLabel.text = @"缴纳押金 299 元 (可退)";
    [headView addSubview:self.moneyLabel];
    return headView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
