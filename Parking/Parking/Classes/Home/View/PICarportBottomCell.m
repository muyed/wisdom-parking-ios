//
//  PICarportBottomCell.m
//  Parking
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarportBottomCell.h"
#import "PICarportBottomCell.h"
#import "PICarportModel.h"

@interface PICarportBottomCell ()

///-- 原点
@property (nonatomic, strong) UILabel *circleLabel;
///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 价格
@property (nonatomic, strong) UILabel *moneyLabel;
///-- 匹配按钮
@property (nonatomic, strong) UIButton *matchBtn;

@end

@implementation PICarportBottomCell
{
    
    NSInteger _index;
}
+ (instancetype)initWithTableView:(UITableView *)tableview index:(NSInteger)index {
    
    PICarportBottomCell *cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([PICarportBottomCell class])];
    
    if (!cell) {
        
        cell = [[PICarportBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PICarportBottomCell class]) index:index];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSInteger)index{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUIWithIndex:index];
    }
    
    return self;
}

- (void)setupUIWithIndex:(NSInteger)index {
    
    
    weakself
    _index = index;
    CGFloat margin;
    
    if (index == 3) {
        
        [self.contentView addSubview:self.matchBtn];
        
        [self.matchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.contentView).offset(-15);
            make.centerY.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(60);
        }];
        
        margin = -85;
        self.circleLabel.backgroundColor = PIYellowColor;
        self.tipLabel.text = @"车位78BSSUU";
        
    }else {
        
        [self.contentView addSubview:self.moneyLabel];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.contentView).offset(-15);
            make.centerY.equalTo(weakSelf.contentView);
            make.width.mas_equalTo(80);
        }];
        
        margin = -105;
        self.circleLabel.backgroundColor = PIGreenColor;
        self.tipLabel.text = @"当前价格";
    }
  
    [self.contentView addSubview:self.circleLabel];
    [self.contentView addSubview:self.tipLabel];
    
    [self.circleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.and.width.mas_equalTo(15);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.circleLabel.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(margin);
    }];
    
    [self.matchBtn addTarget:self action:@selector(matchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)matchBtnClick {
    
    if (self.matchCarport) {
        
        self.matchCarport();
    }
}
- (void)setModel:(PICarportDataModel *)model {
    
    _model = model;
    
    if (_index == 2) {
        
        self.moneyLabel.text = [NSString stringWithFormat:@"%@元/小时", model.price];
        
    }else {
        
        self.tipLabel.text = [NSString stringWithFormat:@"车位: %@", model.carportNum];
    }
    
}

- (UIButton *)matchBtn {
    
    if (!_matchBtn) {
        
        _matchBtn = [[UIButton alloc] initWithTitle:@"去匹配"];
        _matchBtn.titleLabel.font = PISYS_FONT(15);
        _matchBtn.layer.borderColor = PIYellowColor.CGColor;
        _matchBtn.layer.borderWidth = 1.0;
        _matchBtn.layer.cornerRadius = 5.0;
        _matchBtn.clipsToBounds = YES;
        [_matchBtn setTitleColor:PIYellowColor forState:UIControlStateNormal];
    }
    
    return _matchBtn;
}

- (UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        
        _moneyLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.text = @"2元/小时";
    }
    
    return _moneyLabel;
}

- (UILabel *)circleLabel {
    
    if (!_circleLabel) {
        
        _circleLabel = [[UILabel alloc] init];
        _circleLabel.layer.cornerRadius = 7.5;
        _circleLabel.clipsToBounds = YES;
    }
    
    return _circleLabel;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:18 textColor:txtSeconColor];

    }
    
    return _tipLabel;
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
