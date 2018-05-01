//
//  PIAddWisedomeCarCell.m
//  Parking
//
//  Created by apple on 2018/3/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddWisedomeCarCell.h"

@interface PIAddWisedomeCarCell ()

///-- 编号提示
@property (nonatomic, strong) UILabel *idTipLabel;
///-- 验证码提示
@property (nonatomic, strong) UILabel *codeTipLabel;
///-- 编号提示
@property (nonatomic, strong) UILabel *carTipLabel;
//-- 车位数
@property (nonatomic, strong) UILabel *numLabel;
///-- 编号
@property (nonatomic, strong) UILabel *idLabel;
///-- 验证码
@property (nonatomic, strong) UILabel *codeLabel;
///-- 备注
@property (nonatomic, strong) UITextField *remarkField;

@end

@implementation PIAddWisedomeCarCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.idTipLabel];
    [self.contentView addSubview:self.codeTipLabel];
    [self.contentView addSubview:self.carTipLabel];
    [self.contentView addSubview:self.idLabel];
    [self.contentView addSubview:self.codeLabel];
    [self.contentView addSubview:self.remarkField];
    
    CGFloat tipLabelW = 90;
    
    weakself
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.idTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.numLabel.mas_left);
        make.top.equalTo(weakSelf.numLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(tipLabelW);
    }];
    
    [self.codeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.numLabel.mas_left);
        make.top.equalTo(weakSelf.idTipLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(tipLabelW);
    }];
    
    [self.carTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.numLabel.mas_left);
        make.top.equalTo(weakSelf.codeTipLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(tipLabelW);
    }];
    

    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.idTipLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.centerY.equalTo(weakSelf.idTipLabel.mas_centerY);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.codeTipLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.centerY.equalTo(weakSelf.codeTipLabel.mas_centerY);
    }];
    
    [self.remarkField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.carTipLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.centerY.equalTo(weakSelf.carTipLabel.mas_centerY);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark -- 懒加载
- (UILabel *)numLabel {
    
    if (!_numLabel) {
        
        _numLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
        _numLabel.text = @"车位一";
        
    }
    
    return _numLabel;
}

- (UILabel *)idTipLabel {
    
    if (!_idTipLabel) {
        
        _idTipLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
        _idTipLabel.text = @"设备编号";
        
    }
    
    return _idTipLabel;
}

- (UILabel *)codeTipLabel {
    
    if (!_codeTipLabel) {
        
        _codeTipLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
        _codeTipLabel.text = @"设备验证码";
        
    }
    
    return _codeTipLabel;
}

- (UILabel *)carTipLabel {
    
    if (!_carTipLabel) {
        
        _carTipLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
        _carTipLabel.text = @"车位锁备注";
        
    }
    
    return _carTipLabel;
}
- (UILabel *)idLabel {
    
    if (!_idLabel) {
        
        _idLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
        _idLabel.text = @"YXXYXYXYY";
        
    }
    
    return _idLabel;
}

- (UILabel *)codeLabel {
    
    if (!_codeLabel) {
        
        _codeLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
        _codeLabel.text = @"yx23344";
    }
    
    return _codeLabel;
}

- (UITextField *)remarkField {
    
    if (!_remarkField) {
        
        _remarkField = [[UITextField alloc] init];
        _remarkField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _remarkField.layer.borderWidth = 1.0;
    }
    
    return _remarkField;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
