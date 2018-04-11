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
    //self.titleLabel.font = [UIFont systemFontOfSize:16 * Scale_Y];
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
    self.imageView.x = self.width * 0.1;
    self.imageView.width = 40 * Scale_Y;
    self.imageView.height = 40 * Scale_Y;
    self.imageView.centerY = self.height * 0.5;
    
    //-- 调整文字
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + 5;
    self.titleLabel.centerY = self.imageView.centerY;
    self.titleLabel.width = self.width - self.imageView.width - 5;
    self.titleLabel.height = 20 * Scale_Y;
    
    
}

@end
