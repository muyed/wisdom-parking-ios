//
//  PILeftImageBtn.m
//  Parking
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILeftImageBtn.h"

@implementation PILeftImageBtn

- (void)setup
{
    //self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:txtMainColor forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.backgroundColor = [UIColor whiteColor];
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
    //[self setup];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //-- 调整图片
    self.imageView.x = self.width * 0.15;
    self.imageView.width = 50;
    self.imageView.height = 50;
    self.imageView.y = 25;
    
    //-- 调整文字
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + 15;
    self.titleLabel.centerY = self.imageView.centerY;
    self.titleLabel.width = self.width - self.imageView.width - 5;
    self.titleLabel.height = 20;
    
    
}

@end
