//
//  NSString+Exrtension.h
//  Parking
//
//  Created by apple on 2018/2/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Exrtension)

/**
 * 判断是否是手机号
 */
- (BOOL)isPhoneNum;

/**
 * 取消空格
 */
- (NSString *)cancelSpace;

/**
 * 是否为存数字
 */
- (BOOL)isNum;

- (BOOL)isChinese;

///-- 验证身份证
- (BOOL)validateIdentityCard;

@end
