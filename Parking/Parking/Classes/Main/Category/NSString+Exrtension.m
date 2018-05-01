//
//  NSString+Exrtension.m
//  Parking
//
//  Created by apple on 2018/2/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "NSString+Exrtension.h"

@implementation NSString (Exrtension)

/**
 * 判断是否是手机号
 */
- (BOOL)isPhoneNum
{
    ///    电信号段:133/153/180/181/189/177
    ///    联通号段:130/131/132/155/156/185/186/145/176
    ///    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    ///    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:self];
}

/**
 * 取消空格
 */
- (NSString *)cancelSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/*判断是否为纯数字*/
- (BOOL)isNum {
    
    if([self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length > 0) {
        
        return NO;
        
    }
    return YES;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)validateIdentityCard
{
    if (self.length == 15) {
        //|  地址  |   年    |   月    |   日    |
        NSString *regex = @"^(\\d{6})([3-9][0-9][01][0-9][0-3])(\\d{4})$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [identityCardPredicate evaluateWithObject:self];
    } else if (self.length == 18) {
        //|  地址  |      年       |   月    |   日    |
        NSString *regex = @"^(\\d{6})([1][9][3-9][0-9][01][0-9][0-3])(\\d{4})(\\d|[xX])$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [identityCardPredicate evaluateWithObject:self];
    } else {
        return NO;
    }
}

+ (NSString *)getWeekDay:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
   // NSDate *date = [self getDateWithString:dateString];
    
    NSArray *weekdays = @[@" ",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *components = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:components.weekday];
}

+ (NSString *)getDay:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateString];
    
    [formatter setDateFormat:@"MM-dd"];
    
    NSString *lastStr = [formatter stringFromDate:date];
    
    return lastStr;
}

+ (NSString *)getTime:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateString];
    
    [formatter setDateFormat:@"HH:mm"];
    
    NSString *lastStr = [formatter stringFromDate:date];
    
    return lastStr;
    
}
+ (NSDate *)getDateWithString:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return  [formatter dateFromString:dateString];
}
@end
