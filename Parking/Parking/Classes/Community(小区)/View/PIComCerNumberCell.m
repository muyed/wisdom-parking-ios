//
//  PIComCerNumberCell.m
//  Parking
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIComCerNumberCell.h"

@interface PIComCerNumberCell ()

///-- 车位
@property (nonatomic, strong) UILabel *carTipLabel;
///-- 金额提示
@property (nonatomic, strong) UILabel *moneyTipLabel;
///-- 车位
@property (nonatomic, strong) UILabel *carLabel;
///-- 金额
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation PIComCerNumberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    

    [self.contentView addSubview:self.carTipLabel];
    [self.contentView addSubview:self.carLabel];
    
    [self.contentView addSubview:self.moneyTipLabel];
    [self.contentView addSubview:self.moneyLabel];
    
    weakself
    
    CGFloat lableW = 120 * Scale_Y ;
    
    [self.carTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(20 * Scale_Y);
        make.top.equalTo(weakSelf.contentView).offset(20 * Scale_Y);
        make.width.mas_equalTo(lableW);
    }];
    
    [self.carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.carTipLabel.mas_right).offset(5 * Scale_Y);
        make.right.equalTo(weakSelf.contentView).offset(-20 * Scale_Y);
        make.top.equalTo(weakSelf.carTipLabel);
    }];
    
    
    [self.moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(20 * Scale_Y);
        make.bottom.equalTo(weakSelf.contentView).offset(-20 * Scale_Y);
        make.width.mas_equalTo(lableW);
        
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.moneyTipLabel.mas_right).offset(5 * Scale_Y);
        make.right.equalTo(weakSelf.contentView).offset(-20 * Scale_Y);
        make.top.equalTo(weakSelf.moneyTipLabel);
    }];
    
    
}

- (UILabel *)carTipLabel {
    
    if (!_carTipLabel) {
        
        _carTipLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"车位编号"];
    }
    
    return _carTipLabel;
}


- (UILabel *)moneyTipLabel {
    
    if (!_moneyTipLabel) {
        
        _moneyTipLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"当月收益金额"];
    }
    
    return _moneyTipLabel;
}

- (UILabel *)carLabel {
    
    if (!_carLabel) {
        
        _carLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"B888888"];
        _carLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _carLabel;
}

- (UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        
        _moneyLabel = [[UILabel alloc] initWithFont:17 textColor:PIYellowColor text:@"199.00"];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _moneyLabel;
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
