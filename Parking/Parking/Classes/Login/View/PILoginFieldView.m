//
//  PILoginFieldView.m
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILoginFieldView.h"



@interface PILoginFieldView ()

///-- 底线
@property (nonatomic, strong) UIView *bottomLine;


@end

@implementation PILoginFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.textField];
    [self addSubview:self.bottomLine];
    
    weakself
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_equalTo(35);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.textField.mas_left);
        make.right.equalTo(weakSelf.textField.mas_right);
        make.top.equalTo(weakSelf.textField.mas_bottom).offset(5);
        make.height.mas_equalTo(0.5);
    }];
    

    
    if (self.isVerif) {

       
    }
   
}


- (void)setLeftImageName:(NSString *)leftImageName {
    
    _leftImageName = leftImageName;
    
    UIButton *leftImage = [[UIButton alloc] initWithImageName:leftImageName];
    leftImage.size = CGSizeMake(35, 35);
    self.textField.leftView = leftImage;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setRightImageName:(NSString *)rightImageName {
    
    _rightImageName = rightImageName;
    
    UIButton *rightImage = [[UIButton alloc] initWithImageName:rightImageName];
    rightImage.size = CGSizeMake(35, 35);
    self.textField.rightView = rightImage;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    [rightImage addTarget:self action:@selector(clearButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clearButtonClick {
    
    self.textField.text = nil;
    
}

- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        //_bottomLine.backgroundColor = UIColorFromRGB(0xBDBDBD);
        _bottomLine.backgroundColor = sepLineColor;
    }
    
    return _bottomLine;
}

- (UITextField *)textField {
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        _textField.tintColor = PIMainColor;
    }
    
    return _textField;
}


@end
