//
//  PIPutForwardController.m
//  Parking
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPutForwardController.h"
#import "PIMyCardsModel.h"
#import "PIMyBankCardsController.h"
#import "PIPutForwardCell.h"
#import "PIBottomBtn.h"
#import "PIVillageAuthenProgressController.h"
#import "PIMyParkModel.h"

@interface PIPutForwardController ()<UITextFieldDelegate>

///-- 银行
@property (nonatomic, strong) PIMyCardsDataModel *bankModel;
///-- <#Notes#>
@property (nonatomic, weak) UITextField *moneyField;
///-- <#Notes#>
@property (nonatomic, weak) PIBottomBtn *bottomBtn;
@end

@implementation PIPutForwardController
{
    NSString *_balance;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50)];
    self.tableView.scrollEnabled = NO;
    
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    
    bottomBtn.x = btnBorderM;
    bottomBtn.y = 400;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50;
    bottomBtn.layer.cornerRadius = 25;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [bottomBtn setTitle:@"确认提现" forState:UIControlStateDisabled];
    bottomBtn.enabled = self.isCash;
    [self.view addSubview:bottomBtn];
    
    self.bottomBtn = bottomBtn;
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[PIPutForwardCell class] forCellReuseIdentifier:NSStringFromClass([PIPutForwardCell class])];
    
    [PINotification addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)bottomBtnClick {
    
    if (self.bankModel == nil) {

        [MBProgressHUD showMessage:@"请选择银行卡"];

        return;
    }

    
     weakself
    
    if (self.dataModel) {
        
        [MBProgressHUD showIndeterWithMessage:@"正在提取..."];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"bankId"] = self.bankModel.ID;
        params[@"id"] = self.dataModel.carportId;
        
        [PIHttpTool piPost:urlPath(@"api/carport/withdraw") params:params success:^(id response) {
            
            [MBProgressHUD hideHUD];
            
            PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
            NSLog(@"%@", model.errMsg);
            
            if (model.code == 200) {
                
                weakSelf.dataModel.deposit = @"0.00";
                
                [PINotification postNotificationName:@"PutCarportCashSuccess" object:nil];
                
                _balance = weakSelf.dataModel.deposit;
                
                [weakSelf putSuccess];
                
            }else {
                
                [MBProgressHUD showMessage:model.errMsg];
            }
            
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideHUD];
        }];
        
    }else if (self.isCash) {
        
         [MBProgressHUD showIndeterWithMessage:@"正在提取..."];
        
        [PIPayTool withdrawCashWithBankCardID:self.bankModel.ID success:^(id response) {
            
            [MBProgressHUD hideHUD];
            PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
            NSLog(@"%@", model.errMsg);
            
            if (model.code == 200) {
                
                
                [[PILoginTool defaultTool] updateAcountCash: 0.00];
                
                _balance = [PILoginTool defaultTool].accountCashConf
                ;
                
                [PINotification postNotificationName:PIPayForCashDeposit object:nil];
                
                [weakSelf putSuccess];
            }else {
                
                [MBProgressHUD showMessage:model.errMsg];
            }
               
                
        } failue:^(NSError *error) {
            
            [MBProgressHUD hideHUD];
        }];
        
    }else {
        
        if (self.moneyField.text.cancelSpace.length == 0) {
            
            [MBProgressHUD showMessage:@"请输入金额"];
            return;
        }
        
         [MBProgressHUD showIndeterWithMessage:@"正在提取..."];
        
        _balance = self.moneyField.text.cancelSpace;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"bankId"] = self.bankModel.ID;
        params[@"amount"] = _balance;
        
        
        [PIHttpTool piPost:urlPath(@"api/account/withdrawBalance") params:params success:^(id response) {
            
            [MBProgressHUD hideHUD];
            
            PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
            NSLog(@"%@", model.errMsg);
            
            if (model.code == 200) {
                
                CGFloat balance = [PILoginTool defaultTool].balance;
                balance = balance - weakSelf.moneyField.text.floatValue;
                [[PILoginTool defaultTool] updateBalance:balance];
                
                [weakSelf putSuccess];
                
            }else {
                
                [MBProgressHUD showMessage:model.errMsg];
            }
            
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideHUD];
        }];
    }
    

}

- (void)putSuccess {
    
    weakself
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *bankAcount = [weakSelf.bankModel.bankAccount stringByReplacingCharactersInRange:NSMakeRange(0, weakSelf.bankModel.bankAccount.length - 4) withString:@"**** **** ****"];
        
        PIVillageAuthenProgressController *person = [PIVillageAuthenProgressController new];
        person.titleArr = @[@"订单金额", @"提现至"];
        person.contentArr = @[_balance, bankAcount];
        person.imageName = @"put_forward_success";
        person.tipTitle = @"提现成功";
        person.authTitle = @"提现";
        
        [weakSelf.navigationController pushViewController:person animated:YES];
        
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        PIPutForwardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPutForwardCell class])];
        
        cell.moneyField.enabled = !self.isCash;
        cell.dataModel = self.dataModel;
        cell.isCash = self.isCash;
        self.moneyField = cell.moneyField;
        self.moneyField.delegate = self;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Put"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Put"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (self.bankModel) {
            
            cell.textLabel.text = @"转出至";
            cell.textLabel.font = PISYS_FONT(15);
            cell.textLabel.textColor = txtSeconColor;
            
            cell.detailTextLabel.text = self.bankModel.bankName;
            cell.detailTextLabel.textColor = txtMainColor;
            cell.detailTextLabel.font = PISYS_FONT(18);
            cell.imageView.image = [UIImage imageNamed:self.bankModel.bank_logo];
            
        }else {
            
            cell.textLabel.text = @"请选择银行卡";
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        cell.imageView.image = [UIImage imageNamed:@"my_bank_tip"];
        cell.textLabel.text = @"预计一到三个工作日到账";
        cell.textLabel.textColor = txtSeconColor;
        cell.textLabel.font = PISYS_FONT(16);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 90;
    }else {
        
        if (indexPath.row == 0) {
            
            return 110;
        }else {
            
            return 50;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PIMyBankCardsController *cards = [PIMyBankCardsController new];
        cards.isPutForward = YES;
        weakself
        
        [cards setBankCardInfo:^(PIMyCardsDataModel *dataModel) {
            
            weakSelf.bankModel = dataModel;
            
            if (weakSelf.moneyField.text.floatValue > 0.00) {
                
                weakSelf.bottomBtn.enabled = YES;
            }else {
                
                weakSelf.bottomBtn.enabled = NO;
            }
            
            [weakSelf.tableView reloadData];
        }];

        [self.navigationController pushViewController:cards animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.text.floatValue <= [PILoginTool defaultTool].balance && textField.text.length > 0) {
        
        [MBProgressHUD showMessage:@"余额不足"];
    }
    
    if (textField.text.floatValue > 0.00 && self.bankModel && textField.text.floatValue <= [PILoginTool defaultTool].balance) {
        
        self.bottomBtn.enabled = YES;
        
    }else {
        
        self.bottomBtn.enabled = NO;
    }
}

- (void)textChange {
    
    CGFloat balance = [PILoginTool defaultTool].balance;
    
    if (self.moneyField.text.floatValue > balance) {
        
        [MBProgressHUD showMessage:@"余额不足"];
    }
}

- (void)dealloc {
    
    [PINotification removeObserver:self];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
