//
//  PIPayOrderTopCell.m
//  Parking
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPayOrderTopCell.h"

@interface PIPayOrderTopCell ()

///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;
///-- 内容
@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation PIPayOrderTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.commentLabel];
    
    weakself
    
    CGFloat labelW = (SCREEN_WIDTH - 30 * Scale_Y)* 0.5;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(labelW - 10);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.titleLabel.mas_right);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
    }];
    
    
}


- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor textAlignment:Right text:@"支付:"];
    }
    
    return _titleLabel;
}


- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:18 weight:2];
        _commentLabel.textColor = txtRedColor;
        _commentLabel.text = @"￥500";
    }
    
    return _commentLabel;
}

@end
