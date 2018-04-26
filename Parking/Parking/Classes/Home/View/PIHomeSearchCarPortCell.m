//
//  PIHomeSearchCarPortCell.m
//  Parking
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeSearchCarPortCell.h"

@interface PIHomeSearchCarPortCell ()

///-- 位置
@property (nonatomic, strong) UILabel *posationLabel;
///-- 时间
@property (nonatomic, strong) UILabel *timeLabel;
///-- 时间提示
@property (nonatomic, strong) UILabel *timeTipLabel;
///-- 地址
@property (nonatomic, strong) UILabel *addressLabel;
///-- 地址提示
@property (nonatomic, strong) UILabel *addressTipLabel;
///-- 匹配
@property (nonatomic, strong) UIButton *matchBtn;
///-- 单价
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation PIHomeSearchCarPortCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.posationLabel];
    [self.contentView addSubview:self.timeTipLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.addressTipLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.matchBtn];
    [self.contentView addSubview:self.priceLabel];
    
    weakself;
    
    CGFloat tipLabelHW = 25 * Scale_Y;
    
    [self.matchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.posationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.matchBtn.mas_left).offset(-5);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.centerY.equalTo(weakSelf.matchBtn.mas_centerY);
    }];
    
    [self.timeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.posationLabel.mas_bottom).offset(15);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.matchBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.timeTipLabel.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.timeTipLabel.mas_centerY);
        make.right.equalTo(weakSelf.priceLabel.mas_left).offset(-5);
    }];
    
    [self.addressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.timeTipLabel.mas_bottom).offset(15);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.timeTipLabel.mas_right).offset(5);
        make.top.equalTo(weakSelf.addressTipLabel.mas_top).offset(1);
        make.right.equalTo(weakSelf.priceLabel.mas_left).offset(-5);
        make.bottom.equalTo(weakSelf.contentView).offset(-15);
    }];
}

- (UIButton *)matchBtn {
    
    if (!_matchBtn) {
        
        _matchBtn = [[UIButton alloc] initWithTitle:@"去匹配"];
        _matchBtn.titleLabel.font = PISYS_FONT(15);
        _matchBtn.layer.borderColor = PIYellowColor.CGColor;
        _matchBtn.layer.borderWidth = 1.0;
        _matchBtn.layer.cornerRadius = 5.0;
        _matchBtn.clipsToBounds = YES;
        [_matchBtn setTitleColor:PIYellowColor forState:UIControlStateNormal];
    }
    
    return _matchBtn;
}

- (UILabel *)posationLabel {
    
    if (!_posationLabel) {
        
        _posationLabel = [[UILabel alloc] init];
        _posationLabel.font = [UIFont boldSystemFontOfSize:18];
        _posationLabel.textColor = txtMainColor;
        _posationLabel.text = @"负一层5005";
        //_numLabel.backgroundColor = [UIColor redColor];
    }
    
    return _posationLabel;
}

- (UILabel *)timeTipLabel {
    
    if (!_timeTipLabel) {
        
        _timeTipLabel = [[UILabel alloc] initWithFont:17 textColor:[UIColor whiteColor] textAlignment:Center text:@"时"];
        _timeTipLabel.layer.cornerRadius = 5;
        _timeTipLabel.clipsToBounds = YES;
        _timeTipLabel.backgroundColor = PIYellowColor;
    }
    
    return _timeTipLabel;
}

- (UILabel *)addressTipLabel {
    
    if (!_addressTipLabel) {
        
        _addressTipLabel = [[UILabel alloc] initWithFont:17 textColor:[UIColor whiteColor] textAlignment:Center text:@"位"];
        _addressTipLabel.layer.cornerRadius = 5;
        _addressTipLabel.clipsToBounds = YES;
        _addressTipLabel.backgroundColor = PIMainColor;
    }
    
    return _addressTipLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _timeLabel.text = @"可停止01月30日 23:59";
    }
    
    return _timeLabel;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = PISYS_FONT(23);
        //_priceLabel.text = @"4元/小时";
        NSString *tmp = @"4元/小时";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tmp];
        [str addAttribute:NSForegroundColorAttributeName  value:PIYellowColor range:NSMakeRange(0, tmp.length - 3)];
        
        [str addAttribute:NSForegroundColorAttributeName  value:txtSeconColor range:NSMakeRange(tmp.length - 3, 3)];
        
        [str addAttribute:NSFontAttributeName  value:PISYS_FONT(20) range:NSMakeRange(0, tmp.length - 4)];
        
        [str addAttribute:NSFontAttributeName  value:PISYS_FONT(16) range:NSMakeRange(tmp.length - 4, 4)];
        
        _priceLabel.attributedText = str;
    }
    
    return _priceLabel;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _addressLabel.text = @"苏溪镇规划二路1号西山下哈哈哈哈哈哈哈";
        _addressLabel.numberOfLines = 0;
        _addressLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 155;
    }
    
    return _addressLabel;
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
