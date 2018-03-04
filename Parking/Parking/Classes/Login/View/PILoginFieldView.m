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
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-20);
        make.height.mas_equalTo(35);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.textField.mas_left);
        make.right.equalTo(weakSelf.textField.mas_right);
        make.top.equalTo(weakSelf.textField.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    

    
    if (self.isVerif) {

       
    }
   
}

- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = PIMainColor;
    }
    
    return _bottomLine;
}

- (UITextField *)textField {
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
    }
    
    return _textField;
}


@end
