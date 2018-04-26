//
//  PIPayOrderTypeCell.m
//  Parking
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPayOrderTypeCell.h"


@interface PIPayOrderTypeCell ()

///-- 支付图片
@property (nonatomic, strong) UIImageView *iconView;
///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;
///-- 副标题
@property (nonatomic, strong) UILabel *subLabel;
///-- 选中
@property (nonatomic, strong) UIImageView *selectImageView;

@end
@implementation PIPayOrderTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subLabel];
    [self.contentView addSubview:self.selectImageView];
    
    
    weakself
    
    CGFloat iconViewHW = 50 * Scale_Y;
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.height.and.width.mas_equalTo(iconViewHW);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.height.and.width.mas_equalTo(25);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.iconView.mas_right).offset(10);
        make.right.equalTo(weakSelf.selectImageView.mas_left).offset(-10);
        make.top.equalTo(weakSelf.contentView).offset(15);
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.iconView.mas_right).offset(10);
        make.right.equalTo(weakSelf.selectImageView.mas_left).offset(-10);
        make.bottom.equalTo(weakSelf.contentView).offset(-15);
    }];
    
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    
    self.iconView.image = [UIImage imageNamed:imageName];
    
}

- (void)setTitleStr:(NSString *)titleStr {
    
    _titleStr = titleStr;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@支付", titleStr];
    self.subLabel.text = [NSString stringWithFormat:@"推荐有%@账户的用户使用", titleStr];
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor];
        //_titleLabel.text = @"支付宝支付";
    }
    
    return _titleLabel;
}

- (UILabel *)subLabel {
    
    if (!_subLabel) {
        
        _subLabel = [[UILabel alloc] initWithFont:15 textColor:txtPlaceColor];
        //_subLabel.text = @"支付宝支付";
    }
    
    return _subLabel;
}

- (UIImageView *)iconView {
    
    if (!_iconView) {
        
        _iconView = [[UIImageView alloc] init];
    }
    
    return _iconView;
}

- (UIImageView *)selectImageView {
    
    if (!_selectImageView) {
        
        _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select"]];
        _selectImageView.hidden = YES;
    }
    
    return _selectImageView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectImageView.hidden = !selected;
}

@end
