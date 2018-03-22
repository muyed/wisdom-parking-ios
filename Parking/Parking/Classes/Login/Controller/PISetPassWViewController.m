//
//  PISetPassWViewController.m
//  Parking
//
//  Created by apple on 2018/2/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PISetPassWViewController.h"
#import "PILoginFieldView.h"
#import "PIVerificationBtn.h"
#import "PIBottomBtn.h"
#import "PILoginManager.h"
#import "PIBaseModel.h"
#import "PILoginViewController.h"

@interface PISetPassWViewController ()<UITextFieldDelegate>

///-- 昵称
@property (nonatomic, strong) PILoginFieldView *nickView;
///-- 验证码
@property (nonatomic, strong) PILoginFieldView *verifCodeView;
///-- 验证码按钮
@property (nonatomic, strong) PIVerificationBtn *verifiBtn;
///-- 密码
@property (nonatomic, strong) PILoginFieldView *passWView;
///-- 底部按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;
///-- 验证密码
@property (nonatomic, strong) PILoginFieldView *verPassWView;

@end

@implementation PISetPassWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置密码";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.nickView];
    //[self.view addSubview:self.verifCodeView];
    [self.view addSubview:self.passWView];
    [self.view addSubview:self.verPassWView];
    [self.view addSubview:self.bottomBtn];
    
    CGFloat borderM = 20;
    CGFloat fieldH = 40;
    weakself
    [self.nickView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(100 * Scale_Y);
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(fieldH);
        
    }];
 
//    [self.verifCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(weakSelf.nickView.mas_bottom).offset(10);
//        make.left.equalTo(weakSelf.view);
//        make.right.equalTo(weakSelf.view);
//        make.height.mas_equalTo(36);
//
//    }];
    [self.passWView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.nickView.mas_bottom).offset(btnBorderM);
        make.left.equalTo(weakSelf.nickView.mas_left);
        make.right.equalTo(weakSelf.nickView.mas_right);
        make.height.mas_equalTo(fieldH);
    }];
    
    [self.verPassWView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.passWView.mas_bottom).offset(btnBorderM);
        make.left.equalTo(weakSelf.nickView.mas_left);
        make.right.equalTo(weakSelf.nickView.mas_right);
        make.height.mas_equalTo(fieldH);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.verPassWView.mas_bottom).offset(3 * borderM);
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(50);
        
    }];
    
    self.bottomBtn.layer.cornerRadius = 5.0;
    self.bottomBtn.clipsToBounds = YES;
    
    [self.bottomBtn addTarget:self action:@selector(comfir)
             forControlEvents:UIControlEventTouchUpInside];
    
    self.verifiBtn = [[PIVerificationBtn alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    self.verifCodeView.textField.rightView = self.verifiBtn;
    self.verifCodeView.textField.rightViewMode = UITextFieldViewModeAlways;
    
    [self.verifiBtn startTimer];
    
    [self.verifiBtn setVerifClick:^{
        
        [weakSelf.verifiBtn startTimer];
        [weakSelf getVerifCode];
    }];
    
    [self.nickView.textField becomeFirstResponder];
}

- (void)comfir {
    
//    if (self.verifCodeView.textField.text.cancelSpace.length != 6) {
//
//        [MBProgressHUD showMessage:@"验证码错误"];
//        return;
//    }
    
    if (self.passWView.textField.text.cancelSpace.length == 0) {

        [MBProgressHUD showMessage:@"请输入密码"];
        return;
    }

    if (![self.passWView.textField.text.cancelSpace isEqualToString:self.verPassWView.textField.text.cancelSpace]) {
        
        [MBProgressHUD showMessage:@"请输入相同的密码"];
        return;
    }
    if (self.passWView.textField.text.cancelSpace.length < 6 || self.passWView.textField.text.cancelSpace.length > 20) {

        [MBProgressHUD showMessage:@"请设置6-20位密码"];
        return;
    }
    
    if (self.nickView.textField.text.cancelSpace.length == 0) {
        
        [MBProgressHUD showMessage:@"请设置昵称"];
        return;
    }
    
    if ([self.nickView.textField.text.cancelSpace isNum]) {
        
        [MBProgressHUD showMessage:@"用户名不能是纯数字"];
        return;
    }
    
    [MBProgressHUD showIndeterWithMessage:@"正在注册..."];
    weakself
    [PILoginManager registerCountWithPhoneNum:self.phoneNum phoneCode:self.verifCode userName:self.nickView.textField.text passWord:self.passWView.textField.text success:^(id response) {
        
         [MBProgressHUD hideHUD];
         PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            [MBProgressHUD showMessage:@"注册成功"];
            for (UIViewController *controller in weakSelf.navigationController.viewControllers) {
                
                if ([controller isKindOfClass:[PILoginViewController class]]) {
                    
                    PILoginViewController *login =(PILoginViewController *)controller;
                    [weakSelf.navigationController popToViewController:login animated:YES];
                }
            }
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
    } failue:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"注册失败"];
    }];
    
    
}

/*获取验证码*/
- (void)getVerifCode {
    
    [MBProgressHUD showIndeterWithMessage:@"正在发送..."];
    
    [PILoginManager getVerificationCodeWithPhoneNum:self.phoneNum type:PICodeTypeRegistr success:^(id response) {
        
        
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


#pragma mark --  UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.verifCodeView.textField.text.cancelSpace.length == 6 && [self.verifCodeView.textField isFirstResponder]) {
        
        [MBProgressHUD showMessage:@"验证码为6位数字"];
        return NO;
    }
    
    return YES;
}
#pragma mark --  懒加载

- (PILoginFieldView *)nickView {
    
    if (!_nickView) {
        
        _nickView = [PILoginFieldView new];
        _nickView.textField.placeholder = @"请输入昵称";
        _nickView.textField.delegate = self;
        _nickView.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nickView.leftImageName = @"login_user";
    }
    
    return _nickView;
}

- (PILoginFieldView *)verifCodeView {
    
    if (!_verifCodeView) {
        
        _verifCodeView = [PILoginFieldView new];
        _verifCodeView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _verifCodeView.textField.placeholder = @"请输入验证码";
        _verifCodeView.textField.delegate = self;
        
    }
    
    return _verifCodeView;
}

- (PILoginFieldView *)passWView {
    
    if (!_passWView) {
        
        _passWView = [PILoginFieldView new];
        _passWView.textField.placeholder = @"请设置6-20为密码";
        _passWView.textField.secureTextEntry = YES;
        _passWView.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWView.leftImageName = @"login_pass";
    }
    
    return _passWView;
}

- (PILoginFieldView *)verPassWView {
    
    if (!_verPassWView) {
        
        _verPassWView = [PILoginFieldView new];
        _verPassWView.textField.placeholder = @"请再次输入密码";
        _verPassWView.textField.secureTextEntry = YES;
        _verPassWView.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verPassWView.leftImageName = @"login_pass";
    }
    return _verPassWView;
}

- (PIBottomBtn *)bottomBtn {
    
    if (!_bottomBtn) {
        
        _bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"立即注册"];
    }
    
    return _bottomBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
