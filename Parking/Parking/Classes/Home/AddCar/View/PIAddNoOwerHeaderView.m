//
//  PIAddNoOwerHeaderView.m
//  Parking
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddNoOwerHeaderView.h"

@interface PIAddNoOwerHeaderView ()

///-- 提示
@property (nonatomic, strong) UILabel *nameLabel;
///-- 姓名
@property (nonatomic, strong) UITextField *nameField;
///-- 提示image
@property (nonatomic, strong) UIImageView *tipImageView;
///-- 填写姓名提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 小区名称
@property (nonatomic, strong) UILabel *villageLabel;
///-- 小区名
@property (nonatomic, strong) UITextField *villageField;
///-- 详细地址
@property (nonatomic, strong) UILabel *detailAdd;
///-- 栋
@property (nonatomic, strong) UITextField *dongField;
///-- 栋提示
@property (nonatomic, strong) UILabel *dongLabel;
///-- 室
@property (nonatomic, strong) UITextField *roomField;
///-- 室提示
@property (nonatomic, strong) UILabel *roomLabel;

@end

@implementation PIAddNoOwerHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = txtPlaceColor;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameField];
    [self addSubview:self.tipImageView];
    [self addSubview:bottomLine];
    [self addSubview:self.tipLabel];
    [self addSubview:self.villageLabel];
    [self addSubview:self.villageField];
    [self addSubview:self.detailAdd];
    [self addSubview:self.dongField];
    [self addSubview:self.dongLabel];
    [self addSubview:self.roomField];
    [self addSubview:self.roomLabel];
    
    weakself
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).offset(15);
        make.top.equalTo(weakSelf).offset(25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(26);
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).offset(-15);
        make.top.equalTo(weakSelf.nameLabel.mas_top);
        make.height.and.width.mas_equalTo(25);
        
    }];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(5);
        make.right.equalTo(weakSelf.tipImageView.mas_left).offset(-10);
        make.bottom.equalTo(weakSelf.nameLabel.mas_bottom).offset(1);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.nameField.mas_left);
        make.right.equalTo(weakSelf.tipImageView.mas_right);
        make.bottom.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-20);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(20);
    }];
    
    [self.villageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.nameLabel.mas_left);
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(26);
    }];
    
    [self.villageField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomLine.mas_left);
        make.right.equalTo(bottomLine.mas_right);
        make.centerY.equalTo(weakSelf.villageLabel.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    [self.detailAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.nameLabel.mas_left);
        make.top.equalTo(weakSelf.villageField.mas_bottom).offset(25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(26);
    }];
    
    [self.dongField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.detailAdd.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.detailAdd.mas_centerY);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    [self.dongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.dongField.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.dongField.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
    [self.roomField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.dongLabel.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.dongLabel.mas_centerY);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.roomField.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.dongField.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
}

#pragma mark -- 懒加载
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"真实姓名"];
    }
    
    return _nameLabel;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:16 textColor:txtRedColor textAlignment:Center text:@"为保证用户安全，添加设备必须完成实名认证"];
    }
    
    return _tipLabel;
}

- (UITextField *)nameField {
    
    if (!_nameField) {
        
        _nameField = [[UITextField alloc] init];
        
    }
    
    return _nameField;
}

- (UIImageView *)tipImageView {
    
    if (!_tipImageView) {
        
        _tipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select"]];
    }
    
    return _tipImageView;
}

- (UILabel *)villageLabel {
    
    if (!_villageLabel) {
        
        _villageLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"小区名称"];
    }
    
    return _villageLabel;
}

- (UITextField *)villageField {
    
    if (!_villageField) {
        
        _villageField = [[UITextField alloc] init];
       // _villageField.borderStyle = UITextBorderStyleLine;
        _villageField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _villageField.layer.borderWidth = 1.0;
        _villageField.layer.cornerRadius = 22.5;
        _villageField.clipsToBounds = YES;
        _villageField.font = PISYS_FONT(16);
        UIButton * button = [[UIButton alloc] initWithImageName:@"home_search"];
        button.size = CGSizeMake(40, 40);
        _villageField.leftView = button;
        _villageField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return _villageField;
}

- (UILabel *)detailAdd {
    
    if (!_detailAdd) {
        
        _detailAdd = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"详细地址"];
    }
    
    return _detailAdd;
}

- (UITextField *)dongField {
    
    if (!_dongField) {
        
        _dongField = [[UITextField alloc] init];
        _dongField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _dongField.layer.borderWidth = 1.0;
    }
    
    return _dongField;
}

- (UILabel *)dongLabel {
    
    if (!_dongLabel) {
        
        _dongLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"栋"];
    }
    
    return _dongLabel;
}

- (UITextField *)roomField {
    
    if (!_roomField) {
        
        _roomField = [[UITextField alloc] init];
        _roomField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _roomField.layer.borderWidth = 1.0;
    }
    
    return _roomField;
}

- (UILabel *)roomLabel{
    
    if (!_roomLabel) {
        
        _roomLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"室"];
    }
    
    return _roomLabel;
}
@end
