//
//  PICarportAddressCell.m
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarportAddressCell.h"
#import "PICarportModel.h"

@interface PICarportAddressCell ()

///-- 导航
@property (nonatomic, strong) UIButton *navBtn;
///--
@property (nonatomic, strong) UILabel *nameLabel;
///-- <#Notes#>
@property (nonatomic, strong) UILabel *addLabel;

@end

@implementation PICarportAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.navBtn];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.addLabel];
    
    weakself
    
    [self.navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.and.width.mas_equalTo(40);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.navBtn.mas_left).offset(-5);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.left.equalTo(weakSelf.contentView).offset(15);
    }];
    
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.navBtn.mas_left).offset(-5);
        make.bottom.equalTo(weakSelf.contentView).offset(-10);
        make.left.equalTo(weakSelf.contentView).offset(15);
    }];
    
    [self.navBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick {
    
    if (self.carportNav) {
        
        self.carportNav();
    }
}
- (void)setModel:(PICarportDataModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.communityName.length == 0 ? @" " : model.communityName;
    self.addLabel.text = model.addr.length == 0 ? @" " : model.addr;
    
}
- (UIButton *)navBtn {
    
    if (!_navBtn) {
        
        _navBtn = [[UIButton alloc] initWithImageName:@"home_nav"];
        _navBtn.backgroundColor = PIMainColor;
        _navBtn.layer.cornerRadius = 10.0;
        _navBtn.clipsToBounds = YES;
    }
    
    return _navBtn;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor];
        _nameLabel.text = @"空中楼阁";
       // _nameLabel.backgroundColor = txtRedColor;
    }
    
    return _nameLabel;
}

- (UILabel *)addLabel {
    
    if (!_addLabel) {
        
        _addLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
        _addLabel.text = @"义乌市苏溪镇规划2路1号义乌市苏溪镇规划2路1号";
       // _addLabel.backgroundColor = PIYellowColor;
        _addLabel.numberOfLines = 2;
        //_addLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 105;
    }
    
    return _addLabel;
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
