//
//  PIPersonAuthenController.m
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//  222222

#import "PIPersonAuthenController.h"
#import "PIBaseDetailCell.h"
#import "PIBaseFieldCell.h"
#import "PIBottomBtn.h"
#import "PIVillageAuthenProgressController.h"

@interface PIPersonAuthenController ()<UITableViewDelegate, UITableViewDataSource, PIBaseFieldCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
///-- 底部按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIPersonAuthenController
{
    
    NSString *_realName;
    NSString *_identityNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实名认证";
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.bottomBtn];
    
    CGFloat cellH = 80;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, 3 * cellH + 60) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = sepLineColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight = cellH;
    
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.size = CGSizeMake(SCREEN_WIDTH, 60);
    UILabel *label = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor text:@"请确认是您本人，验证完后不可修改"];
    label.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 20);
    [headerView addSubview:label];
    self.tableView.tableHeaderView = headerView;
    
    weakself
    CGFloat btnH = 50;
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view.mas_bottom).offset(-(150 * Scale_Y + TabBarHeight));
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(btnH);
        
    }];
    
    self.bottomBtn.layer.cornerRadius = btnH * 0.5;
    self.bottomBtn.clipsToBounds = YES;
    
    [self.bottomBtn addTarget:self action:@selector(comfir) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[PIBaseDetailCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseDetailCell class])];
    
    [self.tableView registerClass:[PIBaseFieldCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
}

- (void)comfir {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"realName"] = _realName;
    params[@"identityCard"] = _identityNum;
    
    [MBProgressHUD showIndeterWithMessage:@"正在提交..."];
    
    weakself
    [PIHttpTool piPost:urlPath(@"api/user/idCardAuth") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        if (model.code == 200) {
            
            [MBProgressHUD showMessage:@"认证成功！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                PIVillageAuthenProgressController *person = [PIVillageAuthenProgressController new];
                person.titleArr = @[@"真实姓名", @"身份证"];
                person.contentArr = @[_realName, [_identityNum stringByReplacingCharactersInRange:NSMakeRange(3, _identityNum.length - 7) withString:@"********"]];
                person.imageName = @"id_check";
                person.tipTitle = @"身份信息已通过认证";
                person.authTitle = @"身份认证";
                
                [weakSelf.navigationController pushViewController:person animated:YES];
                
            });
           
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"认证失败！"];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        PIBaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseDetailCell class])];
        
        cell.titleString = @"证件类型";
        cell.contentString = @"身份证";
        
        return cell;
    }
    
    PIBaseFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
    cell.pi_delegate = self;
    cell.index = indexPath.row;
    
    if (indexPath.row == 1) {
        
        cell.placeString = @"请填写真实姓名";
        cell.titleString = @"真实姓名";
        
    }else {
        
        cell.placeString = @"请填写证件号码";
        cell.titleString = @"证件号码";
    }
   
    
    return cell;
}

- (void)pi_textFieldEndEidting:(UITextField *)textField index:(NSInteger)index {
    
    if (index == 2) {
        
        _identityNum = textField.text;
    }else {
        
        _realName = textField.text;
    }
    
    if ([_identityNum validateIdentityCard] && _realName.length > 0) {
        
        NSLog(@"身份证号");
        self.bottomBtn.enabled = YES;
        self.bottomBtn.backgroundColor = PIMainColor;
        
    }else {
        
        _bottomBtn.enabled = NO;
        self.bottomBtn.backgroundColor = PIBtnEnableColor;
    }
}

- (PIBottomBtn *)bottomBtn {
    
    if (!_bottomBtn) {
        
        _bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"确定并提交"];
    
        [_bottomBtn setTitleColor:txtSeconColor forState:UIControlStateDisabled];
        _bottomBtn.enabled = NO;
        self.bottomBtn.backgroundColor = PIBtnEnableColor;
    }
    
    return _bottomBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
