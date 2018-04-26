//
//  PIPayForCashCell.m
//  Parking
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPayForCashCell.h"

@interface PIPayForCashCell ()

///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;
///-- 内容
@property (nonatomic, strong) UILabel *commentLabel;
///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 选中按钮
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation PIPayForCashCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tipLabel];
    //[self.contentView addSubview:self.selectBtn];
    
    weakself
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentView).offset(30);
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.width.mas_lessThanOrEqualTo(180);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.commentLabel.mas_centerY);
        make.left.equalTo(weakSelf.commentLabel.mas_right).offset(10 * Scale_Y);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(22);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
        make.bottom.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
    }];
    
//    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.equalTo(weakSelf.commentLabel.mas_centerY);
//        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
//        make.width.mas_equalTo(25);
//        make.height.mas_equalTo(25);
//
//    }];
}

- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:21 weight:2];
        _commentLabel.textColor = txtMainColor;
        _commentLabel.text = @"交纳押金199元";
    }
    
    return _commentLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor textAlignment:Left text:@"押金随时可退，中国工商银行监管"];
    }
    
    return _titleLabel;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:15 textColor:[UIColor whiteColor] textAlignment:Center text:@"可秒退"];
        _tipLabel.backgroundColor = UIColorFromRGB(0xf1851b);
        _tipLabel.layer.cornerRadius = 3.0 * Scale_Y;
        _tipLabel.clipsToBounds = YES;
    }
    
    return _tipLabel;
}

- (UIButton *)selectBtn {
    
    if (!_selectBtn) {
        
        _selectBtn = [[UIButton alloc] initWithImageName:@"select"];
        
    }
    
    return _selectBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
