//
//  UIButton+Extension.m
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName
{
    return [self initWithImageName:imageName font:0 titleColor:nil title:nil];
}

- (instancetype)initWithFont:(CGFloat)font titleColor:(UIColor *)titleColor title:(NSString *)title
{
    return [self initWithImageName:nil font:font titleColor:titleColor title:title];
}


- (instancetype)initWithImageName:(NSString *)imageName
                             font:(CGFloat)font
                       titleColor:(UIColor *)titleColor
                            title:(NSString *)title
{
    if (self = [super init]) {
        if (imageName != nil) {
            [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] forState:UIControlStateSelected];
            [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
        }
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = PISYS_FONT(font);
    }
    return self;
}

@end
