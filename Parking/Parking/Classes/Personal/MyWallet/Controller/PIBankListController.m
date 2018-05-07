//
//  PIBankListController.m
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBankListController.h"
#import "PIBankModel.h"

@interface PIBankListController ()

///-- 数据源
@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation PIBankListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择银行";
    
    [self setupData];
    
    [self setupUI];
}

- (void)setupData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@".plist"];
    
    self.dataArr = [PIBankModel mj_objectArrayWithFile:path];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50)];
    self.tableView.rowHeight = 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIBankModel *model = self.dataArr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Bank"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Bank"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = model.bank_name;
    cell.imageView.image = [UIImage imageNamed:model.bank_logo];
    NSLog(@"%@", model.bank_logo);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIBankModel *model = self.dataArr[indexPath.row];
    
    if (self.bankInfo) {
        
        self.bankInfo(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
