//
//  PIVillageListCell.m
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageListCell.h"
#import "PIVillageListModel.h"

@interface PIVillageListCell ()

/**
 名字
 */
@property (nonatomic, strong) UILabel * nameLabel;

/**
 地址
 */
@property (nonatomic, strong) UILabel * addressLabel;

@end

@implementation PIVillageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.addressLabel];
    
    weakself
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.bottom.equalTo(weakSelf.contentView).offset(-15);
    }];
}

- (void)setModel:(PIVillageDataModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.communityName.length > 0 ? model.communityName : @"";
    self.addressLabel.text = model.addr.length > 0 ? model.addr : @"";
}
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
        _nameLabel.text = @"山水之间";
    }
    
    return _nameLabel;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] initWithFont:15 textColor:txtSeconColor];
        _addressLabel.text = @"中华人民共和国浙江省金华市义乌市苏溪镇规划二路1号";
        _addressLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
        _addressLabel.numberOfLines = 0;
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
