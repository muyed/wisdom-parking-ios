//
//  PIHomeNoticeCell.m
//  Parking
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeNoticeCell.h"

@interface PIHomeNoticeCell ()

///-- 内容
@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation PIHomeNoticeCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.noticeLabel];
        
        weakself
        [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(weakSelf.contentView);
        }];
    }
    
    return self;
}

- (void)setNotice:(NSString *)notice {
    
    _notice = notice;
    
    self.noticeLabel.text = notice;
}


- (UILabel *)noticeLabel {
    
    if (!_noticeLabel) {
        
        _noticeLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
    }
    
    return _noticeLabel;
}
@end
