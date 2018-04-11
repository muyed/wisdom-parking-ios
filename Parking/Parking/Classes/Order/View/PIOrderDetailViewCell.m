//
//  PIOrderDetailViewCell.m
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIOrderDetailViewCell.h"

@interface PIOrderDetailViewCell ()

///-- 号码
@property (nonatomic, strong) UILabel *numLabel;
///-- 取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;
///-- 分割线
@property (nonatomic, strong) UIView *sepView;
///-- 位
@property (nonatomic, strong) UILabel *positionTipLabel;
///-- 车
@property (nonatomic, strong) UILabel *carTipLabel;
///-- 车位
@property (nonatomic, strong) UILabel *positionLabel;
///-- 车牌
@property (nonatomic, strong) UILabel *carLabel;

@end

@implementation PIOrderDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.sepView];
    [self.contentView addSubview:self.positionTipLabel];
    [self.contentView addSubview:self.carTipLabel];
    [self.contentView addSubview:self.positionLabel];
    [self.contentView addSubview:self.carLabel];
    
    weakself
    
    CGFloat buttonW = 80;
    CGFloat topMargin = 20 * Scale_Y;
    CGFloat tipLabelHW = 25 * Scale_Y;
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.contentView).offset(topMargin);
        make.width.mas_equalTo(buttonW);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(20);
        make.top.equalTo(weakSelf.contentView).offset(topMargin);
        make.right.equalTo(weakSelf.cancelBtn.mas_left).offset(-10);
    }];
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.numLabel.mas_bottom).offset(topMargin);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    [self.positionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.sepView.mas_bottom).offset(topMargin);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];
    
    [self.carTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.positionTipLabel.mas_bottom).offset(topMargin);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.positionTipLabel.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.positionTipLabel.mas_centerY);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.carTipLabel.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.carTipLabel.mas_centerY);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    
    self.positionTipLabel.layer.cornerRadius = tipLabelHW * 0.5;
    self.positionTipLabel.clipsToBounds = YES;
    
    self.carTipLabel.layer.cornerRadius = tipLabelHW * 0.5;
    self.carTipLabel.clipsToBounds = YES;
    
    
}

- (UILabel *)numLabel {
    
    if (!_numLabel) {
        
        _numLabel = [[UILabel alloc] init];
        _numLabel.font = [UIFont boldSystemFontOfSize:20];
        _numLabel.textColor = txtMainColor;
        _numLabel.text = @"预约码:ABCD";
        //_numLabel.backgroundColor = [UIColor redColor];
    }
    
    return _numLabel;
}

- (UIButton *)cancelBtn {
    
    if (!_cancelBtn) {
        
        _cancelBtn = [[UIButton alloc] initWithFont:16 titleColor:txtPlaceColor title:@"取消订单"];
    }
    
    return _cancelBtn;
}

- (UIView *)sepView {
    
    if (!_sepView) {
        
        _sepView = [UIView new];
        _sepView.backgroundColor = sepLineColor;
    }
    
    return _sepView;
}

- (UILabel *)positionTipLabel {
    
    if (!_positionTipLabel) {
        
        _positionTipLabel = [[UILabel alloc] initWithFont:17 textColor:[UIColor whiteColor] textAlignment:Center text:@"位"];
        
        _positionTipLabel.backgroundColor = PIYellowColor;
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

- (UILabel *)carLabel {
    
    if (!_carLabel) {
        
        _carLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _carLabel.text = @"豫B66666";
    }
    
    return _carLabel;
}

- (UILabel *)carTipLabel {
    
    if (!_carTipLabel) {
        
        _carTipLabel = [[UILabel alloc] initWithFont:17 textColor:[UIColor whiteColor] textAlignment:Center text:@"车"];
        
        _carTipLabel.backgroundColor = UIColorFromRGB(0x7bc161);
    }
    
    return _carTipLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
