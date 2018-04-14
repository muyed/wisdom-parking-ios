//
//  PIVillageAuthenProgressView.m
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageAuthenProgressView.h"


@interface PIVillageAuthenProgressView ()

/**
 提示
 */
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *sepView;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@end


@implementation PIVillageAuthenProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.tipImageView];
    [self addSubview:self.tipLabel];
    [self addSubview:self.sepView];
    [self addSubview:self.bottomLabel];
    [self addSubview:self.nameLabel];
    
    CGFloat iconWH = 80 * Scale_Y;
    weakself
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(25 * Scale_Y);
        make.width.and.height.mas_equalTo(iconWH);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.tipImageView.mas_bottom).offset(15 * Scale_Y);
        make.left.and.right.equalTo(weakSelf);
    }];
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(25 * Scale_Y);
        make.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.sepView.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf).offset(15);
        make.width.mas_equalTo(80);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.bottomLabel.mas_centerY);
        make.left.equalTo(weakSelf.bottomLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf).offset(-15);
    }];
    
}

- (void)setVillageName:(NSString *)villageName {
    
    _villageName = villageName;
    
    self.nameLabel.text = villageName;
    
}
- (UIImageView *)tipImageView {
    
    if (!_tipImageView) {
        
        _tipImageView = [[UIImageView alloc] init];
        
        _tipImageView.backgroundColor = [UIColor redColor];
    }
    
    return _tipImageView;
}

- (UIView *)sepView {
    
    if (!_sepView) {
        
        _sepView = [UIView new];
        _sepView.backgroundColor = sepLineColor;
    }
    
    return _sepView;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:18 textColor:txtSeconColor textAlignment:Center text:@"已提交申请，等待处理"];
        _tipLabel.font = [UIFont systemFontOfSize:18 weight:2];
    }
    
    return _tipLabel;
}

- (UILabel *)bottomLabel {
    
    if (!_bottomLabel) {
        
        _bottomLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor textAlignment:Center text:@"小区名字"];
    }
    
    return _bottomLabel;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor textAlignment:Right text:nil];
        _nameLabel.text = @"山水之间";
    }
    
    return _nameLabel;
}

@end
