//
//  UIButton+Extension.h
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)initWithImageName:(NSString *)imageName;

- (instancetype)initWithImageName:(NSString *)imageName
                             font:(CGFloat)font
                       titleColor:(UIColor *)titleColor
                            title:(NSString *)title;

- (instancetype)initWithFont:(CGFloat)font titleColor:(UIColor *)titleColor title:(NSString *)title;

@end
