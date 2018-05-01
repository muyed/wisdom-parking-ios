//
//  PIMatchCarportTopCell.m
//  Parking
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMatchCarportTopCell.h"

@interface PIMatchCarportTopCell ()

///-- 车
@property (nonatomic, strong) UILabel *tipLabel;
///-- 车位
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation PIMatchCarportTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.tipLabel];
    
    weakself
    
    //CGFloat topMargin = 20 * Scale_Y;
    CGFloat tipLabelHW = 25 * Scale_Y;
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.tipLabel.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        
    }];
    
}

- (void)setTipColor:(UIColor *)tipColor {
    
    _tipColor = tipColor;
    
    _tipLabel.backgroundColor = tipColor;
}

- (void)setTipStr:(NSString *)tipStr {
    
    _tipStr = tipStr;
    
    self.tipLabel.text = tipStr;
}

- (void)setContentStr:(NSString *)contentStr {
    
    _contentStr = contentStr;
    
    self.contentLabel.text = contentStr;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        //_contentLabel.text = @"豫B66666";
    }
    
    return _contentLabel;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:17 textColor:[UIColor whiteColor] textAlignment:Center text:nil];
    
        _tipLabel.layer.cornerRadius = 5.0;
        _tipLabel.clipsToBounds = YES;
    }
    
    return _tipLabel;
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
