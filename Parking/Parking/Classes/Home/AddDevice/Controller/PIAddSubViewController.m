//
//  PIAddSubViewController.m
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddSubViewController.h"
#import "PIBottomBtn.h"
#import "PIAddSubViewCell.h"

@interface PIAddSubViewController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 底部按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIAddSubViewController
{
    
    NSInteger _count;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加设备";
    
    _count = 1;
    [self setupTableView];
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 49;
    self.tableView.rowHeight = 140;
    [self.view addSubview:self.tableView];
    
    self.bottomBtn = [[PIBottomBtn alloc] init];
    
    self.bottomBtn.x = 0;
    self.bottomBtn.y = CGRectGetMaxY(self.tableView.frame);
    self.bottomBtn.width = SCREEN_WIDTH;
    self.bottomBtn.height = 50;
    [self.bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomBtn];
    
    [self.tableView registerClass:[PIAddSubViewCell class] forCellReuseIdentifier:NSStringFromClass([PIAddSubViewCell class])];
    
}

- (void)buttonClick {
    
    NSLog(@"下一步");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIAddSubViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIAddSubViewCell class])];
    
    cell.index = indexPath.row + 1;
    
    weakself
    [cell setClickIndex:^(NSInteger index) {
       
        [weakSelf addBtnClick:index];
    }];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    view.backgroundColor = PIBackColor;
    UILabel *label = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"请扫描设备说明书中的二维码"];
    label.frame = CGRectMake(10, 10, SCREEN_WIDTH - 70, 29);
    [view addSubview:label];
    

    return view;
}

- (void)addBtnClick:(NSInteger)index {
    
    if (index == 1) {
        
        _count += 1;
    }else {
        
        _count -= 1;
    }
    
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
