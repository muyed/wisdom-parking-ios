//
//  PIBindBankCardController.m
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBindBankCardController.h"
#import "PIBaseFieldCell.h"
#import "PIBaseDetailCell.h"
#import "PIBottomBtn.h"
#import "PIBankListController.h"
#import "PIBankModel.h"
#import "PIBaseModel.h"

@interface PIBindBankCardController ()<PIBaseFieldCellDelegate>

///-- <#Notes#>
@property (nonatomic, strong) PIBankModel *bankModel;
@end

@implementation PIBindBankCardController
{
    
    NSString *_carNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加银行卡";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50)];
    self.tableView.rowHeight = 80;
    self.tableView.scrollEnabled = NO;
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    bottomBtn.x = btnBorderM;
    bottomBtn.y = 400;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50 * Scale_Y;
    bottomBtn.layer.cornerRadius = 50 * Scale_Y * 0.5;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottomBtn];
    
    [self.tableView registerClass:[PIBaseFieldCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
    [self.tableView registerClass:[PIBaseDetailCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseDetailCell class])];
}

- (void)bottomBtnClick {
    
    if (self.bankModel == nil) {
        
        [MBProgressHUD showMessage:@"请选择银行"];
        
        return;
    }
    
    if (_carNum.cancelSpace.length == 0) {
        
        [MBProgressHUD showMessage:@"请输入银行卡号"];
        
        return;
    }
    
    [MBProgressHUD showIndeterWithMessage:@"正在提交..."];
    
    weakself
    [PIPayTool bindBankCardWithAcount:_carNum name:[[PILoginTool defaultTool] getAcountInfo].realName bankAddr:nil bankCode:self.bankModel.bank_code success:^(id response) {
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        [MBProgressHUD hideHUD];
        
        if (model.code == 200) {
            
            [MBProgressHUD showMessage:@"绑定成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                if (weakSelf.bindSuccess) {
                    
                    weakSelf.bindSuccess();
                }
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            });
           
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
    } failue:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"绑定失败"];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 2) {
        
        PIBaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseDetailCell class])];
        
        if (indexPath.row == 1) {
            
            cell.titleString = @"持卡人";
            cell.contentString = [[PILoginTool defaultTool] getAcountInfo].realName;
        }else {
            
           
            cell.titleString = @"银行类型";
            
            if (self.bankModel) {
                
                cell.contentString = self.bankModel.bank_name;
                cell.contentColor = txtMainColor;
            }else {
                
                cell.contentString = @"请选择银行";
                cell.contentColor = txtPlaceColor;
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
        
    }else {
        
        PIBaseFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseFieldCell class])];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.titleString = @"卡   号";
        cell.placeString = @"无需网银/免手续费";
        cell.pi_delegate = self;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    UILabel *label = [[UILabel alloc] initWithFont:15 textColor:txtSeconColor text:@"请绑定持卡人本人的银行卡"];
    label.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 40);
    [header addSubview:label];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        PIBankListController *list = [PIBankListController new];
        
        weakself
        [list setBankInfo:^(PIBankModel *bankModel) {
            
            weakSelf.bankModel = bankModel;
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:list animated:YES];
    }
}

- (void)pi_textFieldEndEidting:(UITextField *)textField index:(NSInteger)index {
    
    _carNum = textField.text;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
