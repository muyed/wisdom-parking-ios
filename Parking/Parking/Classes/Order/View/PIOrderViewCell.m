//
//  PIOrderViewCell.m
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIOrderViewCell.h"
#import "PIMyVillageListModel.h"

@interface PIOrderViewCell ()

///-- 预约码
@property (nonatomic, strong) UILabel *numLabel;
///-- 状态
@property (nonatomic, strong) UILabel *statuesLabel;
///-- 位置
@property (nonatomic, strong) UILabel *positionLabel;
///-- 时间
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation PIOrderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.statuesLabel];
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.positionLabel];
    [self.contentView addSubview:self.timeLabel];
    
    weakself
    CGFloat statuesLabelW = 100 * Scale_Y;
    
    [self.statuesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.width.mas_equalTo(statuesLabelW);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.statuesLabel.mas_left).offset(-10);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.bottom.equalTo(weakSelf.contentView).offset(-15);
        make.right.equalTo(weakSelf.contentView).offset(-5);
    }];
}

- (void)setModel:(PIMyVillageDataModel *)model {
    
    _model = model;
    
    self.numLabel.text = model.communityName.length == 0 ? @"" : model.communityName;
    self.positionLabel.text = [NSString stringWithFormat:@"%@ %@", model.province.length == 0 ? @"" : model.province, model.city.length == 0 ? @"" : model.city];
    self.timeLabel.text = model.addr.length == 0 ? @"" : model.addr;
    
    switch (model.type) {
            
        case 1: {
            
            self.statuesLabel.text = @"审核中";
            self.statuesLabel.textColor = PIMainColor;
            
        }
            break;
            
        case 2:{
            
            self.statuesLabel.text = @"已认证";
            self.statuesLabel.textColor = UIColorFromRGB(0x52c41a);
            
        }
            
            break;
            
        case 3:{
            
            self.statuesLabel.text = @"已拒绝";
            self.statuesLabel.textColor = UIColorFromRGB(0xf5222d);

        }
            
            break;
            
            
        default:
            
            
            break;
    }
}

- (void)setListModel:(PIOrderListData *)listModel {
    
    _listModel = listModel;
    
    self.numLabel.text = listModel.openCode;
    self.positionLabel.text = [NSString stringWithFormat:@"%@%@", listModel.province, listModel.area];
    self.timeLabel.text = [NSString stringWithFormat:@"预约时间:%@", listModel.appointmentStartTime];
    
    switch (listModel.status) {
        case 0:
            
            [self setStatuesWithMessage:@"待支付" color:PIMainColor];
            
            break;
        
        case 1:
            
            [self setStatuesWithMessage:@"已支付" color:nil];
            break;
            
        case 2:
            
            
            [self setStatuesWithMessage:@"停车中" color:PIGreenColor];
            break;
            
        case 3:
            
            [self setStatuesWithMessage:@"已逾期" color:txtRedColor];
            break;
        
        case 4:
            
            [self setStatuesWithMessage:@"已完成" color:nil];
            break;
        
        case 5:
            
            [self setStatuesWithMessage:@"待支付(逾期)" color:PIMainColor];
            
            break;
            
        case 6:
            
            [self setStatuesWithMessage:@"已完成(逾期)" color:nil];
            
            break;
        
        case 7:
            
            [self setStatuesWithMessage:@"已取消" color:nil];
            
            break;
            
        default:
            break;
    }
}

- (void)setStatuesWithMessage:(NSString *)msg color:(UIColor *)color {
    
    self.statuesLabel.text = msg;
    self.statuesLabel.textColor = color == nil ? txtSeconColor : PIMainColor;
}
- (UILabel *)numLabel {
    
    if (!_numLabel) {
        
        _numLabel = [[UILabel alloc] init];
        _numLabel.font = [UIFont boldSystemFontOfSize:18];
        _numLabel.textColor = txtMainColor;
        _numLabel.text = @"预约码:ABCD";
        //_numLabel.backgroundColor = [UIColor redColor];
    }
    
    return _numLabel;
}

- (UILabel *)statuesLabel {
    
    if (!_statuesLabel) {
        
        _statuesLabel = [[UILabel alloc] initWithFont:16 textColor:PIMainColor];
        _statuesLabel.textAlignment = NSTextAlignmentRight;
        _statuesLabel.text = @"未支付";
        //_statuesLabel.backgroundColor = [UIColor yellowColor];
        
    }
    
    return _statuesLabel;
}

- (UILabel *)positionLabel {
    
    if (!_positionLabel) {
        
        _positionLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _positionLabel.text = @"负四层055";
    }
    
    return _positionLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] initWithFont:17 textColor:txtSeconColor];
        _timeLabel.text = @"预约时间: 2018-03-25 15:28:57";
    }
    
    return _timeLabel;
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
