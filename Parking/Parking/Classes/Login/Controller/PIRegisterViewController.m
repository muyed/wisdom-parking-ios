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

@end

@implementation PIRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.selectBtn];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.protolBtn];
    [self.view addSubview:self.nextBtn];
    weakself
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(100 * Scale_Y);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(36);
        
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.phoneView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view).offset(20);
        make.width.and.height.mas_equalTo(20);
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
        
        make.left.equalTo(weakSelf.view).offset(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(50);
        make.height.mas_equalTo(44);
    }];
    
    self.nextBtn.layer.cornerRadius = 10.0;
    self.nextBtn.clipsToBounds = YES;
    
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.protolBtn addTarget:self action:@selector(protolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}

- (void)protolBtnClick:(UIButton *)sender {
    
    NSLog(@"协议");
}

- (void)nextBtnClick:(UIButton *)sender {
    
    
    
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
    
    weakself
    [PILoginManager getVerificationCodeWithPhoneNum:self.phoneView.textField.text type:PICodeTypeRegistr success:^(id response) {


        [MBProgressHUD hideHUD];
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        if (model.code == 200) {
            [MBProgressHUD showMessage:@"验证码发送成功"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                PISetPassWViewController *passWVC = [PISetPassWViewController new];
                passWVC.phoneNum = weakSelf.phoneView.textField.text;
                [weakSelf.navigationController pushViewController:passWVC animated:YES];
            });

        }else {

            [MBProgressHUD showMessage:model.errMsg];
        }


    } failue:^(NSError *error) {

        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"获取失败"];

    }];
    
}

- (PILoginFieldView *)phoneView {
    
    if (!_phoneView) {
        
        _phoneView = [PILoginFieldView new];
        _phoneView.textField.keyboardType = UIKeyboardTypePhonePad;
        _phoneView.textField.placeholder = @"请输入手机号";
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
