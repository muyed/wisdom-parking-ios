//
//  PILoginViewController.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILoginViewController.h"
#import "PILoginFieldView.h"
#import "PIRegisterViewController.h"
#import "PIBottomBtn.h"
#import "PIThirdLoginView.h"
#import "PIVerificationBtn.h"
#import "PILoginManager.h"
#import "PIBaseModel.h"
#import "PIHomeViewController.h"
#import "PINavigationController.h"
#import "PIForgetViewController.h"

@interface PILoginViewController ()

///-- <#Notes#>
@property (nonatomic, strong) UIImageView *topImageView;
///-- 手机号
@property (nonatomic, strong) PILoginFieldView *phoneView;
///-- 密码
@property (nonatomic, strong) PILoginFieldView *passWView;
///-- 底部按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;
///-- 底部按钮
@property (nonatomic, strong) UIButton *rigestBtn;
///-- 忘记密码
@property (nonatomic, strong) UIButton *forgetPassWBtn;
///-- 验证码登录
@property (nonatomic, strong) UIButton *codeLoginBtn;
///-- 验证码按钮
@property (nonatomic, strong) PIVerificationBtn *verifiBtn;
///-- 是否为密码登录
@property (nonatomic, assign) BOOL isPassWLogin;

@end

@implementation PILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    self.isPassWLogin = NO;
    [self setupUI];
    [self setupNav];
}

- (void)setupUI {
    
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.passWView];
    //[self.view addSubview:self.codeLoginBtn];
    [self.view addSubview:self.bottomBtn];
   // [self.view addSubview:self.forgetPassWBtn];
    [self.view addSubview:self.rigestBtn];
    
    weakself
    
    CGFloat topWH = 80;
    CGFloat btnH = 50;
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(100 * Scale_Y);
        make.centerX.equalTo(weakSelf.view);
        make.height.and.width.mas_equalTo(topWH);
        
    }];
    
    self.topImageView.layer.cornerRadius = topWH * 0.5;
    self.topImageView.clipsToBounds = YES;
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topImageView.mas_bottom).offset(40 * Scale_Y);
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
    
//    [self.codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(weakSelf.passWView.mas_bottom).offset(60 * Scale_Y);
//        make.left.equalTo(weakSelf.view).offset(25);
//        make.right.equalTo(weakSelf.view).offset(-25);
//        make.height.mas_equalTo(44);
//    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.passWView.mas_bottom).offset(40 * Scale_Y);
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(btnH);
        
    }];
    
    [self.rigestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(weakSelf.bottomBtn.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf.view).offset(btnBorderM);
        make.right.equalTo(weakSelf.view).offset(-btnBorderM);
        make.height.mas_equalTo(btnH);
        
    }];
    
    
    
//    [self.forgetPassWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(weakSelf.bottomBtn.mas_bottom).offset(10 * Scale_Y);
//        make.right.equalTo(weakSelf.bottomBtn.mas_right);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(80);
//    }];
    
    //-- 验证码按钮
//    self.verifiBtn = [[PIVerificationBtn alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//
//    self.passWView.textField.rightView = self.verifiBtn;
//
//
//    [self.verifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [self.verifiBtn setVerifClick:^{
//
//        [weakSelf.verifiBtn startTimer];
//        [weakSelf getVerifCode];
//    }];
    
    
    self.forgetPassWBtn.frame = CGRectMake(0, 0, 80, 30);
    self.passWView.textField.rightView = self.forgetPassWBtn;
    self.passWView.textField.rightViewMode = UITextFieldViewModeAlways;
    [self.forgetPassWBtn addTarget:self action:@selector(forgetPassW) forControlEvents:UIControlEventTouchUpInside];
    
    
