//
//  PIImageUpBtn.m
//  Parking
//
//  Created by apple on 2018/3/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIImageUpBtn.h"

@implementation PIImageUpBtn

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //-- 调整图片
    self.imageView.y = self.height * 0.2;
    self.imageView.width = 25;
    self.imageView.height = 25;
    self.imageView.centerX = self.width * 0.5;
    
    //-- 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
