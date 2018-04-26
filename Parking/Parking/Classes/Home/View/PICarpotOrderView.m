//
//  PICarpotOrderView.m
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarpotOrderView.h"
#import "PICarportAddressCell.h"
#import "PICarportBottomCell.h"
#import "PICarportTimeCell.h"

@interface PICarpotOrderView ()<UITableViewDelegate, UITableViewDataSource>

///-- <#Notes#>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PICarpotOrderView

static UIWindow *window_;

+ (instancetype)carportOrderView {
    
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, SCREEN_HEIGHT - TabBarHeight + 50, SCREEN_WIDTH, 330);
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    window_.hidden = NO;
    
    PICarpotOrderView *orderView = [[PICarpotOrderView alloc] init];
    
    orderView.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 320);
    orderView.backgroundColor = [UIColor whiteColor];
    [window_ addSubview:orderView];
    [orderView setupTableView];
    
    return orderView;
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 320) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = sepLineColor;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.tableView];
    
    [self.tableView registerClass:[PICarportAddressCell class] forCellReuseIdentifier:NSStringFromClass([PICarportAddressCell class])];
    
    [self.tableView registerClass:[PICarportTimeCell class] forCellReuseIdentifier:NSStringFromClass([PICarportTimeCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        PICarportAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PICarportAddressCell class])];
        
        return cell;
    }
    
    if (indexPath.row > 1) {
        
        PICarportBottomCell *cell = [PICarportBottomCell initWithTableView:tableView index:indexPath.row];
        
        return cell;
    }
    
    PICarportTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PICarportTimeCell class])];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 1) {
        
        return 70;
    }else {
        
        return 90;
    }
}

- (void)show {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        window_.y = SCREEN_HEIGHT- TabBarHeight + 50 - 330;
    }];
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        window_.y = SCREEN_HEIGHT;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismiss];
}
- (void)setLat:(CGFloat)lat {
    
    NSLog(@"%lf", lat);
}

@end
