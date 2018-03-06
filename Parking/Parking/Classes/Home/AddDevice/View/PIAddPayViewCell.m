//
//  PIAddPayViewCell.m
//  Parking
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddPayViewCell.h"

@interface PIAddPayViewCell ()

///-- 图片
@property (nonatomic, strong) UIImageView *iconImageView;
///-- 提示
@property (nonatomic, strong) UILabel *desLabel;
///-- 选中
@property (nonatomic, strong) UIImageView *selectImageView;

@end

@implementation PIAddPayViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
    
}

- (void)setupUI {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.selectImageView];
    
    weakself
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.and.width.mas_equalTo(60);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(100);
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.and.width.mas_equalTo(25);
    }];
    
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    
    [self.iconImageView setImage:[UIImage imageNamed:imageName]];
}

- (void)setDescString:(NSString *)descString {
    
    _descString = descString;
    
    self.desLabel.text = descString;
    
}
- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
    }
    
    return _iconImageView;
}

- (UILabel *)desLabel {
    
    if (!_desLabel) {
        
        _desLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
    }
    
    return _desLabel;
}

- (UIImageView *)selectImageView {
    
    if (!_selectImageView) {
        
        _selectImageView = [[UIImageView alloc] init];
    }
    
    return _selectImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {

        self.selectImageView.image = [UIImage imageNamed:@"select"];
    }else {

        self.selectImageView.image = [UIImage imageNamed:@"unselect"];
    }

}

@end
