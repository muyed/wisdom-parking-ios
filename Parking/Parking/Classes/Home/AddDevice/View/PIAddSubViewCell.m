//
//  PIAddSubViewCell.m
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddSubViewCell.h"
#import "PILoginFieldView.h"
#import "PICodeViewController.h"

@interface PIAddSubViewCell ()

///-- 车位数
@property (nonatomic, strong) UILabel *numLabel;
///-- 编号
@property (nonatomic, strong) UILabel *idLabel;
///-- 验证码
@property (nonatomic, strong) UILabel *codeLabel;
///-- 编号输入框
@property (nonatomic, strong) PILoginFieldView *idFieldView;
///-- 验证码
@property (nonatomic, strong) PILoginFieldView *codeFieldView;
///-- 状态
@property (nonatomic, strong) UILabel *statuLabel;
///-- 删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation PIAddSubViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.idLabel];
    [self.contentView addSubview:self.idFieldView];
    [self.contentView addSubview:self.codeLabel];
    [self.contentView addSubview:self.codeFieldView];
    [self.contentView addSubview:self.statuLabel];
    
    weakself
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-75);
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.height.and.width.mas_equalTo(25);
    }];
    
    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.numLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.idLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(85);
    }];
    
    [self.idFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.idLabel.mas_right).offset(5);
        make.right.equalTo(weakSelf.contentView).offset(-10);
        make.bottom.equalTo(weakSelf.idLabel.mas_bottom).offset(-3);
        make.height.mas_equalTo(35);
    }];
    
    [self.codeFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.codeLabel.mas_right).offset(5);
        make.right.equalTo(weakSelf.contentView).offset(-10);
        make.bottom.equalTo(weakSelf.codeLabel.mas_bottom).offset(-3);
        make.height.mas_equalTo(35);
    }];
    
    [self.statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.codeFieldView.mas_bottom).offset(20);
    }];
    
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)swapClick:(UIButton *)sender {
    
    PICodeViewController *code = [[PICodeViewController alloc] init];
    code.errorString = @"请您扫描有效的二维码哦！";
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:code];
    
    
    code.codeBlock = ^(NSString *code) {
        //        self.codeView.textF.text = code;
        
    };
    [self.parentController presentViewController:nac animated:YES completion:nil];
}

- (void)deleteBtnClick {
    
    if (self.clickIndex) {
        
        self.clickIndex(self.index);
    }
}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    
    self.numLabel.text = [NSString stringWithFormat:@"车位 %lu", index];
    
    if (index == 1) {
        
        [self.deleteBtn setImage:[UIImage imageNamed:@"home_add_car"] forState:UIControlStateNormal];
        
    }else {
        
        [self.deleteBtn setImage:[UIImage imageNamed:@"home_delete"] forState:UIControlStateNormal];
    }
}
#pragma mark -- 懒加载
- (UILabel *)numLabel {
    
    if (!_numLabel) {
        
        _numLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
        
    }
    
    return _numLabel;
}

- (UILabel *)idLabel {
    
    if (!_idLabel) {
        
        _idLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor text:@"设备编号"];
    }
    
    return _idLabel;
}

- (UILabel *)codeLabel {
    
    if (!_codeLabel) {
        
        _codeLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor text:@"设备验证码"];
    }
    
    return _codeLabel;
}

- (PILoginFieldView *)idFieldView {
    
    if (!_idFieldView) {
        
        _idFieldView = [PILoginFieldView new];
        _idFieldView.tag = 0;
        
        UIButton *button = [[UIButton alloc] initWithImageName:@"home_swap"];
        button.size = CGSizeMake(25, 25);
        _idFieldView.textField.rightView = button;
        _idFieldView.textField.rightViewMode = UITextFieldViewModeAlways;
        button.tag = 0;
        [button addTarget:self action:@selector(swapClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _idFieldView;
}

- (PILoginFieldView *)codeFieldView {
    
    if (!_codeFieldView) {
        
        _codeFieldView = [PILoginFieldView new];
        _codeFieldView.tag = 1;
        
        UIButton *button = [[UIButton alloc] initWithImageName:@"home_swap"];
        button.size = CGSizeMake(25, 25);
        _codeFieldView.textField.rightView = button;
        _codeFieldView.textField.rightViewMode = UITextFieldViewModeAlways;
        button.tag = 0;
        [button addTarget:self action:@selector(swapClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _codeFieldView;
}

- (UIButton *)deleteBtn {
    
    if (!_deleteBtn) {
        
        _deleteBtn = [[UIButton alloc] initWithImageName:@"home_delete"];
    }
    
    return _deleteBtn;
}

- (UILabel *)statuLabel {
    
    if (!_statuLabel) {
        
        _statuLabel = [[UILabel alloc] initWithFont:15 textColor:txtRedColor];
        _statuLabel.text = @"此设备还未支付过设备押金";
    }
    
    return _statuLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
