//
//  PIHomeBottomView.m
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeBottomView.h"
#import "PIImageUpBtn.h"
#import "PIPersonalController.h"

@interface PIHomeBottomView ()

///-- 收放按钮
@property (nonatomic, strong) UIButton *tmpBtn;
///-- 预约
@property (nonatomic, strong) PIImageUpBtn *orderBtn;
///-- 个人中心
@property (nonatomic, strong) UIButton *personBtn;
///-- 提醒
@property (nonatomic, strong) UIButton *tipBtn;

@end

@implementation PIHomeBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    UIView *sepView = [UIView new];
    //sepView.backgroundColor = UIColorFromRGB(0xbfbfbf);
    
    [self addSubview:self.tmpBtn];
    [self addSubview:self.orderBtn];
    [self addSubview:sepView];
    [self addSubview:self.personBtn];
    [self addSubview:self.tipBtn];
    
    CGFloat orderWH = 90;
    weakself
    
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.and.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];

    [self.tmpBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakSelf).offset(-5);
        make.centerX.equalTo(weakSelf);
        make.height.and.right.mas_equalTo(25);
    }];
    
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.center.equalTo(weakSelf);
        make.width.and.height.mas_equalTo(orderWH);
    }];
    
    [self.personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).offset(15);
        make.bottom.equalTo(weakSelf).offset(-20);
        make.height.and.width.mas_equalTo(30);
    }];
    
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).offset(-15);
        make.bottom.equalTo(weakSelf).offset(- 20);
        make.height.and.width.mas_equalTo(30);
    }];
    
    self.orderBtn.layer.cornerRadius = orderWH * 0.5;
    self.orderBtn.clipsToBounds = YES;
    
    [self.tmpBtn addTarget:self action:@selector(upDownClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.personBtn addTarget:self action:@selector(personBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tipBtn addTarget:self action:@selector(tipBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)upDownClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonStateChanged:)]) {
        
        [self.delegate buttonStateChanged:sender.selected];
    }
}

- (void)tipBtnClick {
    
    [MBProgressHUD showMessage:@"正在努力建设中...."];
}
- (void)personBtnClick {
    
    PIPersonalController *personal = [PIPersonalController new];
    personal.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.parentController presentViewController:personal animated:YES completion:nil];
}
#pragma mark -- 懒加载
- (PIImageUpBtn *)orderBtn {
    
    if (!_orderBtn) {
        
        _orderBtn = [[PIImageUpBtn alloc] initWithFont:17 titleColor:[UIColor whiteColor] title:@"预约"];
        [_orderBtn setImage:[UIImage imageNamed:@"home_swap_white"] forState:UIControlStateNormal];
//        _orderBtn.titleEdgeInsets = UIEdgeInsetsMake(25, 0, 0, 25);
//        _orderBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 25, 0);
      
        _orderBtn.backgroundColor = PIMainColor;
    }
    
    return _orderBtn;
}

- (UIButton *)tmpBtn {
    
    if (!_tmpBtn) {
        
        _tmpBtn = [[UIButton alloc] init];
        [_tmpBtn setImage:[UIImage imageNamed:@"home_down"] forState:UIControlStateNormal];
        [_tmpBtn setImage:[UIImage imageNamed:@"home_up"] forState:UIControlStateSelected];
    }
    
    return _tmpBtn;
}

- (UIButton *)personBtn {
    
    if (!_personBtn) {
        
        _personBtn = [[UIButton alloc] init];
        [_personBtn setBackgroundImage:[UIImage imageNamed:@"home_person_center"] forState:UIControlStateNormal];
    }
    
    return _personBtn;
}

- (UIButton *)tipBtn {
    
    if (!_tipBtn) {
        
        _tipBtn = [[UIButton alloc] init];
        [_tipBtn setBackgroundImage:[UIImage imageNamed:@"home_rolling"] forState:UIControlStateNormal];
    }
    
    return _tipBtn;
}
@end
