//
//  PIOrderDetailCenterCell.m
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIOrderDetailCenterCell.h"

@interface PIOrderDetailCenterCell ()

///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;
///-- 内容
@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation PIOrderDetailCenterCell

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
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(100);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.titleLabel.mas_right).offset(10 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
    }];
    
    
}

- (void)setTitleStr:(NSString *)titleStr {
    
    _titleStr = titleStr;
    
    self.titleLabel.text = titleStr;
}

- (void)setContentStr:(NSString *)contentStr {
    
    _contentStr = contentStr;
    
    self.commentLabel.text = contentStr;
}

- (void)setIsPrice:(BOOL)isPrice {
    
    _isPrice = isPrice;
    
    if (_isPrice) {
        
        self.titleLabel.textColor = txtMainColor;
        self.commentLabel.textColor = txtRedColor;
    }else {
        
        self.titleLabel.textColor = txtPlaceColor;
        self.commentLabel.textColor = txtMainColor;
    }
    
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        
    }
    
    return _titleLabel;
}


- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
        
    }
    
    return _commentLabel;
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
