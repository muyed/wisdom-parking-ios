//
//  PIMyParkingLotCell.m
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyParkingLotCell.h"

@interface PIMyParkingLotCell ()

///-- 位置
@property (nonatomic, strong) UILabel *locLabel;
///-- 状态
@property (nonatomic, strong) UILabel *statueLabel;
///-- 时间
@property (nonatomic, strong) UILabel *timeLabel;
///-- 地址
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation PIMyParkingLotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.locLabel];
    [self.contentView addSubview:self.statueLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.addressLabel];
    
    weakself
    CGFloat statuesW = 50;
    CGFloat margin = 15;
    CGFloat marginH = 10;
    
    [self.locLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(margin);
        make.top.equalTo(weakSelf.contentView).offset(margin);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH - margin * 2 - statuesW - marginH);
    }];
    
    [self.statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.locLabel.mas_right).offset(marginH);
        make.centerY.equalTo(weakSelf.locLabel.mas_centerY);
        make.width.mas_equalTo(statuesW);
        make.height.mas_equalTo(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.locLabel.mas_left);
        make.right.equalTo(weakSelf.contentView).offset(-margin);
        make.top.equalTo(weakSelf.locLabel.mas_bottom).offset(margin);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.locLabel.mas_left);
        make.right.equalTo(weakSelf.contentView).offset(-margin);
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).offset(margin);
        make.bottom.equalTo(weakSelf.contentView).offset(-margin);
    }];
}

- (UILabel *)locLabel {
    
    if (!_locLabel) {
        
        _locLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
        _locLabel.text = @"负一层-b81711";
    }
    
    return _locLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] initWithFont:15 textColor:txtSeconColor];
        _timeLabel.text = @"有效期:长期有效";
    }
    
    return _timeLabel;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] initWithFont:16 textColor:txtPlaceColor];
        _addressLabel.text = @"北京市朝阳区北苑路2号天通苑西二区";
        _addressLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
        _addressLabel.numberOfLines = 0;
    }
    
    return _addressLabel;
}

- (UILabel *)statueLabel {
    
    if (!_statueLabel) {
        
        _statueLabel = [[UILabel alloc] initWithFont:12 textColor:txtRedColor];
        _statueLabel.text = @"已拒绝";
        _statueLabel.textAlignment = NSTextAlignmentCenter;
        _statueLabel.layer.borderWidth = 1;
        _statueLabel.layer.borderColor = txtRedColor.CGColor;
        _statueLabel.layer.cornerRadius = 3.0;
        _statueLabel.clipsToBounds = YES;
    }
    
    return _statueLabel;
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
