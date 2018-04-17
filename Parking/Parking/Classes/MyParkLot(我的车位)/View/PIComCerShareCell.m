//
//  PIComCerShareCell.m
//  Parking
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIComCerShareCell.h"

@interface PIComCerShareCell ()

///-- 车位
@property (nonatomic, strong) UILabel *topTipLabel;
///-- 金额提示
@property (nonatomic, strong) UILabel *bottomTipLabel;
///-- 图片
@property (nonatomic, strong) UIImageView *tipImageView;

@end

@implementation PIComCerShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.tipImageView];
    [self.contentView addSubview:self.topTipLabel];
    [self.contentView addSubview:self.bottomTipLabel];
    
    weakself
    CGFloat imageHW = 80;
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(30 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.and.height.mas_equalTo(imageHW);
    }];
    
    [self.topTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.tipImageView.mas_right).offset(10 * Scale_Y);
        make.top.equalTo(weakSelf.tipImageView.mas_top).offset(10);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
    }];
    
    [self.bottomTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.tipImageView.mas_right).offset(10 * Scale_Y);
        make.bottom.equalTo(weakSelf.tipImageView.mas_bottom).offset(-10);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
    }];
}


- (UILabel *)topTipLabel {
    
    if (!_topTipLabel) {
        
        _topTipLabel = [[UILabel alloc] initWithFont:19 textColor:txtMainColor text:@"预定共享车位"];
    }
    
    return _topTipLabel;
}


- (UILabel *)bottomTipLabel {
    
    if (!_bottomTipLabel) {
        
        _bottomTipLabel = [[UILabel alloc] initWithFont:18 textColor:txtSeconColor text:@"免卡进场,出场后支付"];
    }
    
    return _bottomTipLabel;
}

-(UIImageView *)tipImageView {
    
    if (!_tipImageView) {
        
        _tipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_share_car"]];
    }
    
    return _tipImageView;
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
