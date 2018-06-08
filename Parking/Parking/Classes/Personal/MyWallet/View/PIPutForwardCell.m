//
//  PIPutForwardCell.m
//  Parking
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPutForwardCell.h"

@interface PIPutForwardCell ()

///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;


@end

@implementation PIPutForwardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.moneyField];
    
    weakself
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.contentView).offset(15);
    }];
    
    [self.moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(40);
    }];
    
    
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:18 textColor:txtSeconColor text:@"转出金额"];
    }
    
    return _tipLabel;
}

- (UITextField *)moneyField {
    
    if (!_moneyField) {
        
        _moneyField = [[UITextField alloc] init];
        _moneyField.placeholder = [NSString stringWithFormat:@"本次做多可提现 %.2lf元", [PILoginTool defaultTool].balance];
        _moneyField.keyboardType = UIKeyboardTypeDecimalPad;
        
        UILabel *leftLabel = [[UILabel alloc] initWithFont:20 textColor:txtMainColor textAlignment:Center text:@"￥"];
        leftLabel.size = CGSizeMake(40, 40);
        leftLabel.font = [UIFont boldSystemFontOfSize:20];
        _moneyField.leftView = leftLabel;
        _moneyField.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *rightBtn = [[UIButton alloc] initWithFont:18 titleColor:PIMainColor title:@"全部"];
        rightBtn.size = CGSizeMake(60, 40);
        [rightBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _moneyField.rightView = rightBtn;
        _moneyField.rightViewMode = UITextFieldViewModeAlways;
    
    }
    
    return _moneyField;
}

- (void)buttonClick {
    
    self.moneyField.text = [NSString stringWithFormat:@"%.2lf", [PILoginTool defaultTool].balance];
    
    [self.moneyField resignFirstResponder];
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
