//
//  PIPayForCashController.m
//  Parking
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPayForCashController.h"
#import "PIPayForCashCell.h"
#import "PIPayOrderTypeCell.h"
#import "PIBottomBtn.h"
#import "PIPaySuccessController.h"


@interface PIPayForCashController ()

@end

@implementation PIPayForCashController
{
    
    NSInteger _selectIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"缴纳押金";
    _selectIndex = 0;
    [self setupUI];
    
}


- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - NavBarHeight + 50)];
    
    self.tableView.scrollEnabled = NO;
    
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    
    bottomBtn.x = btnBorderM;
    bottomBtn.y = SCREEN_HEIGHT - NavBarHeight;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50 * Scale_Y;
    bottomBtn.layer.cornerRadius = 50 * Scale_Y * 0.5;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor textAlignment:Center text:@"缴纳后即表示同意《用户守则》"];
    tipLabel.frame = CGRectMake(15 * Scale_Y, SCREEN_HEIGHT - NavBarHeight - 40, SCREEN_WIDTH - 30 * Scale_Y, 20);
    [self.view addSubview:tipLabel];
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[PIPayForCashCell class] forCellReuseIdentifier:NSStringFromClass([PIPayForCashCell class])];
    
    [self.tableView registerClass:[PIPayOrderTypeCell class] forCellReuseIdentifier:NSStringFromClass([PIPayOrderTypeCell class])];
    
     [PINotification addObserver:self selector:@selector(backToList:) name:PaySuccessNotifation object:nil];
    
}

- (void)backToList:(NSNotification *)noti {
    
    
    NSDictionary *dic = noti.userInfo;
    
    
    if ([dic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        if (self.isCarportCash) {
            
            self.dataModel.deposit = [PILoginTool defaultTool].carportCashConf;
            
            [PINotification postNotificationName:@"PutCarportCashSuccess" object:nil];
            
        }else {
            
            CGFloat acountCash = [PILoginTool defaultTool].accountCashConf.floatValue;
            
            [[PILoginTool defaultTool] updateAcountCash: acountCash];
            
            [PINotification postNotificationName:PIPayForCashDeposit object:nil];
        }
        
        
        
        PIPaySuccessController *paySuccess = [PIPaySuccessController new];
        
        [self.navigationController pushViewController:paySuccess animated:YES];
        
    }else {
        
        [MBProgressHUD showMessage:dic[@"memo"]];
    }
    
    
}

- (void)bottomBtnClick {
    
    if (self.orderNum.length == 0) {
        
        [PIPayTool payForAcountCash:^(NSString *orderNum) {
            
            if (_selectIndex == 0) {
                
                [PIPayTool AlipayForOrderWithOrderNum:orderNum];
            }else {
                
                [PIPayTool WXpayForOrderWithOrderNum:orderNum];
            }
            
            
            
        }];
    }else {
        
        
        if (_selectIndex == 0) {
            
            [PIPayTool AlipayForOrderWithOrderNum:self.orderNum];
        }else {
            
            [PIPayTool WXpayForOrderWithOrderNum:self.orderNum];
        }
    }
   
    
   
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
        
        PIPayForCashCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPayForCashCell class])];
        cell.userInteractionEnabled = NO;
        
        cell.cash = self.isCarportCash ? [PILoginTool defaultTool].carportCashConf : [PILoginTool defaultTool].accountCashConf;
        
        return cell;
    }
    
    PIPayOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPayOrderTypeCell class])];
    
    if (indexPath.row == 0) {
        
        cell.imageName = @"order_alipay";
        cell.titleStr = @"支付宝";
        
         [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }else {
        
        cell.imageName = @"order_wx";
        cell.titleStr = @"微信";
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return section == 0 ? CGFLOAT_MIN: 60 * Scale_Y;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section) {
        
        return 80 * Scale_Y;
    }else {
        
        return 120 * Scale_Y;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (section == 1) {
        
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        header.textLabel.textColor = txtSeconColor;
        header.textLabel.text = @"   选择支付方式";
        header.textLabel.font = PISYS_FONT(18);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectIndex = indexPath.row;
    
    
}

- (void)dealloc {
    
    [PINotification removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
