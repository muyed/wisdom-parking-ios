//
//  PIVillageAuthenController.m
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageAuthenController.h"
#import "PIBaseDetailCell.h"
#import "PIBaseFieldCell.h"
#import "PIBottomBtn.h"
#import "PIVillageAuthenProgressController.h"
#import "PIVillageListController.h"
#import "PIVillageListModel.h"

@interface PIVillageAuthenController ()<UITableViewDelegate, UITableViewDataSource, PIBaseFieldCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
///-- 底部按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;
/**
 标题
 */
@property (nonatomic, strong) NSArray *titleArr;

/**
 内容
 */
@property (nonatomic, strong) NSArray *contentArr;

@property (nonatomic, strong) PIVillageDataModel *villageModel;

@end

@implementation PIVillageAuthenController
{
    
    NSString *_floorNo;
    NSString *_unitNo;
    NSString *_houseNo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小区认证";
    self.titleArr = @[@"小区地址", @"楼号", @"单元号", @"门牌号"];
    self.contentArr = @[@"请选择小区",@"请输入楼号",@"请输入单元号",@"请输入门牌号"];
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.bottomBtn];
    
    CGFloat cellH = 80;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, 5 * cellH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = sepLineColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight = cellH;
    
    [self.view addSubview:self.tableView];
    
    
    weakself
    CGFloat btnH = 50;
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view.mas_bottom).offset(-(100 * Scale_Y + TabBarHeight));
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
    
    
    
    if (self.villageModel == nil) {
        
        [MBProgressHUD showMessage:@"请输入选择小区"];
        
        return;
    }
    
    if (_floorNo.length == 0) {
        
        [MBProgressHUD showMessage:@"请输入楼号"];
        
        return;
    }
    
    if (_unitNo.length == 0) {
        
        [MBProgressHUD showMessage:@"请输入单元号"];
        
        return;
    }
    
    if (_houseNo.length == 0) {
        
        [MBProgressHUD showMessage:@"请输入门牌号"];
        
        return;
    }
    
   
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"communityId"] = self.villageModel.ID;
    params[@"floorNo"] = _floorNo;
    params[@"unitNo"] = _unitNo;
    params[@"houseNo"] = _houseNo;
    
    [MBProgressHUD showIndeterWithMessage:@"正在提交..."];

    weakself
    [PIHttpTool piPost:urlPath(@"api/community/user/auth") params:params success:^(id response) {

        [MBProgressHUD hideHUD];

        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            PIVillageAuthenProgressController *authen = [PIVillageAuthenProgressController new];
            authen.villageName = weakSelf.villageModel.communityName;
            [weakSelf.navigationController pushViewController:authen animated:YES];
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
            
        }

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"提交失败"];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        PIBaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseDetailCell class])];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleString = self.titleArr[indexPath.row];
        
        if (self.villageModel) {
            
            cell.contentString = self.villageModel.communityName;
            cell.contentColor = txtMainColor;
        }else {
            
            cell.contentString = self.contentArr[indexPath.row];
            cell.contentColor = txtPlaceColor;
        }
       
        
        return cell;
    }
    
    PIBaseFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
    cell.pi_delegate = self;
    cell.index = indexPath.row;
    
    cell.placeString = self.contentArr[indexPath.row];
    cell.titleString = self.titleArr[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        PIVillageListController *list = [PIVillageListController new];
        
        weakself
        [list setVillageID:^(PIVillageDataModel *villageModel) {
            
            weakSelf.villageModel = villageModel;
            
            [weakSelf.tableView reloadData];
        }];
        
        [self.navigationController pushViewController:list animated:YES];
    }
}

- (void)pi_textFieldEndEidting:(UITextField *)textField index:(NSInteger)index {
    
    if (index == 1) {
        
        _floorNo = textField.text;
        
    }else if (index == 2) {
        
        _unitNo = textField.text;
    }else {
        
        _houseNo = textField.text;
    }
    
}

- (PIBottomBtn *)bottomBtn {
    
    if (!_bottomBtn) {
        
        _bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"确定并提交"];
        
        [_bottomBtn setTitleColor:txtSeconColor forState:UIControlStateDisabled];
//        _bottomBtn.enabled = NO;
//        self.bottomBtn.backgroundColor = PIBtnEnableColor;
    }
    
    return _bottomBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
