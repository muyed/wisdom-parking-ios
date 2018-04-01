//
//  PIVillageFieldCell.m
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageFieldCell.h"

@interface PIVillageFieldCell ()

///-- <#Notes#>
@property (nonatomic, strong) UITextField *textField;

@end
@implementation PIVillageFieldCell

- (void)setupUI {
    
    [super setupUI];
    [self.contentView addSubview:self.textField];
    
    weakself
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.titleLabel.mas_right).offset(10 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
        make.height.mas_equalTo(40 * Scale_Y);
    }];
}

- (UITextField *)textField {
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请填写车牌号码";
    }
    
    return _textField;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
