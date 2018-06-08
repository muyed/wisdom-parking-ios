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
#import "PIMyVillageController.h"
#import "PIPaySuccessController.h"

@interface PIPayOrderController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PIPayOrderController
{
    
    NSInteger _selectIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"支付";
    
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
    
    [PINotification addObserver:self selector:@selector(backToList:) name:PaySuccessNotifation object:nil];
    
    
}

- (void)backToList:(NSNotification *)noti {
    
    
    NSDictionary *dic = noti.userInfo;
    
    NSLog(@"-----> : %@", dic[@"resultStatus"]);
    
    if ([dic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        PIPaySuccessController *paySuccess = [PIPaySuccessController new];
        
        [self.navigationController pushViewController:paySuccess animated:YES];
        
    }else {
        
        [MBProgressHUD showMessage:dic[@"memo"]];
    }
    
    
}

- (void)bottomBtnClick {
    
    [PIPayTool payForCarportOrderWithID:self.orderNum success:^(NSString *orderNum) {
        
        if (_selectIndex == 0) {
            
            [PIPayTool AlipayForOrderWithOrderNum:orderNum];
        }else {
            
            [PIPayTool WXpayForOrderWithOrderNum:orderNum];
        }
        
    }];
//    //[MBProgressHUD showIndeterWithMessage:@"正在支付..."];
//    
//    [PIPayTool AlipayForOrderWithOrderNum:self.orderNum success:^(id response) {
//        
//        [MBProgressHUD hideHUD];
//        
//        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
//        
//        if (model.code == 200) {
//            
//            [[AlipaySDK defaultService] payOrder:model.data fromScheme:@"wisdompark" callback:^(NSDictionary *resultDic) {
//                
//                NSLog(@"---> %@", resultDic);
//                
//            }];
//            
//        }else {
//            
//            [MBProgressHUD showMessage:model.errMsg];
//        }
//        
//    } failue:^(NSError *error) {
//        
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showMessage:@"支付失败!"];
//    }];
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
        cell.userInteractionEnabled = NO;
        cell.money = self.money;
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
