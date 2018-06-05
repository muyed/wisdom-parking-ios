//
//  PIHomeAdsView.m
//  Parking
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeAdsView.h"

@interface PIHomeAdsView ()

///-- 广播
@property (nonatomic, strong) UIImageView *broadcastView;
///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 箭头
@property (nonatomic, strong) UIImageView *rowImageView;

@end

@implementation PIHomeAdsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.broadcastView];
    [self addSubview:self.tipLabel];
    [self addSubview:self.rowImageView];
    
    weakself
    
    [self.broadcastView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).offset(10);
        make.height.and.width.mas_equalTo(40);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.rowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).offset(-10);
        make.height.and.width.mas_equalTo(35);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.broadcastView.mas_right).offset(5);
        make.right.equalTo(weakSelf.rowImageView.mas_left).offset(5);
        make.centerY.equalTo(weakSelf);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToDetail)];
    
    [self addGestureRecognizer:tap];
}

- (void)pushToDetail {
    
    NSLog(@"--------------");
}


- (UIImageView *)broadcastView {
    
    if (!_broadcastView) {
        
        _broadcastView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_broadcast"]];
        
    }
    
    return _broadcastView;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
        _tipLabel.text = @"抢月卡，详情信息，戳此抢购";
        //_tipLabel.backgroundColor = [UIColor redColor];
    }
    
    return _tipLabel;
}

- (UIImageView *)rowImageView {
    
    if (!_rowImageView) {
        
        _rowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_right_row"]];
    }
    
    return _rowImageView;
}
@end
