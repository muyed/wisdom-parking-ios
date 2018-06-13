//
//  PIAcountCashHeaderView.m
//  Parking
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAcountCashHeaderView.h"
#import "PIPayForCashController.h"
#import "PIPutForwardController.h"

@interface PIAcountCashHeaderView ()

///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 交押金
@property (nonatomic, strong) UIButton *commitBtn;
///-- 状态
@property (nonatomic, strong) UIButton *statuesBtn;

@end

@implementation PIAcountCashHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
        [PINotification addObserver:self selector:@selector(deposit) name:PIPayForCashDeposit object:nil];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.tipLabel];
    [self addSubview:self.statuesBtn];
    [self addSubview:self.commitBtn];
    
    weakself
    
    CGFloat buttonW = 90;
    CGFloat buttonH = 35;
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).offset(15);
        make.centerY.equalTo(weakSelf).offset(-20);
    }];
    
    [self.statuesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.tipLabel.mas_left);
        make.centerY.equalTo(weakSelf).offset(15);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).offset(-15);
        make.centerY.equalTo(weakSelf);
        make.height.mas_equalTo(buttonH);
        make.width.mas_equalTo(buttonW);
    }];
    
    self.commitBtn.layer.cornerRadius = buttonH * 0.5;
    self.commitBtn.clipsToBounds = YES;
    
    
    [self deposit];
    
    [self.commitBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    if ([PILoginTool defaultTool].hasCash) {
        
    
        [PIAlertViewTool alertViewToolShowTitle:@"温馨提示" message:@"提取押金后，您将无法正常使用车位" cancelTitle:@"取消" confiormTitle:@"确定" fromController:self.parentController handler:^(NSInteger index) {
            
            if (index == 1) {
                
                PIPutForwardController *put = [PIPutForwardController new];
                
                put.isCash = YES;
                
                [self.parentController.navigationController pushViewController:put animated:YES];
                
            }
        }];
        
        
        
    }else {
        
        PIPayForCashController *pay = [PIPayForCashController new];
        pay.isCarportCash = NO;
        [self.parentController.navigationController pushViewController:pay animated:YES];
    }
}
//-- 根据押金判断
- (void)deposit {
    
    NSLog(@"-----------------");
    
    if ([PILoginTool defaultTool].hasCash) {
        
        [self.statuesBtn setTitle:@"已交" forState:UIControlStateNormal];
        [self.statuesBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.commitBtn setTitle:@"提取押金" forState:UIControlStateNormal];
        
    }else {
        
        [self.statuesBtn setImage:[UIImage imageNamed:@"cash_warm"] forState:UIControlStateNormal];
        [self.statuesBtn setTitle:@"未交" forState:UIControlStateNormal];
        [self.commitBtn setTitle:@"交押金" forState:UIControlStateNormal];
    }
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = txtMainColor;
        _tipLabel.font = [UIFont boldSystemFontOfSize:19];
        _tipLabel.text = @"押金";
    }
    
    return _tipLabel;
}

- (UIButton *)statuesBtn {
    
    if (!_statuesBtn) {
        
        _statuesBtn = [[UIButton alloc] init];
        _statuesBtn.titleLabel.font = PISYS_FONT(16);
        [_statuesBtn setTitleColor:txtSeconColor forState:UIControlStateNormal];
    }
    
    return _statuesBtn;
}

- (UIButton *)commitBtn {
    
    if (!_commitBtn) {
        
        _commitBtn = [[UIButton alloc] init];
        _commitBtn.titleLabel.font = PISYS_FONT(16);
        [_commitBtn setBackgroundColor:PIMainColor];
    }
    
    return _commitBtn;
}

- (void)dealloc {
    
    [PINotification removeObserver:self];
}
@end
