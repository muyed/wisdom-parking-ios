//
//  PIVillageSelectCell.m
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageSelectCell.h"

@interface PIVillageSelectCell ()

///-- 内容
@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation PIVillageSelectCell

- (void)setupUI {
    
    [super setupUI];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.contentView addSubview:self.commentLabel];
    
    weakself
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(weakSelf.titleLabel.mas_right).offset(10 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
    }];
}

-(void)setContentStr:(NSString *)contentStr {
    
    _contentStr = contentStr;
    
    self.commentLabel.text = contentStr;
    
}
- (UILabel *)commentLabel {

    if (!_commentLabel) {

        _commentLabel = [[UILabel alloc] initWithFont:16 textColor:txtPlaceColor];

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
