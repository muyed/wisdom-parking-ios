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

@interface PIMyBankCardsController ()

@end

@implementation PIMyBankCardsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的银行卡";
    
    [self setupUI];
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
    
    [bindCard setBindSuccess:^{
        
        
    }];
    
    [self.navigationController pushViewController:bindCard animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIMyBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIMyBankCardCell class])];
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
