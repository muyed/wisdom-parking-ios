//
//  PIMyBankCardCell.m
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyBankCardCell.h"

@interface PIMyBankCardCell ()

///-- logo
@property (nonatomic, strong) UIImageView *iconView;
///-- 银行名字
@property (nonatomic, strong) UILabel *nameLabel;
///-- 银行卡号
@property (nonatomic, strong) UILabel *cardLabel;
///-- 更改按钮
@property (nonatomic, strong) UIButton *changeBtn;

@end

@implementation PIMyBankCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor blueColor];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.clipsToBounds = YES;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.cardLabel];
    [self.contentView addSubview:self.changeBtn];
    
    weakself
    
    CGFloat iconWH = 50;
    
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(25);
        make.top.equalTo(weakSelf.contentView).offset(25);
        make.height.and.width.mas_equalTo(iconWH);
    }];
    
    self.iconView.layer.cornerRadius = iconWH * 0.5;
    self.iconView.clipsToBounds = YES;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.iconView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.iconView.mas_centerY);
        make.right.equalTo(weakSelf.changeBtn.mas_left).offset(-10);
    }];
    
    [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.bottom.equalTo(weakSelf.contentView).offset(-40);
    }];
    
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = 15;
    frame.size.width -= 30;
    frame.size.height = 200 - 15;
    frame.origin.y += 15;
    
    [super setFrame:frame];
}
- (UIImageView *)iconView {
    
    if (!_iconView) {
        
        _iconView = [UIImageView new];
        _iconView.backgroundColor = [UIColor redColor];
    }
    
    return _iconView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] initWithFont:20 textColor:[UIColor whiteColor]];
        _nameLabel.text = @"建设银行";
        //_nameLabel.backgroundColor = [UIColor redColor];
    }
    
    return _nameLabel;
}

- (UILabel *)cardLabel {
    
    if (!_cardLabel) {
        
        _cardLabel = [[UILabel alloc] init];
        _cardLabel.font = [UIFont boldSystemFontOfSize:25];
        _cardLabel.textColor = [UIColor whiteColor];
        _cardLabel.text = @"**** **** **** 5868";
        _cardLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _cardLabel;
}

- (UIButton *)changeBtn {
    
    if (!_changeBtn) {
        
        _changeBtn = [[UIButton alloc] initWithFont:18 titleColor:[UIColor whiteColor] title:@"更改"];
        //_changeBtn.backgroundColor = [UIColor yellowColor];
    }
    
    return _changeBtn;
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
