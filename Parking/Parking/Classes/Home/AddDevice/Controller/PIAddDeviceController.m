//
//  PIAddDeviceController.m
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddDeviceController.h"
#import "PIBottomBtn.h"
#import "PIAddSubViewController.h"
#import "PIAddNoOwerController.h"

@interface PIAddDeviceController ()

///-- 车主
@property (nonatomic, strong) PIBottomBtn *owerBtn;
///-- 不是车主
@property (nonatomic, strong) PIBottomBtn *noOwerBtn;

@end

@implementation PIAddDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加设备";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.owerBtn];
    [self.view addSubview:self.noOwerBtn];
    
    weakself
    
    [self.owerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(80 + NavBarHeight);
        make.left.equalTo(weakSelf.view).offset(30);
        make.right.equalTo(weakSelf.view).offset(-30);
        make.height.mas_equalTo(49);
    }];
    
    [self.noOwerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.owerBtn.mas_bottom).offset(30);
        make.left.equalTo(weakSelf.view).offset(30);
        make.right.equalTo(weakSelf.view).offset(-30);
        make.height.mas_equalTo(49);
    }];

    [self.noOwerBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.owerBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag) {
        
        PIAddSubViewController *addSub = [PIAddSubViewController new];
        
        [self.navigationController pushViewController:addSub animated:YES];
        
    }else {
        
        PIAddNoOwerController *noOwer = [PIAddNoOwerController new];
        
        [self.navigationController pushViewController:noOwer animated:YES];
        
    }
}
#pragma mark -- 懒加载
- (PIBottomBtn *)owerBtn {
    
    if (!_owerBtn) {
        
        _owerBtn = [[PIBottomBtn alloc] initWithFont:17 titleColor:[UIColor whiteColor] title:@"我是车主"];
        _owerBtn.layer.cornerRadius = 10;
        _owerBtn.clipsToBounds = YES;
        _owerBtn.tag = 1;
    }
    
    return _owerBtn;
}

- (PIBottomBtn *)noOwerBtn {
    
    if (!_noOwerBtn) {
        
        _noOwerBtn = [[PIBottomBtn alloc] initWithFont:17 titleColor:[UIColor whiteColor] title:@"我不是车主"];
        _noOwerBtn.layer.cornerRadius = 10;
        _noOwerBtn.clipsToBounds = YES;
        _noOwerBtn.tag = 0;
    }
    
    return _noOwerBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
