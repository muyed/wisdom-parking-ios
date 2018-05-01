//
//  PIMyWalletController.m
//  Parking
//
//  Created by apple on 2018/5/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyWalletController.h"

@interface PIMyWalletController ()

///-- 导航
@property (nonatomic, weak) UIView *navView;

@end

@implementation PIMyWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}

- (void)setupUI {
    
    
}

- (void)setupNav {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    self.navView = nav;
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我的钱包";
    label.font = [UIFont boldSystemFontOfSize:18.0];
    CGFloat top = NavBarHeight - 34;
    label.frame = CGRectMake(0, top, SCREEN_WIDTH, 24);
    
    [nav addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
