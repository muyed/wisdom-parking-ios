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
@property (nonatomic, strong) UITextField *codeText;

///-- 立即预约
@property (nonatomic, strong) UIButton *orderBtn;

@end

@implementation PIHomeMainView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //self.backgroundColor = [UIColor redColor];
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.addBtn];
    [self addSubview:self.tipLabel];
    [self addSubview:self.orderCodeLabel];
    [self addSubview:self.codeText];
    [self addSubview:self.orderBtn];
    
    CGFloat addBtnWH = 120 * Scale_Y;
    weakself
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.width.and.height.mas_equalTo(addBtnWH);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.addBtn.mas_bottom).offset(15 * Scale_Y);
        make.left.equalTo(weakSelf).offset(70);
        make.right.equalTo(weakSelf).offset(-70);
        make.height.mas_equalTo(35 * Scale_Y);
    }];
    
    [self.orderCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(70 * Scale_Y);
        make.left.and.right.equalTo(weakSelf);
    }];
    
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.orderCodeLabel.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-20);
        make.height.mas_equalTo(49 * Scale_Y);
    }];
    
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.codeText.mas_bottom).offset(20 * Scale_Y);
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-20);
        make.height.mas_equalTo(49 * Scale_Y);
    }];
    
    self.tipLabel.layer.cornerRadius = 17.5;
    self.tipLabel.clipsToBounds = YES;
    self.codeText.layer.cornerRadius = 24.5;
    self.codeText.clipsToBounds = YES;
    self.orderBtn.layer.cornerRadius = 24.5;
    self.orderBtn.clipsToBounds = YES;
    
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBtnClick {
    
    PIAddDeviceController *addDevice = [PIAddDeviceController new];
    
    [self.parentController.navigationController pushViewController:addDevice animated:YES];
}

- (void)orderBtnClick {
    
    NSLog(@"-=======");
    
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
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont boldSystemFontOfSize:17];
        _tipLabel.text = @"点击添加智能车位锁";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.backgroundColor = PIBackColor;
    }
    
    return _tipLabel;
}

- (UILabel *)orderCodeLabel {
    
    if (!_orderCodeLabel) {
        
        _orderCodeLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor textAlignment:Center text:@"如果您是访客，请输入预约码"];
    }
    
    return _orderCodeLabel;
}

- (UITextField *)codeText {
    
    if (!_codeText) {
        
        _codeText = [UITextField new];
        _codeText.placeholder = @" 请输入预约码";
        _codeText.keyboardType = UIKeyboardTypeDefault;
        _codeText.returnKeyType = UIReturnKeyDone;
        _codeText.delegate = self;
        _codeText.borderStyle = UITextBorderStyleLine;
        _codeText.layer.borderColor = PIMainColor.CGColor;
        _codeText.layer.borderWidth = 2;
        _codeText.textAlignment = NSTextAlignmentCenter;
        _codeText.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    return _codeText;
}

- (UIButton *)orderBtn {
    
    if (!_orderBtn) {
        
        _orderBtn = [[UIButton alloc] initWithFont:17 titleColor:[UIColor whiteColor] title:@"立即预约"];
        
        _orderBtn.backgroundColor = PIMainColor;
        
    }
    
    return _orderBtn;
}
@end
