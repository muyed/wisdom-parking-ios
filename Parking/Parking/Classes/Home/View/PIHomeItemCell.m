//
//  PIHomeItemCell.m
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeItemCell.h"

@interface PIHomeItemCell ()

///-- 图片
@property (nonatomic, strong) UIImageView *tmpImageView;
///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PIHomeItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.tmpImageView];
    [self.contentView addSubview:self.titleLabel];
    
    CGFloat imageViewHW = 20;
    
    weakself
    [self.tmpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.width.and.height.mas_equalTo(imageViewHW);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.and.left.and.bottom.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.tmpImageView.mas_bottom).offset(5);
    }];
    
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}
#pragma mark -- 懒加载
- (UIImageView *)tmpImageView {
    
    if (!_tmpImageView) {
        
        _tmpImageView = [[UIImageView alloc] init];
        //_tmpImageView.backgroundColor = [UIColor redColor];
    }
    
    return _tmpImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = txtMainColor;
        _titleLabel.font = PISYS_FONT(15);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected {

    if (selected) {

        _titleLabel.textColor = PIMainColor;

    }else {

        _titleLabel.textColor = txtMainColor;
    }
}

@end
