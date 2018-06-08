//
//  PIOrderDetailController.m
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIOrderDetailController.h"
#import "PIOrderDetailViewCell.h"
#import "PIOrderDetailCenterCell.h"
#import "PIBottomBtn.h"
#import "PIPayOrderController.h"
#import "PIOrderModel.h"

@interface PIOrderDetailController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 数据源
@property (nonatomic, copy) NSArray *titleArr;
///-- 内容
@property (nonatomic, copy) NSArray *contentArr;

@end

@implementation PIOrderDetailController
{
    
    dispatch_source_t _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    [self setupUI];
}

- (void)setupUI {
    
    self.titleArr = @[@[@"订单编号:", @"手机号码:", @"下单时间:", @"取消时间:"], @[@"金额:"]];
    self.contentArr = @[@[self.listData.ticketNum, self.listData.phone, self.listData.appointmentStartTime, self.listData.appointmentEndTime], @[self.listData.parkingFee]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 60;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
     [self.tableView registerClass:[PIOrderDetailViewCell class] forCellReuseIdentifier:NSStringFromClass([PIOrderDetailViewCell class])];
    
    if (self.listData.status == 0 || self.listData.status == 5) {
        
        PIBottomBtn *bottomBtn = [PIBottomBtn new];
        
        bottomBtn.x = btnBorderM;
        bottomBtn.y = SCREEN_HEIGHT - NavBarHeight - 20 * Scale_Y - TabBarHeight;
        bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
        bottomBtn.height = 50 * Scale_Y;
        bottomBtn.layer.cornerRadius = 50 * Scale_Y * 0.5;
        bottomBtn.clipsToBounds = YES;
        [bottomBtn setTitle:@"支付" forState:UIControlStateNormal];
        [self.view addSubview:bottomBtn];
        
        [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
   
    [self startTimer:[self.listData.payDeadlineTime getTimeDifference]];
 
    
    [PINotification addObserver:self selector:@selector(enterGround) name:UIApplicationWillEnterForegroundNotification object:nil];

    [PINotification addObserver:self selector:@selector(enterBackGround) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}

- (void)enterGround {

     [self startTimer:[self.listData.payDeadlineTime getTimeDifference]];
}

- (void)enterBackGround {

    ///-- 销毁
    dispatch_source_cancel(_timer);
    
}

- (void)bottomBtnClick {
    
    PIPayOrderController *pay = [PIPayOrderController new];
    pay.orderNum = self.listData.ID;
    pay.money = self.listData.parkingFee;
    [self.navigationController pushViewController:pay animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }else if(section == 1){
        
        return 4;
    }else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 1) {
//
//
//    }
    
    if (indexPath.section == 0) {
        
        PIOrderDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIOrderDetailViewCell class])];
        
        cell.orderCode = self.listData.openCode;
        cell.listData = self.listData;
        return cell;
    }
    
    PIOrderDetailCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIOrderDetailCenterCell class])];
    
    if (!cell) {
        
        cell = [[PIOrderDetailCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PIOrderDetailCenterCell class])];
    }
    
    cell.titleStr = self.titleArr[indexPath.section - 1][indexPath.row];
    cell.contentStr = self.contentArr[indexPath.section- 1][indexPath.row];
    
    cell.isPrice = indexPath.section == 2 ? YES : NO;
    
    return cell;
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15 * Scale_Y;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 175 * Scale_Y;
    }else if(indexPath.section == 1){
        
        return 40 * Scale_Y;
        
    }else {
        
        return 60 * Scale_Y;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}



- (void)startTimer:(NSInteger)surplusTime {
    
    __block NSInteger timeout = surplusTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,DISPATCH_TIME_NOW,1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        
        
        if(timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
            });
        }
        else
        {
            NSInteger minutes = timeout / 60;
            NSInteger senconds = timeout % 60;
            
            //NSLog(@"%ld分 %ld秒", (long)minutes, (long)senconds);
            NSString *differTime = [NSString stringWithFormat:@"%02lu:%02lu", minutes, senconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                 NSLog(@"%@", differTime);
            });
            
           
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)dealloc {
    
    [PINotification removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
