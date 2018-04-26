//
//  PIParkingLotAuthController.m
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIParkingLotAuthController.h"
#import "PIBaseFieldCell.h"
#import "PIParkingLotAuthCell.h"
#import "PIBottomBtn.h"
#import "PIMyVillageListModel.h"
#import "PIBaseModel.h"
#import "PIPayOrderController.h"

@interface PIParkingLotAuthController ()<PIBaseFieldCellDelegate>

///-- 立即绑定
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIParkingLotAuthController
{
    
    NSString *_bindCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加设备";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
    
    self.tableView.scrollEnabled = NO;
    UIView *footerView = [[UIView alloc] init];
    footerView.size = CGSizeMake(SCREEN_WIDTH, 200);
    
    self.tableView.tableFooterView = footerView;
    
    UILabel *tipLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor text:@"温馨提示:"];
    tipLabel.frame = CGRectMake(20, 35, SCREEN_WIDTH - 40, 20);
    
    [footerView addSubview:tipLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
    contentLabel.text = @"添加设备说明";
    contentLabel.frame = CGRectMake(20, CGRectGetMaxY(tipLabel.frame) + 10, SCREEN_WIDTH - 40, 40);
    contentLabel.numberOfLines = 2;
    [footerView addSubview:contentLabel];
    
    
    self.bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"立即绑定"];
    
    self.bottomBtn.x = 30;
    self.bottomBtn.y = CGRectGetMaxY(self.tableView.frame);
    self.bottomBtn.width = SCREEN_WIDTH - 60;
    self.bottomBtn.height = 50;
    self.bottomBtn.layer.cornerRadius = 50 * 0.5;
    self.bottomBtn.clipsToBounds = YES;
    
    [self.bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomBtn];
    
    [self.tableView registerClass:[PIBaseFieldCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
    [self.tableView registerClass:[PIParkingLotAuthCell class] forCellReuseIdentifier:NSStringFromClass([PIParkingLotAuthCell class])];
}

- (void)buttonClick {
    
    if (_bindCode.length == 0) {
        
        [MBProgressHUD showMessage:@"请填写绑定码"];
        
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"carportId"] = self.model.ID;
    params[@"bindCode"] = _bindCode;
    
    weakself
    [PIHttpTool piPost:urlPath(@"api/carport/bind") params:params success:^(id response) {
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        
        
        if (model.code == 200) {
            
            PIPayOrderController *pay = [PIPayOrderController new];
            pay.orderNum = model.data;
            [weakSelf.navigationController pushViewController:pay animated:YES];
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        PIBaseFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseFieldCell class])];
        
         cell.titleString = @"绑定码";
         cell.placeString = @"请填写绑定码";
         cell.pi_delegate = self;
         return cell;
    }else {
        
        PIParkingLotAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIParkingLotAuthCell class])];
        cell.model = self.model;
        cell.address = self.address;
        
        return cell;
    }
   
   
}

- (void)pi_textFieldEndEidting:(UITextField *)textField index:(NSInteger)index {
    
    _bindCode = textField.text.cancelSpace;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        return 80;
    }else {
        
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        return 80;
        
    }else {
        
        return 100;
    }
    
    
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
