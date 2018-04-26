//
//  PICarportTimeCell.m
//  Parking
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarportTimeCell.h"

@interface PICarportTimeCell ()

///-- 左边的日期
@property (nonatomic, strong) UILabel *leftDayLabel;
///-- 左边的时间
@property (nonatomic, strong) UILabel *leftTimeLabel;
///-- 右边的日期
@property (nonatomic, strong) UILabel *rightDayLabel;
///-- 右边的时间
@property (nonatomic, strong) UILabel *rightTimeLabel;
///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 箭头
@property (nonatomic, strong) UIImageView *arrowView;
@end

@implementation PICarportTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.leftDayLabel];
    [self.contentView addSubview:self.leftTimeLabel];
    [self.contentView addSubview:self.rightDayLabel];
    [self.contentView addSubview:self.rightTimeLabel];
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.arrowView];
    
    CGFloat timeLabelW = 80;
    CGFloat margin = 40;
    weakself
    
    [self.leftDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(margin);
        make.top.equalTo(weakSelf.contentView).offset(20);
        make.width.mas_equalTo(timeLabelW);
    }];
    
    [self.leftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(margin);
        make.top.equalTo(weakSelf.leftDayLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(timeLabelW);
    }];
    
    [self.rightDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-margin);
        make.top.equalTo(weakSelf.contentView).offset(20);
        make.width.mas_equalTo(timeLabelW);
    }];
    
    [self.rightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-margin);
        make.top.equalTo(weakSelf.rightDayLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(timeLabelW);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.rightDayLabel.mas_left).offset(-5);
        make.left.equalTo(weakSelf.leftDayLabel.mas_right).offset(5);
        make.top.equalTo(weakSelf.rightDayLabel.mas_top).offset(5);
        
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.rightDayLabel.mas_left).offset(-5);
        make.left.equalTo(weakSelf.leftDayLabel.mas_right).offset(5);
        make.top.equalTo(weakSelf.tipLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(3);
    }];
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor textAlignment:Center text:@"共享时间"];
        
    }
    
    return _tipLabel;
}

- (UILabel *)leftDayLabel {
    
    if (!_leftDayLabel) {
        
        _leftDayLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor];
        _leftDayLabel.text = @"04-26";
        //_leftDayLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _leftDayLabel;
}

- (UILabel *)leftTimeLabel {
    
    if (!_leftTimeLabel) {
        
        _leftTimeLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
        _leftTimeLabel.text = @"周六 10:00";
       // _leftTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _leftTimeLabel;
}

- (UILabel *)rightDayLabel {
    
    if (!_rightDayLabel) {
        
        _rightDayLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor];
        _rightDayLabel.text = @"04-26";
        _rightDayLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _rightDayLabel;
}

- (UILabel *)rightTimeLabel {
    
    if (!_rightTimeLabel) {
        
        _rightTimeLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
        _rightTimeLabel.text = @"周六 12:00";
        _rightTimeLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _rightTimeLabel;
}

- (UIImageView *)arrowView {
    
    if (!_arrowView) {
        
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"long_arr"]];
       // _arrowView.backgroundColor = [UIColor redColor];
    }
    
    return _arrowView;
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
