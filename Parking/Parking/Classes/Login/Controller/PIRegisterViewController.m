//
//  PIRegisterViewController.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIRegisterViewController.h"
#import "PILoginFieldView.h"
#import "PIBottomBtn.h"
#import "PISetPassWViewController.h"
#import "PILoginManager.h"
#import "PIBaseModel.h"
#import "PIVerificationBtn.h"

@interface PIRegisterViewController ()

///-- 电话号码
@property (nonatomic, strong) PILoginFieldView *phoneView;
///-- 选中按钮
@property (nonatomic, strong) UIButton *selectBtn;
///-- 提示标签
@property (nonatomic, strong) UILabel *tipLabel;
///-- 协议按钮
@property (nonatomic, strong) UIButton *protolBtn;
///-- 下一步按钮
@property (nonatomic, strong) PIBottomBtn *nextBtn;
///-- 头部提示
@property (nonatomic, strong) UILabel *topLabel;
///-- 密码
@property (nonatomic, strong) PILoginFieldView *passWView;
///-- 底部按钮
@property (nonatomic, strong) UIButton *backBtn;
///-- 验证码按钮
@property (nonatomic, strong) PIVerificationBtn *verifiBtn;

@end

@implementation PIRegisterViewController
{
    NSString *_phoneNum;
    NSString *_phoneCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.selectBtn];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.protolBtn];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.passWView];
    [self.view addSubview:self.backBtn];
    
    weakself
    
    CGFloat btnH = 50;
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(100 * Scale_Y);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(36);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topLabel.mas_bottom).offset(40 * Scale_Y);
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.passWView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.phoneView.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(40);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.passWView.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf.passWView.mas_left).offset(btnBorderM);
        make.width.and.height.mas_equalTo(btnBorderM);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.selectBtn.mas_centerY);
        make.left.equalTo(weakSelf.selectBtn.mas_right).offset(5);
    }];
    
    [self.protolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.selectBtn.mas_centerY);
        make.left.equalTo(weakSelf.tipLabel.mas_right).offset(5);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(50);
        make.height.mas_equalTo(btnH);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(weakSelf.nextBtn.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(btnH);
        
    }];
    
    //-- 验证码按钮
    self.verifiBtn = [[PIVerificationBtn alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    
    self.passWView.textField.rightView = self.verifiBtn;
    self.passWView.textField.rightViewMode = UITextFieldViewModeAlways;
    
    [self.verifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verifiBtn setVerifClick:^{
    
            [weakSelf.verifiBtn startTimer];
            [weakSelf getVerifCode];
        }];
    
    self.nextBtn.layer.cornerRadius = btnH * 0.5;
    self.nextBtn.clipsToBounds = YES;
    self.backBtn.layer.cornerRadius = btnH * 0.5;
    self.backBtn.clipsToBounds = YES;
    
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.protolBtn addTarget:self action:@selector(protolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backBtn addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
}


- (void)getVerifCode {

    
    if (!self.selectBtn.isSelected) {
        
        [MBProgressHUD showMessage:@"请接受平台协议"];
        return;
    }
    
    if (self.phoneView.textField.text.cancelSpace.length == 0) {
        
        [MBProgressHUD showMessage:@"手机号不能为空"];
        return;
    }
    
    if (![self.phoneView.textField.text isPhoneNum]) {
        
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        
        return;
    }
    
    [MBProgressHUD showIndeterWithMessage:@"正在获取..."];
    _phoneNum = self.phoneView.textField.text;
    
    weakself
    [PILoginManager getVerificationCodeWithPhoneNum:self.phoneView.textField.text type:PICodeTypeRegistr success:^(id response) {
        
        
        [MBProgressHUD hideHUD];
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        if (model.code == 200) {
            [MBProgressHUD showMessage:@"验证码发送成功"];
            
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        
    } failue:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"获取失败"];
        
    }];
}


- (void)selectBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}

- (void)protolBtnClick:(UIButton *)sender {
    
    NSLog(@"协议");
}

- (void)backToLogin {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnClick:(UIButton *)sender {
    
//    if (!self.selectBtn.isSelected) {
//        
//        [MBProgressHUD showMessage:@"请接受平台协议"];
//        return;
//    }
//    
//    if (self.phoneView.textField.text.cancelSpace.length == 0) {
//        
//        [MBProgressHUD showMessage:@"手机号不能为空"];
//        return;
//    }
//    
//    if (![self.phoneView.textField.text isPhoneNum]) {
//        
//        [MBProgressHUD showMessage:@"请输入正确的手机号"];
//        
//        return;
//    }
//    
//    if (![self.phoneView.textField.text isEqualToString:_phoneNum]) {
//        
//        [MBProgressHUD showMessage:@"手机号有变化"];
//        
//        return;
//    }
//    
//    if (self.passWView.textField.text.cancelSpace.length != 6 || ![self.passWView.textField.text isNum]) {
//        
//        [MBProgressHUD showMessage:@"请输入正确的验证码"];
//        return;
//    }
    PISetPassWViewController *passWVC = [PISetPassWViewController new];
    passWVC.phoneNum = self.phoneView.textField.text;
    passWVC.verifCode = self.passWView.textField.text;
    
    [self.navigationController pushViewController:passWVC animated:YES];
}

- (UILabel *)topLabel {
    
    if (!_topLabel) {
        
        _topLabel = [[UILabel alloc] initWithFont:20 textColor:txtPlaceColor textAlignment:Center text:@"手机号注册"];
    }
    
    return _topLabel;
}
- (PILoginFieldView *)phoneView {
    
    if (!_phoneView) {
        
        _phoneView = [PILoginFieldView new];
        _phoneView.textField.keyboardType = UIKeyboardTypePhonePad;
        _phoneView.textField.placeholder = @"请输入手机号";
        _phoneView.rightImageName = @"login_delete";
        _phoneView.leftImageName = @"login_phone";
    }
    
    return _phoneView;
}

- (UIButton *)selectBtn {
    
    if (!_selectBtn) {
        
        _selectBtn = [UIButton new];
        _selectBtn.selected = YES;
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    }
    
    return _selectBtn;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:14 textColor:txtSeconColor text:@"我已阅读并接受"];
    }
    
    return _tipLabel;
}

- (UIButton *)protolBtn {
    
    if (!_protolBtn) {
        
        _protolBtn = [[UIButton alloc] initWithFont:14 titleColor:PIMainColor title:@"<<智慧停车协议>>"];
    }
    
    return _protolBtn;
}

- (PIBottomBtn *)nextBtn {
    
    if (!_nextBtn) {
        
        _nextBtn = [[PIBottomBtn alloc] initWithFont:15 titleColor:[UIColor whiteColor] title:@"下一步"];
    }
    
    return _nextBtn;
}

- (PILoginFieldView *)passWView {
    
    if (!_passWView) {
        
        _passWView = [PILoginFieldView new];
        _passWView.tag = 1;
        _passWView.textField.placeholder = @" 请输入验证码";
        //_passWView.textField.secureTextEntry = YES;
        _passWView.leftImageName = @"login_ver";
        
    }
    
    return _passWView;
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        
        _backBtn = [[UIButton alloc] initWithTitle:@"已有账号登录"];
        _backBtn.layer.borderColor = PIMainColor.CGColor;
        _backBtn.layer.borderWidth = 1.0;
        _backBtn.titleLabel.font = PIBigFont;
        [_backBtn setTitleColor:PIMainColor forState:UIControlStateNormal];
    }
    
    return _backBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
