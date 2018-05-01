//
//  PIAddPersonCell.m
//  Parking
//
//  Created by apple on 2018/3/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddPersonCell.h"

@interface PIAddPersonCell ()

///-- tipLabel
@property (nonatomic, strong) UILabel *tipLabel;
///-- 开关
@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation PIAddPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.switchBtn];
    
    weakself
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(140);
    }];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
}


- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"开通二维码识别"];
        
    }
    
    return _tipLabel;
}

- (UISwitch *)switchBtn {
    
    if (!_switchBtn) {
        
        _switchBtn = [[UISwitch alloc] init];
    }
    
    return _switchBtn;
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
