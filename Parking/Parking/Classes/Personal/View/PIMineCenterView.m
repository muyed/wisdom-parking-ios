//
//  PIMineCenterView.m
//  Parking
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMineCenterView.h"
#import "PILeftImageBtn.h"

@interface PIMineCenterView ()

///-- 上边的View
@property (nonatomic, strong) UIView *topView;
///-- 顶部image
@property (nonatomic, strong) UIImageView *topImageView;
///-- 箭头
@property (nonatomic, strong) UIImageView *rowImageView;
///-- 分割线
@property (nonatomic, strong) UIView *sepView;
///-- 钱包
@property (nonatomic, strong) UILabel *walletLabel;
///-- 押金
@property (nonatomic, strong) PILeftImageBtn *depBtn;
///-- 季度卡
@property (nonatomic, strong) PILeftImageBtn *quarterBtn;
///-- 月卡
@property (nonatomic, strong) PILeftImageBtn *monthBtn;

@end

@implementation PIMineCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.topView];
    [self addSubview:self.sepView];
    [self.topView addSubview:self.topImageView];
    [self.topView addSubview:self.rowImageView];
    [self.topView addSubview:self.walletLabel];
    [self addSubview:self.depBtn];
    [self addSubview:self.quarterBtn];
    [self addSubview:self.monthBtn];
    
    weakself
    
    CGFloat buttonW = (SCREEN_WIDTH - 40 * Scale_Y)/ 3;
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(weakSelf);
        make.height.mas_equalTo(70 * Scale_Y);
        
    }];
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-20);
        make.top.equalTo(weakSelf.topView.mas_bottom);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.topView).offset(15);
        make.centerY.equalTo(weakSelf.topView);
        make.width.and.height.mas_equalTo(30);
    }];
    
    [self.rowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.topView).offset(-15);
        make.centerY.equalTo(weakSelf.topView);
        make.width.and.height.mas_equalTo(40);
    }];
    
    [self.walletLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.topImageView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.topView);
        make.width.mas_equalTo(100);
    }];
    
    [self.depBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf.sepView.mas_bottom);
        make.width.mas_equalTo(buttonW);
    }];
    
    [self.monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.and.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf.sepView.mas_bottom);
        make.width.mas_equalTo(buttonW);
    }];

    [self.quarterBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.depBtn.mas_right);
        make.top.equalTo(weakSelf.sepView.mas_bottom);
        make.bottom.equalTo(weakSelf);
        make.width.mas_equalTo(buttonW);
    }];
}

- (UIView *)topView {
    
    if (!_topView) {
        
        _topView = [UIView new];
    }
    
    return _topView;
}

- (UIView *)sepView {
    
    if (!_sepView) {
        
        _sepView = [UIView new];
        _sepView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _sepView;
}

- (UIImageView *)topImageView {
    
    if (!_topImageView) {
        
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_money"]];
    }
    
    return _topImageView;
}

- (UIImageView *)rowImageView {
    
    if (!_rowImageView) {
        
        _rowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_right_row"]];
    }
    
    return _rowImageView;
}

- (UILabel *)walletLabel {
    
    if (!_walletLabel) {
        
        _walletLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"钱包"];
    }
    
    return _walletLabel;
}

- (PILeftImageBtn *)depBtn {
    
    if (!_depBtn) {
        
        _depBtn = [PILeftImageBtn new];
        [_depBtn setTitle:@"押金" forState:UIControlStateNormal];
        _depBtn.titleLabel.font = PISYS_FONT(15);
        [_depBtn setImage:[UIImage imageNamed:@"mine_dep"] forState:UIControlStateNormal];
        
        //_depBtn.backgroundColor = [UIColor redColor];
    }
    
    return _depBtn;
}

- (PILeftImageBtn *)quarterBtn {
    
    if (!_quarterBtn) {
        
        _quarterBtn = [PILeftImageBtn new];
        [_quarterBtn setTitle:@"季度卡" forState:UIControlStateNormal];
        _quarterBtn.titleLabel.font = PISYS_FONT(15);
        [_quarterBtn setImage:[UIImage imageNamed:@"mine_quarter"] forState:UIControlStateNormal];
        
    }
    
    return _quarterBtn;
}

- (PILeftImageBtn *)monthBtn {
    
    if (!_monthBtn) {
        
        _monthBtn = [PILeftImageBtn new];
        [_monthBtn setTitle:@"月卡" forState:UIControlStateNormal];
        _monthBtn.titleLabel.font = PISYS_FONT(15);
        [_monthBtn setImage:[UIImage imageNamed:@"mine_month"] forState:UIControlStateNormal];
        
    }
    
    return _monthBtn;
}
@end
