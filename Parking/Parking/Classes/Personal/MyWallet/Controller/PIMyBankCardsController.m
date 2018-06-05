//
//  PIMyBankCardsController.m
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyBankCardsController.h"
#import "PIMyBankCardCell.h"
#import "PIBindBankCardController.h"
#import "PIMyCardsModel.h"

@interface PIMyBankCardsController ()

///-- 银行卡
@property (nonatomic, strong) PIMyCardsModel *model;

@end

@implementation PIMyBankCardsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的银行卡";
    
    [self setupUI];
    [self setupRefresh];
}

- (void)setupUI {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCard)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50)];
    self.tableView.rowHeight = 200;
    
    [self.tableView registerClass:[PIMyBankCardCell class] forCellReuseIdentifier:NSStringFromClass([PIMyBankCardCell class])];
    
}

- (void)addCard {
    
    
    PIBindBankCardController *bindCard = [PIBindBankCardController new];
    
    weakself
    [bindCard setBindSuccess:^{
        
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    
    [self.navigationController pushViewController:bindCard animated:YES];
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];
    
    weakself
    [PIHttpTool piGet:urlPath(@"api/bank/myList") params:nil success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        weakSelf.model = [PIMyCardsModel mj_objectWithKeyValues:response];
        
        if (weakSelf.model.code == 200) {
            
            [weakSelf.tableView reloadData];
        }else {
            
            [MBProgressHUD showMessage:weakSelf.model.errMsg];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"加载失败!"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIMyBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIMyBankCardCell class])];
    
    cell.dataModel = self.model.data[indexPath.row];
    
    weakself
    [cell setDeleteCard:^(PIMyCardsDataModel *dataModel) {
        
        [weakSelf deleteBankCardsWithBankID:dataModel];
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIMyCardsDataModel *dataModel = self.model.data[indexPath.row];
    
    if (self.isPutForward) {
        
        if (self.bankCardInfo) {
            
            self.bankCardInfo(dataModel);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*删除银行卡*/
- (void)deleteBankCardsWithBankID:(PIMyCardsDataModel*)bankModel {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/bank/del/"), bankModel.ID];
    
    [MBProgressHUD showIndeterWithMessage:@"正在解除..."];
    
    weakself
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            [MBProgressHUD showMessage:@"解除成功"];
            
            [weakSelf.model.data removeObject:bankModel];
            
            [weakSelf.tableView reloadData];
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
            
        }
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"解除失败"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
