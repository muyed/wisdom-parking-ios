//
//  PIPublishOrderCell.m
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPublishOrderCell.h"
#import "PIMyParkModel.h"

@interface PIPublishOrderCell ()

///-- 号码
@property (nonatomic, strong) UILabel *nameLabel;
///-- 取消按钮
@property (nonatomic, strong) UIButton *detailBtn;
///-- 位
@property (nonatomic, strong) UILabel *addTipLabel;
///-- 车
@property (nonatomic, strong) UILabel *positionTipLabel;
///-- 车位
@property (nonatomic, strong) UILabel *positionLabel;
///-- 车牌
@property (nonatomic, strong) UILabel *addLabel;

///-- 车牌
@property (nonatomic, strong) UIImageView *rowIcon;

@end

@implementation PIPublishOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.detailBtn];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.addTipLabel];
    [self.contentView addSubview:self.addLabel];
    [self.contentView addSubview:self.positionTipLabel];
    [self.contentView addSubview:self.positionLabel];
    [self.contentView addSubview:self.rowIcon];
    
    weakself
    
    CGFloat buttonW = 40;
    CGFloat topMargin = 15 * Scale_Y;
    CGFloat tipLabelHW = 25 * Scale_Y;
    
    [self.rowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.contentView).offset(topMargin);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.rowIcon.mas_left).offset(-5);
        make.centerY.equalTo(weakSelf.rowIcon.mas_centerY);
        make.width.mas_equalTo(buttonW);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.contentView).offset(topMargin);
        make.right.equalTo(weakSelf.detailBtn.mas_left).offset(-10);
    }];
    
    
    [self.addTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(topMargin);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];
    
    
    
    
    [self.positionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.contentView).offset(15);
        make.bottom.equalTo(weakSelf.contentView).offset(-topMargin);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];

    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.positionTipLabel.mas_right).offset(8 * Scale_Y);
        make.centerY.equalTo(weakSelf.positionTipLabel.mas_centerY);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.addTipLabel.mas_right).offset(8 * Scale_Y);
        make.top.equalTo(weakSelf.addTipLabel.mas_top).offset(2 * Scale_Y);
        make.bottom.equalTo(weakSelf.positionTipLabel.mas_top).offset(-topMargin);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    
    
    self.positionTipLabel.layer.cornerRadius = 5 * Scale_Y;
    self.positionTipLabel.clipsToBounds = YES;
    
    self.addTipLabel.layer.cornerRadius = 5 * Scale_Y;
    self.addTipLabel.clipsToBounds = YES;
    
}

- (void)setModel:(PIMyParkDataModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.communityName.length == 0 ? @"" : model.communityName;
    self.addLabel.text = model.addr.length == 0 ? @"" : model.addr;
    self.positionLabel.text = model.carportNum.length == 0 ? @"" : model.carportNum;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textColor = txtMainColor;
        _nameLabel.text = @"马尔代夫";
        //_nameLabel.backgroundColor = [UIColor redColor];
    }
    
    return _nameLabel;
}

- (UIButton *)detailBtn {
    
    if (!_detailBtn) {
        
        _detailBtn = [[UIButton alloc] initWithFont:16 titleColor:txtPlaceColor title:@"详情"];
        
    }
    
    return _detailBtn;
}



- (UILabel *)positionTipLabel {
    
    if (!_positionTipLabel) {
        
        _positionTipLabel = [[UILabel alloc] initWithFont:17 textColor:[UIColor whiteColor] textAlignment:Center text:@"位"];
        
        _positionTipLabel.backgroundColor = PIGreenColor;
    }
    
    return _positionTipLabel;
}

- (UILabel *)positionLabel {
    
    if (!_positionLabel) {
        
        _positionLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _positionLabel.text = @"负四层055";
    }
    
    return _positionLabel;
}

- (UILabel *)addLabel {
    
    if (!_addLabel) {
        
        _addLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _addLabel.text = @"规划二路1号规划二路1号规划二路1号规划二路1号规划二路1号";
        _addLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 63 * Scale_Y;
        _addLabel.numberOfLines = 2;
    }
    
    return _addLabel;
}

- (UILabel *)addTipLabel {
    
    if (!_addTipLabel) {
        
        _addTipLabel = [[UILabel alloc] initWithFont:17 textColor:[UIColor whiteColor] textAlignment:Center text:@"地"];
        
        _addTipLabel.backgroundColor = PIMainColor;
    }
    
    return _addTipLabel;
}

- (UIImageView *)rowIcon {
    
    if (!_rowIcon) {
        
        _rowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_row"]];
    }
    
    return _rowIcon;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
