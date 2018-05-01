//
//  PIAddCarHeaderView.m
//  Parking
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddCarHeaderView.h"

@interface PIAddCarHeaderView ()

///-- title
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation PIAddCarHeaderView

+ (instancetype)addcarHeaderView:(UITableView *)tableView {
    
    PIAddCarHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([PIAddCarHeaderView class])];
    
    if (!headerView) {
        
        headerView = [[PIAddCarHeaderView alloc] init];
    }
    
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        
        weakself
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.contentView).offset(15);
            make.right.equalTo(weakSelf.contentView).offset(15);
            make.centerY.equalTo(weakSelf.contentView);
    
        }];
    }
    
    return self;
}

- (void)setTitles:(NSString *)titles {
    
    _titles = titles;
    self.titleLabel.text = titles;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:17 textColor:txtMainColor];
    }
    
    return _titleLabel;
}

@end
