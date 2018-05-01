//
//  PICarsListController.m
//  Parking
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarsListController.h"
#import "PIAddCarController.h"
#import "PICarListModel.h"

@interface PICarsListController ()

///-- <#Notes#>
@property (nonatomic, strong) PICarListModel *model;
@end

@implementation PICarsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车牌管理";
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - NavBarHeight - 10)];
    
    self.tableView.rowHeight = 80;
    
    UIButton *leftImageBtn = [[UIButton alloc] initWithImageName:@"add_carlot" font:16 titleColor:PIMainColor title:@"添加车牌"];
    
    leftImageBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 60);
    [leftImageBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [leftImageBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:leftImageBtn];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    
    weakself
    [MBProgressHUD showIndeterWithMessage:@"正在加载"];
    
    [PIHttpTool piGet:urlPath(@"api/carLicense/myCarLicense") params:nil success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        weakSelf.model = [PICarListModel mj_objectWithKeyValues:response];
        
        if (weakSelf.model.code == 200) {
            
            [weakSelf.tableView reloadData];
        }else {
            
            [MBProgressHUD showMessage:weakSelf.model.errMsg];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        [MBProgressHUD showMessage:@"加载失败!"];
    }];
}
- (void)buttonClick {
    
    PIAddCarController *addCar = [PIAddCarController new];
    
    [self.navigationController pushViewController:addCar animated:YES];
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCar"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCar"];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:19 weight:1.5];
    
    cell.textLabel.text = self.model.data[indexPath.row].license;
    
//    if (indexPath.section == 0) {
//
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        cell.textLabel.font = [UIFont systemFontOfSize:18 weight:2];
//    }else {
//
//        cell.textLabel.text = @"请输入其他车牌号";
//
//    }
    return cell;
}

/**删除车牌*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return !self.isMatch;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self deleteCarLenceWithIndex:indexPath];
    }];
    
    return @[deleteAction];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isMatch) {
        
        if (self.carNum) {
            
            self.carNum(self.model.data[indexPath.row].license);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
   
    
}

- (void)deleteCarLenceWithIndex:(NSIndexPath *)indexPath {
    
    NSString *licenseId = self.model.data[indexPath.row].ID;
    NSString *url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/carLicense/del/"),licenseId];
    
    [MBProgressHUD showIndeterWithMessage:@"正在删除"];
    
    weakself
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIBaseModel *baseModel = [PIBaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code == 200) {
            
            [MBProgressHUD showMessage:@"删除成功"];
            [weakSelf.model.data removeObjectAtIndex:indexPath.row];
            
            [weakSelf.tableView reloadData];
        }else {
            
            [MBProgressHUD showMessage:baseModel.errMsg];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showMessage:@"删除失败"];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
