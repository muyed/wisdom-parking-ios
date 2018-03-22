//
//  PIForgetViewController.m
//  Parking
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIForgetViewController.h"
#import "PILoginField.h"
#import "PIVerificationBtn.h"
#import "PIBottomBtn.h"

@interface PIForgetViewController ()

///-- 手机号输入框
@property (nonatomic, strong) PILoginField *phoneField;
///-- 验证码
@property (nonatomic, strong) PILoginField *codeField;
///-- 密码
@property (nonatomic, strong) PILoginField *passWField;
///-- 验证码
@property (nonatomic, strong) PIVerificationBtn *veriBtn;
///-- 底部按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.veriBtn];
    [self.view addSubview:self.passWField];
    [self.view addSubview:self.bottomBtn];
    
    weakself
    
    CGFloat borderM = 40;
    CGFloat fieldH = 50;
    CGFloat horM = 30 * Scale_Y;
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.top.equalTo(weakSelf.view).offset(NavBarHeight + 2 * horM);
        make.height.mas_equalTo(fieldH);
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.top.equalTo(weakSelf.phoneField.mas_bottom).offset(horM);
        make.height.mas_equalTo(fieldH);
        make.width.mas_equalTo(180 * Scale_Y);
    }];
    
    [self.veriBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.codeField.mas_right).offset(15);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.top.equalTo(weakSelf.codeField.mas_top);
        make.height.mas_equalTo(fieldH);
    }];
    
    [self.passWField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.top.equalTo(weakSelf.codeField.mas_bottom).offset(horM);
        make.height.mas_equalTo(fieldH);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.top.equalTo(weakSelf.passWField.mas_bottom).offset(2 * horM);
        make.height.mas_equalTo(60);
        
    }];
    
    self.bottomBtn.layer.cornerRadius = 60 * 0.5;
    self.bottomBtn.clipsToBounds = YES;
    [self.veriBtn setVerifClick:^{
        
        [weakSelf.veriBtn startTimer];
    
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    
}
#pragma mark -- 懒加载
- (PILoginField *)phoneField {
    
    if (!_phoneField) {
        
        _phoneField = [PILoginField new];
        _phoneField.placeholder = @"请输入手机号";
        _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _phoneField;
}

- (PILoginField *)codeField {
    
    if (!_codeField) {
        
        _codeField = [PILoginField new];
        _codeField.placeholder = @"请输入短信验证码";
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _codeField;
}

- (PILoginField *)passWField {
    
    if (!_passWField) {
        
        _passWField = [PILoginField new];
        _passWField.placeholder = @"请输入密码";
        _passWField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWField.secureTextEntry = YES;
        _passWField.keyboardType = UIKeyboardTypeDefault;
    }
    
    return _passWField;
}

- (PIVerificationBtn *)veriBtn {
    
    if (!_veriBtn) {
        
        _veriBtn = [PIVerificationBtn new];
        _veriBtn.layer.cornerRadius = 5.0;
        _veriBtn.clipsToBounds = YES;
        _veriBtn.backgroundColor = UIColorFromRGB(0xf25c49);
        [_veriBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }
    
    return _veriBtn;
}

- (PIBottomBtn *)bottomBtn {
    
    if (!_bottomBtn) {
        
        _bottomBtn = [[PIBottomBtn alloc] initWithFont:18 titleColor:[UIColor whiteColor] title:@"提交"];
        
    }
    
    return _bottomBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
