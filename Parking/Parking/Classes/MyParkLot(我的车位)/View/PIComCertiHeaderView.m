//
//  PIComCertiHeaderView.m
//  Parking
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIComCertiHeaderView.h"

@interface PIComCertiHeaderView ()

///-- 车位锁
@property (nonatomic, strong) UIButton *tipBtn;
///-- 内容
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation PIComCertiHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = PIMainColor;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.tipBtn];
    [self addSubview:self.contentLabel];
    
    
    weakself
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf).offset(30 * Scale_Y);
        make.left.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.tipBtn.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
    }];
}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    
     [_tipBtn setTitle:[NSString stringWithFormat:@"车位锁 %lu", index] forState:UIControlStateNormal];
}

- (void)setLockName:(NSString *)lockName {
    
    _lockName = lockName;
    self.contentLabel.text = lockName.length == 0 ? @"我的车锁" : lockName;
}
- (UIButton *)tipBtn {
    
    if (!_tipBtn) {
        
        _tipBtn = [[UIButton alloc] init];
        [_tipBtn setTitle:@"车位锁一" forState:UIControlStateNormal];
        [_tipBtn setTitleColor:UIColorFromRGB(0xe6e6e6) forState:UIControlStateNormal];
        [_tipBtn setImage:[UIImage imageNamed:@"com_lock"] forState:UIControlStateNormal];
        _tipBtn.titleLabel.font = PISYS_FONT(16);
        _tipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30 * Scale_X);
        _tipBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 140 * Scale_X, 0, 0);
        _tipBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    
    return _tipBtn;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] initWithFont:20 textColor:[UIColor whiteColor] textAlignment:Center text:@"备注的名称"];
    }
    
    return _contentLabel;
}
@end
