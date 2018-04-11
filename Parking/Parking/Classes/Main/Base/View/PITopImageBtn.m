//
//  PITopImageBtn.m
//  Parking
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PITopImageBtn.h"

@implementation PITopImageBtn

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //-- 调整图片
    self.imageView.y = self.height * 0.1;
    self.imageView.width = self.width * 0.4;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    //-- 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    
}


@end
