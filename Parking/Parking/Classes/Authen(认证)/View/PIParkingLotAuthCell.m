//
//  PIParkingLotAuthCell.m
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIParkingLotAuthCell.h"
#import "PIMyVillageListModel.h"

@interface PIParkingLotAuthCell ()

//-- 号码
@property (nonatomic, strong) UILabel *nameLabel;
///-- 位
@property (nonatomic, strong) UILabel *addTipLabel;
///-- 车牌
@property (nonatomic, strong) UILabel *addLabel;

@end

@implementation PIParkingLotAuthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.addTipLabel];
    [self.contentView addSubview:self.addLabel];
    
    
    
    weakself
    
    CGFloat topMargin = 15 * Scale_Y;
    CGFloat tipLabelHW = 25 * Scale_Y;
    
   
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.contentView).offset(topMargin);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    
    
    [self.addTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(topMargin);
        make.height.and.width.mas_equalTo(tipLabelHW);
    }];
    
    
    
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.addTipLabel.mas_right).offset(8 * Scale_Y);
        make.top.equalTo(weakSelf.addTipLabel.mas_top).offset(2 * Scale_Y);
        make.bottom.equalTo(weakSelf.contentView).offset(-topMargin);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    

    
    self.addTipLabel.layer.cornerRadius = 5 * Scale_Y;
    self.addTipLabel.clipsToBounds = YES;
    
}

- (void)setModel:(PIMyVillageCarportModel *)model {
    
    _model = model;
    self.nameLabel.text = model.carportNum.length == 0 ? @"" : model.carportNum;
    //self.addLabel.text = model.addr.length == 0 ? @"" : model.addr;
}

- (void)setAddress:(NSString *)address {
    
    _address = address;
    
    self.addLabel.text = address;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textColor = txtMainColor;
        //_nameLabel.text = @"马尔代夫";
        //_nameLabel.backgroundColor = [UIColor redColor];
    }
    
    return _nameLabel;
}



- (UILabel *)addLabel {
    
    if (!_addLabel) {
        
        _addLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        //_addLabel.text = @"规划二路1号";
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
