//
//  PIMyVillageViewCell.m
//  Parking
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyVillageViewCell.h"
#import "PIMyVillageListModel.h"

@interface PIMyVillageViewCell ()

///-- 小区名字
@property (nonatomic, strong) UILabel *nameLabel;
///-- 地址
@property (nonatomic, strong) UILabel *addLabel;
///-- 其他
@property (nonatomic, strong) UILabel *otherLabel;
///-- 状态
@property (nonatomic, strong) UILabel *statuesLabel;


@end

@implementation PIMyVillageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.addLabel];
    [self.contentView addSubview:self.otherLabel];
    [self.contentView addSubview:self.statuesLabel];
    
    
    weakself
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH - 95);
    }];
    
    [self.statuesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    
    
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.bottom.equalTo(weakSelf.contentView).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.bottom.equalTo(weakSelf.otherLabel.mas_top).offset(-10);
        
    }];
    

    
}

- (void)setModel:(PIMyVillageDataModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.communityName.length == 0 ? @"" : model.communityName;
    self.addLabel.text = model.addr.length == 0 ? @"" : model.addr;
    self.otherLabel.text = model.carportList.count == 0 ? @"暂无车位" : [NSString stringWithFormat:@"共%lu个车位", model.carportList.count];
    
    switch (model.type) {
            
        case 1: {
            
            self.statuesLabel.text = @"审核中";
            self.statuesLabel.textColor = PIMainColor;
            self.statuesLabel.layer.borderColor = PIMainColor.CGColor;
        }
            break;
            
        case 2:{
            
            self.statuesLabel.text = @"已认证";
            self.statuesLabel.textColor = UIColorFromRGB(0x52c41a);
            self.statuesLabel.layer.borderColor = UIColorFromRGB(0xb7eb8f).CGColor;
        }
            
            break;
            
        case 3:{
            
            self.statuesLabel.text = @"已拒绝";
            self.statuesLabel.textColor = UIColorFromRGB(0xf5222d);
            self.statuesLabel.layer.borderColor = UIColorFromRGB(0xffa39e).CGColor;
        }
            
            break;
    
            
        default:
            
            
            break;
    }
}
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textColor = txtMainColor;
        _nameLabel.text = @"听雨轩";
        //_numLabel.backgroundColor = [UIColor redColor];
    }
    
    return _nameLabel;
}

- (UILabel *)statuesLabel {
    
    if (!_statuesLabel) {
        
        _statuesLabel = [[UILabel alloc] initWithFont:13 textColor:UIColorFromRGB(0x52c41a)];
        _statuesLabel.layer.borderColor = UIColorFromRGB(0xb7eb8f).CGColor;
        _statuesLabel.layer.borderWidth = 1.0;
        _statuesLabel.layer.cornerRadius = 5.0;
        _statuesLabel.clipsToBounds = YES;
        
        _statuesLabel.textAlignment = NSTextAlignmentCenter;
        _statuesLabel.text = @"已认证";
        //_statuesLabel.backgroundColor = [UIColor yellowColor];
        
    }
    
    return _statuesLabel;
}

- (UILabel *)addLabel {
    
    if (!_addLabel) {
        
        _addLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _addLabel.text = @"负四层055";
    }
    
    return _addLabel;
}

- (UILabel *)otherLabel {
    
    if (!_otherLabel) {
        
        _otherLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _otherLabel.text = @"预约时间: 2018-03-25 15:28:57";
    }
    
    return _otherLabel;
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