//    PIThirdLoginView *thirdView = [PIThirdLoginView new];
//    CGFloat thirdViewH = SCREEN_WIDTH / 3 - 20 * Scale_X;
//    thirdView.frame = CGRectMake(0, SCREEN_HEIGHT - thirdViewH - 100 * Scale_X, SCREEN_WIDTH, thirdViewH);
//    [self.view addSubview:thirdView];
    
    self.bottomBtn.layer.cornerRadius = btnH * 0.5;
    self.bottomBtn.clipsToBounds = YES;
    self.rigestBtn.layer.cornerRadius = btnH * 0.5;
    self.rigestBtn.clipsToBounds = YES;
    
    [self.codeLoginBtn addTarget:self action:@selector(codeLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rigestBtn addTarget:self action:@selector(pushToRgister) forControlEvents:UIControlEventTouchUpInside];
    
   
}

- (void)setupNav {
    
//    UIBarButtonItem *right = [UIBarButtonItem itemWithTitle:@"注册" target:self action:@selector(pushToRgister) type:PIBarButtonItemRight];
//    self.navigationItem.rightBarButtonItem = right;
}

- (void)pushToRgister {
    
    PIRegisterViewController *registerVC = [PIRegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)login {
    
    if (self.isPassWLogin) {
        
        if (![self.phoneView.textField.text isPhoneNum]) {
            
            [MBProgressHUD showMessage:@"请输入正确的手机号"];
            return;
        }
        
        if (self.passWView.textField.text.cancelSpace.length != 6) {
            
            [MBProgressHUD showMessage:@"请输入6位验证码"];
            return;
        }
        
        
        
    }else {
        
        if (self.phoneView.textField.text.cancelSpace.length == 0) {
            
            [MBProgressHUD showMessage:@"请输入用户名"];
            return;
        }
        
        if (self.passWView.textField.text.cancelSpace.length < 6 || self.passWView.textField.text.cancelSpace.length > 20) {
            
            [MBProgressHUD showMessage:@"密码长度为6-20位"];
            return;
        }
        
       
        
        if ([self.phoneView.textField.text.cancelSpace isNum]) {
            
            [MBProgressHUD showMessage:@"用户名不能是纯数字"];
            return;
        }
    }
    
    [MBProgressHUD showIndeterWithMessage:@"正在登录..."];
    
    [PILoginManager loginWithCount:self.phoneView.textField.text.cancelSpace code:self.passWView.textField.text.cancelSpace type:self.isPassWLogin countType:@1 success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        if (model.code == 200) {
            
            [MBProgressHUD showMessage:@"登录成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    BOOL oldState = [UIView areAnimationsEnabled];
                    [UIView setAnimationsEnabled:NO];
                    
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    
                    PINavigationController  *nav = [[PINavigationController alloc] initWithRootViewController:[[PIHomeViewController alloc] init]];
                    //重新设置窗口的根视图
                    window.rootViewController = nav;
                    
                    [UIView setAnimationsEnabled:oldState];
                } completion:^(BOOL finished) {
                }];
                
            });
           
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        
    } failue:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"登录失败"];
    }];
}

