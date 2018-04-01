//
//  PIVillageTypeCell.m
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageTypeCell.h"

@interface PIVillageTypeCell ()

///-- <#Notes#>
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation PIVillageTypeCell

- (void)setupUI {
    
    [super setupUI];
    
    [self.contentView addSubview:self.selectBtn];
    
    weakself
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.width.and.height.mas_equalTo(25);
        make.centerY.equalTo(weakSelf.contentView);
        
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(50 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(100);
    }];
    
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   
}

- (void)selectBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}
- (UIButton *)selectBtn {
    
    if (!_selectBtn) {
        
        _selectBtn = [[UIButton alloc] init];
        
        [_selectBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    }
    
    return _selectBtn;
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
