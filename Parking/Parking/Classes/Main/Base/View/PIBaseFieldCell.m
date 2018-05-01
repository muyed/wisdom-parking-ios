//
//  PIBaseFieldCell.m
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseFieldCell.h"

@interface PIBaseFieldCell ()<UITextFieldDelegate>



@end

@implementation PIBaseFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    
    weakself
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(80);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
        make.height.mas_equalTo(40);
    }];
    
    
}

- (void)setTitleString:(NSString *)titleString {

    _titleString = titleString;

    self.titleLabel.text = titleString;
}

- (void)setPlaceString:(NSString *)placeString {
    
    _placeString = placeString;
    
    self.textField.placeholder = placeString;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.pi_delegate && [self.pi_delegate respondsToSelector:@selector(pi_textFieldEndEidting: index:)]) {
        
        [self.pi_delegate pi_textFieldEndEidting:textField index:self.index];
    }
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
    }
    
    return _titleLabel;
}


- (UITextField *)textField {
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        //_textField.placeholder = @"请填写真实名字";
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.delegate = self;
    }
    
    return _textField;
}

@end