- (void)getVerifCode {
    
    if (![self.phoneView.textField.text isPhoneNum]) {
        
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    
    [MBProgressHUD showIndeterWithMessage:@"正在发送..."];
    
    [PILoginManager getVerificationCodeWithPhoneNum:self.phoneView.textField.text type:PICodeTypeLogin success:^(id response) {
        
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
- (void)forgetPassW {
    
    PIForgetViewController *forget = [PIForgetViewController new];
    
    [self.navigationController pushViewController:forget animated:YES];
}

- (void)codeLoginBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.isPassWLogin = sender.selected;
    
    [self.phoneView.textField resignFirstResponder];
    [self.passWView.textField resignFirstResponder];
    
    if (sender.selected) {
        
        self.passWView.textField.rightViewMode = UITextFieldViewModeAlways;
        self.phoneView.textField.placeholder = @" 请输入手机号";
        self.passWView.textField.placeholder = @" 请输入验证码";
        self.phoneView.textField.keyboardType = UIKeyboardTypePhonePad;
        self.passWView.textField.keyboardType = UIKeyboardTypePhonePad;
        
        if (![self.phoneView.textField.text.cancelSpace isPhoneNum]) {
            
            self.phoneView.textField.text = nil;
        }
        self.passWView.textField.secureTextEntry = NO;
        self.passWView.textField.text = nil;
        
    }else {
        
        self.phoneView.textField.keyboardType = UIKeyboardTypeDefault;
        self.passWView.textField.keyboardType = UIKeyboardTypeDefault;
        self.passWView.textField.rightViewMode = UITextFieldViewModeNever;
        self.phoneView.textField.placeholder = @" 请输入用户名";
        self.passWView.textField.placeholder = @" 请输入密码";
        self.passWView.textField.secureTextEntry = YES;
        
    }
    [self.phoneView.textField becomeFirstResponder];
    
}

#pragma mark -- 懒加载
- (PILoginFieldView *)phoneView {
    
    if (!_phoneView) {
        
        _phoneView = [PILoginFieldView new];
        _phoneView.tag = 0;
        _phoneView.textField.placeholder = @" 请输入用户名";
        _phoneView.textField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneView.rightImageName = @"login_delete";
        _phoneView.leftImageName = @"login_user";
    }
    
    return _phoneView;
}

- (PILoginFieldView *)passWView {
    
    if (!_passWView) {
        
        _passWView = [PILoginFieldView new];
        _passWView.tag = 1;
        _passWView.textField.placeholder = @" 请输入密码";
        _passWView.textField.secureTextEntry = YES;
        _passWView.leftImageName = @"login_pass";
    }
    
    return _passWView;
}

- (UIButton *)codeLoginBtn {
    
    if (!_codeLoginBtn) {
        
        _codeLoginBtn = [[UIButton alloc] init];
        [_codeLoginBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        [_codeLoginBtn setTitle:@"密码登录" forState:UIControlStateSelected];
        _codeLoginBtn.titleLabel.font = PISYS_FONT(16);
        [_codeLoginBtn setTitleColor:PIMainColor forState:UIControlStateNormal];
        [_codeLoginBtn setTitleColor:PIMainColor forState:UIControlStateSelected];
    }
    
    return _codeLoginBtn;
}
- (PIBottomBtn *)bottomBtn {
    
    if (!_bottomBtn) {
        
        _bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"登录"];
    }
    
    return _bottomBtn;
}

- (UIButton *)rigestBtn {
    
    if (!_rigestBtn) {
        
        _rigestBtn = [[UIButton alloc] initWithTitle:@"注册新账号"];
        _rigestBtn.layer.borderColor = PIMainColor.CGColor;
        _rigestBtn.layer.borderWidth = 1.0;
        _rigestBtn.titleLabel.font = PIBigFont;
        [_rigestBtn setTitleColor:PIMainColor forState:UIControlStateNormal];
    }
    
    return _rigestBtn;
}

- (UIButton *)forgetPassWBtn {
    
    if (!_forgetPassWBtn) {
        
        _forgetPassWBtn = [[UIButton alloc] init];
        
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
        NSRange range = NSMakeRange(0, 5);
        
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        [str addAttributes:attribtDic range:range];
        //设置文本中的电话号码显示为黄色
        [str addAttribute:NSForegroundColorAttributeName value:PIMainColor range:range];
        [_forgetPassWBtn setAttributedTitle:str forState:UIControlStateNormal];
        _forgetPassWBtn.titleLabel.font = PISYS_FONT(15);
        [_forgetPassWBtn setTitleColor:PIMainColor forState:UIControlStateNormal];
    }
    
    return _forgetPassWBtn;
}

- (UIImageView *)topImageView {
    
    if (!_topImageView) {
        
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg.jpeg"]];
    }
    
    return _topImageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
