//
//  PICarNumCell.m
//  Parking
//
//  Created by apple on 2018/3/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarNumCell.h"

@interface PICarNumCell ()
///-- 车位数
@property (nonatomic, strong) UILabel *numLabel;
///-- 编号
@property (nonatomic, strong) UILabel *idLabel;
///-- 输入框
@property (nonatomic, strong) UITextField *carNumField;
///-- 删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation PICarNumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.idLabel];
    [self.contentView addSubview:self.carNumField];
    
    weakself
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-75);
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.height.and.width.mas_equalTo(25);
    }];
    
    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.numLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [self.carNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.idLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.centerY.equalTo(weakSelf.idLabel.mas_centerY);
        
        make.height.mas_equalTo(40);
        
    }];
    
    
    
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
}



- (void)deleteBtnClick {
    
    if (self.clickIndex) {
        
        self.clickIndex(self.index);
    }
}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    
    self.idLabel.text = [NSString stringWithFormat:@"车位 %lu", index];
    
    if (index == 1) {
        
        [self.deleteBtn setImage:[UIImage imageNamed:@"home_add_car"] forState:UIControlStateNormal];
        
    }else {
        
        [self.deleteBtn setImage:[UIImage imageNamed:@"home_delete"] forState:UIControlStateNormal];
    }
}
#pragma mark -- 懒加载
- (UILabel *)numLabel {
    
    if (!_numLabel) {
        
        _numLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor text:@"车牌号码"];
        
    }
    
    return _numLabel;
}

- (UILabel *)idLabel {
    
    if (!_idLabel) {
        
        _idLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
    }
    
    return _idLabel;
}


- (UITextField *)carNumField {
    
    if (!_carNumField) {
        
        _carNumField = [[UITextField alloc] init];
        _carNumField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _carNumField.layer.borderWidth = 1.0;

    }
    
    return _carNumField;
}


- (UIButton *)deleteBtn {
    
    if (!_deleteBtn) {
        
        _deleteBtn = [[UIButton alloc] initWithImageName:@"home_delete"];
    }
    
    return _deleteBtn;
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
