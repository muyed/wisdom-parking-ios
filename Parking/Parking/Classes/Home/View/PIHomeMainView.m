//
//  PIHomeMainView.m
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeMainView.h"
#import "PILoginFieldView.h"
#import "PIAddDeviceController.h"

@interface PIHomeMainView ()<UITextFieldDelegate>

///-- 添加按钮
@property (nonatomic, strong) UIButton *addBtn;
///-- 提示标签
@property (nonatomic, strong) UILabel *tipLabel;
///-- 提示
@property (nonatomic, strong) UILabel *orderCodeLabel;
///-- 输入预约码
@property (nonatomic, strong) PILoginFieldView *codeText;

@end

@implementation PIHomeMainView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.addBtn];
    [self addSubview:self.tipLabel];
    [self addSubview:self.orderCodeLabel];
    [self addSubview:self.codeText];
    
    CGFloat addBtnWH = 80 * Scale_Y;
    weakself
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.width.and.height.mas_equalTo(addBtnWH);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.addBtn.mas_bottom).offset(15 * Scale_Y);
        make.left.and.right.equalTo(weakSelf);
    }];
    
    [self.orderCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(25 * Scale_Y);
        make.left.and.right.equalTo(weakSelf);
    }];
    
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.orderCodeLabel.mas_bottom).offset(15 * Scale_Y);
        make.left.equalTo(weakSelf).offset(30);
        make.right.equalTo(weakSelf).offset(-30);
        make.height.mas_equalTo(35);
    }];
    
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBtnClick {
    
    PIAddDeviceController *addDevice = [PIAddDeviceController new];
    
    [self.parentController.navigationController pushViewController:addDevice animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -- 懒加载
- (UIButton *)addBtn {
    
    if (!_addBtn) {
        
        _addBtn = [[UIButton alloc] init];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"home_add"] forState:UIControlStateNormal];
    }
    
    return _addBtn;
    
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor textAlignment:Center text:@"点击添加智能车位及行人道闸"];
    }
    
    return _tipLabel;
}

- (UILabel *)orderCodeLabel {
    
    if (!_orderCodeLabel) {
        
        _orderCodeLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor textAlignment:Center text:@"如果您是访客，请输入预约码"];
    }
    
    return _orderCodeLabel;
}

- (PILoginFieldView *)codeText {
    
    if (!_codeText) {
        
        _codeText = [PILoginFieldView new];
        _codeText.textField.placeholder = @" 请输入预约码";
        _codeText.textField.keyboardType = UIKeyboardTypeDefault;
        _codeText.textField.returnKeyType = UIReturnKeyDone;
        _codeText.textField.delegate = self;
    }
    
    return _codeText;
}
@end
