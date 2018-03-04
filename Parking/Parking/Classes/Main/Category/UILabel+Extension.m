//
//  UILabel+Extension.m
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (instancetype)initWithFont:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(TextAlignmentType)textAlignment text:(NSString *)text
{
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:font];
        self.textColor = textColor;
        self.textAlignment = (NSInteger)textAlignment;
        self.text = text;
    }
    return self;
}

- (instancetype)initWithFont:(CGFloat)font textColor:(UIColor *)textColor
{
    return [self initWithFont:font textColor:textColor textAlignment:Left text:nil];
}

- (instancetype)initWithFont:(CGFloat)font textColor:(UIColor *)textColor text:(NSString *)text
{
    return [self initWithFont:font textColor:textColor textAlignment:Left text:text];
}

@end
