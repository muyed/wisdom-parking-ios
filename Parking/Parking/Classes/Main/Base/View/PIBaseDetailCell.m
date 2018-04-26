//
//  PIBaseDetailCell.m
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseDetailCell.h"

@interface PIBaseDetailCell ()



@end

@implementation PIBaseDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.commentLabel];
    
    weakself
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(15 * Scale_Y);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(80);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-15 * Scale_Y);
    }];
    
    
}

- (void)setTitleString:(NSString *)titleString {
    
    _titleString = titleString;
    
    self.titleLabel.text = titleString;
}

- (void)setContentString:(NSString *)contentString {
    
    _contentString = contentString;
    
    if ([self.titleString isEqualToString:@"身份证"]) {
        
         self.commentLabel.text = [contentString stringByReplacingCharactersInRange:NSMakeRange(3, contentString.length - 7) withString:@"********"];
        
    }else {
        
         self.commentLabel.text = contentString;
    }
   
}

- (void)setContentColor:(UIColor *)contentColor {
    
    _contentColor = contentColor;
    
    self.commentLabel.textColor = contentColor;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor textAlignment:Left text:nil];
    }
    
    return _titleLabel;
}


- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor textAlignment:Left text:nil];
        
    }
    
    return _commentLabel;
}

@end
