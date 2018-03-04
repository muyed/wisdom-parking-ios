//
//  UILabel+Extension.h
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TextAlignmentType) {
    Left = 0,
    Center = 1,
    Right = 2,
};

@interface UILabel (Extension)

/**
 定制创建一个Lable
 
 @param font 字体大小
 @param textColor 文字颜色
 @param textAlignment 对齐方式 TextAlignmentType类型
 @param text 文字内容
 */
- (instancetype)initWithFont:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(TextAlignmentType)textAlignment text:(NSString *)text;


/**
 定制创建一个Label
 
 @param font 字体大小
 @param textColor 文字颜色
 */
- (instancetype)initWithFont:(CGFloat)font textColor:(UIColor *)textColor;


/**
 定制创建一个Label
 
 @param font 字体大小
 @param textColor 文字颜色
 @param text 内容
 */
- (instancetype)initWithFont:(CGFloat)font textColor:(UIColor *)textColor text:(NSString *)text;

@end
