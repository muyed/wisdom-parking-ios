//
//  PICountBalanceController.m
//  Parking
//
//  Created by apple on 2018/5/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICountBalanceController.h"
#import "PIPutForwardController.h"

@interface PICountBalanceController ()

///-- imageView
@property (nonatomic, strong) UIImageView *iconImage;
///-- 金额
@property (nonatomic, strong) UILabel *moneyLabel;
///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 提交按钮
@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation PICountBalanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户余额";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.iconImage];
    [self.view addSubview:self.moneyLabel];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.commitBtn];
    
    CGFloat iconWH = 100;
    
    weakself
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(120 * Scale_Y);
        make.centerX.equalTo(weakSelf.view);
        make.width.and.height.mas_equalTo(iconWH);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.iconImage.mas_bottom).offset(15 * Scale_Y);
        
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).offset(15 * Scale_Y);
        
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.top.equalTo(weakSelf.tipLabel).offset(80 * Scale_Y);
        make.height.mas_equalTo(50);
    }];
    
    [self.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commitBtnClick {
    
    PIPutForwardController *putForward = [PIPutForwardController new];
    
    [self.navigationController pushViewController:putForward animated:YES];
}

- (UIImageView *)iconImage {
    
    if (!_iconImage) {
        
        _iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"count_balance_tip"]];
    }
    
    return _iconImage;
}

- (UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = txtMainColor;
        _moneyLabel.font = [UIFont boldSystemFontOfSize:25];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.text = @"0.00";
    }
    
    return _moneyLabel;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor textAlignment:Center text:@"账户余额（元）"];
    }
    
    return _tipLabel;
}

- (UIButton *)commitBtn {
    
    if (!_commitBtn) {
        
        _commitBtn = [[UIButton alloc] initWithFont:17 titleColor:PIMainColor title:@"提现"];
        _commitBtn.layer.borderColor = PIMainColor.CGColor;
        _commitBtn.layer.borderWidth = 1.5;
        _commitBtn.layer.cornerRadius = 25;
        _commitBtn.clipsToBounds = YES;
    }
    
    return _commitBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
