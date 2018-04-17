//
//  PIComCerBtnCell.m
//  Parking
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIComCerBtnCell.h"
#import "PILeftImageBtn.h"

@interface PIComCerBtnCell ()

///-- 共享
@property (nonatomic, strong) PILeftImageBtn *shareBtn;
///-- 解锁
@property (nonatomic, strong) PILeftImageBtn *openBtn;

@end

@implementation PIComCerBtnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = PIBackColor;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.shareBtn];
    [self.contentView addSubview:self.openBtn];
    
    weakself
    
    CGFloat btnW = (SCREEN_WIDTH - 2) * 0.5;
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.and.left.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(btnW);
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.and.bottom.and.top.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(btnW);
    }];
    
}

- (PILeftImageBtn *)openBtn {
    
    if (!_openBtn) {
        
        _openBtn = [PILeftImageBtn new];
        [_openBtn setTitle:@"解锁" forState:UIControlStateNormal];
        _openBtn.titleLabel.font = PISYS_FONT(17);
        [_openBtn setImage:[UIImage imageNamed:@"com_open"] forState:UIControlStateNormal];
        
    }
    
    return _openBtn;
}

- (PILeftImageBtn *)shareBtn {
    
    if (!_shareBtn) {
        
        _shareBtn = [PILeftImageBtn new];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = PISYS_FONT(17);
        [_shareBtn setImage:[UIImage imageNamed:@"com_share"] forState:UIControlStateNormal];
        
    }
    
    return _shareBtn;
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
