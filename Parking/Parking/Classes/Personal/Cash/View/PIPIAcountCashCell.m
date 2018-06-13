//
//  PIPIAcountCashCell.m
//  Parking
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPIAcountCashCell.h"

@interface PIPIAcountCashCell ()

///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 交押金
@property (nonatomic, strong) UIButton *commitBtn;
///-- 状态
@property (nonatomic, strong) UIButton *statuesBtn;
///-- 金额
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation PIPIAcountCashCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.statuesBtn];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.commitBtn];
    
    weakself
    
    CGFloat margin = 15;
    CGFloat buttonW = 90;
    CGFloat buttonH = 35;
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.equalTo(weakSelf.contentView).offset(margin);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    
    [self.statuesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.tipLabel.mas_centerY);
        make.left.equalTo(weakSelf.tipLabel.mas_right).offset(10);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).offset(-15);
        make.centerY.equalTo(weakSelf);
        make.height.mas_equalTo(buttonH);
        make.width.mas_equalTo(buttonW);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.tipLabel.mas_left);
        make.bottom.equalTo(weakSelf.contentView).offset(-margin);
        make.right.equalTo(weakSelf.commitBtn.mas_left).offset(-10);
    }];
    
    self.commitBtn.layer.cornerRadius = buttonH * 0.5;
    self.commitBtn.clipsToBounds = YES;
    
    [self.commitBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDataModel:(PIMyParkDataModel *)dataModel {
    
    _dataModel = dataModel;
    
    self.tipLabel.text = [NSString stringWithFormat:@"车位号%@", dataModel.carportNum];
    
    [self loadData];
}

- (void)loadData {
    
    if (self.dataModel.deposit.floatValue > 0.00) {
        
        [self.statuesBtn setTitle:@"" forState:UIControlStateNormal];
        [self.statuesBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.commitBtn setTitle:@"提取押金" forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"已交%@元", self.dataModel.deposit];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attStr addAttribute:NSForegroundColorAttributeName value:txtRedColor range:NSMakeRange(2, str.length - 3)];
        
        self.moneyLabel.attributedText = attStr;
        
        
    }else {
        
        [self.statuesBtn setImage:[UIImage imageNamed:@"cash_warm"] forState:UIControlStateNormal];
        [self.statuesBtn setTitle:@"未交" forState:UIControlStateNormal];
        [self.commitBtn setTitle:@"交押金" forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"需交%@元", [PILoginTool defaultTool].carportCashConf];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attStr addAttribute:NSForegroundColorAttributeName value:txtRedColor range:NSMakeRange(2, str.length - 3)];
        
        self.moneyLabel.attributedText = attStr;
        
    }
}

- (void)buttonClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithIndex:)]) {
        
        [self.delegate clickButtonWithIndex:self.index];
    }
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = txtMainColor;
        _tipLabel.font = [UIFont boldSystemFontOfSize:17];
        _tipLabel.text = @"车位号D88";
    }
    
    return _tipLabel;
}

- (UIButton *)statuesBtn {
    
    if (!_statuesBtn) {
        
        _statuesBtn = [[UIButton alloc] init];
        _statuesBtn.titleLabel.font = PISYS_FONT(16);
        [_statuesBtn setTitleColor:txtSeconColor forState:UIControlStateNormal];
    }
    
    return _statuesBtn;
}

- (UIButton *)commitBtn {
    
    if (!_commitBtn) {
        
        _commitBtn = [[UIButton alloc] init];
        _commitBtn.titleLabel.font = PISYS_FONT(16);
        [_commitBtn setBackgroundColor:PIMainColor];
    }
    
    return _commitBtn;
}

- (UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = txtSeconColor;
        //_moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = PISYS_FONT(16);
        _moneyLabel.text = @"已交199.00";
        //_moneyLabel.backgroundColor = [UIColor redColor];
    }
    
    return _moneyLabel;
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
