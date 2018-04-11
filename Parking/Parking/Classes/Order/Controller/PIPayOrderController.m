//
//  PIPayOrderController.m
//  Parking
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPayOrderController.h"
#import "PIPayOrderTopCell.h"
#import "PIPayOrderTypeCell.h"
#import "PIBottomBtn.h"

@interface PIPayOrderController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PIPayOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"订单";
    
    [self setupUI];
}

- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 60;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorColor = sepLineColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[PIPayOrderTopCell class] forCellReuseIdentifier:NSStringFromClass([PIPayOrderTopCell class])];
    
     [self.tableView registerClass:[PIPayOrderTypeCell class] forCellReuseIdentifier:NSStringFromClass([PIPayOrderTypeCell class])];
    
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    
    bottomBtn.x = btnBorderM;
    bottomBtn.y = SCREEN_HEIGHT - 250 * Scale_Y;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50 * Scale_Y;
    bottomBtn.layer.cornerRadius = 50 * Scale_Y * 0.5;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)bottomBtnClick {
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }else {
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.section == 0) {
        
        PIPayOrderTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPayOrderTopCell class])];
        
        return cell;
    }
    
    PIPayOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPayOrderTypeCell class])];
    
    if (indexPath.row == 0) {
        
        cell.imageName = @"order_alipay";
        cell.titleStr = @"支付宝";
    }else {
        
        cell.imageName = @"order_wx";
        cell.titleStr = @"微信";
    }
   
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return section == 0 ? 15 * Scale_Y : 60 * Scale_Y;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     return 80 * Scale_Y;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (section == 1) {
        
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        header.textLabel.textColor = txtSeconColor;
        header.textLabel.text = @"   选择支付方式";
        header.textLabel.font = PISYS_FONT(18);
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
