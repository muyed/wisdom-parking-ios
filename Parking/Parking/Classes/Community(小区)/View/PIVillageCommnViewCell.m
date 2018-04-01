//
//  PIVillageCommnViewCell.m
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageCommnViewCell.h"

@interface PIVillageCommnViewCell ()


@end
@implementation PIVillageCommnViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.titleLabel];
    //[self.contentView addSubview:self.commentLabel];
    
    weakself
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(100);
    }];
    

}

- (void)setTitleStr:(NSString *)titleStr {
    
    _titleStr = titleStr;
    
    self.titleLabel.text = titleStr;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
        
    }
    
    return _titleLabel;
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
