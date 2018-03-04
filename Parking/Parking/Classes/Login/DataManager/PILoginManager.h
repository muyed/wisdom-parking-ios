//
//  PILoginManager.h
//  Parking
//
//  Created by apple on 2018/2/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PICodeType) {
    
    PICodeTypeLogin = 0,
    PICodeTypeRegistr
};
@interface PILoginManager : NSObject


/**
   获取注册验证码

 @param phoneNum 电话号码
 @param type 类型
 @param success 成功
 @param failue 失败
 */
+ (void)getVerificationCodeWithPhoneNum:(NSString *)phoneNum
                                   type:(PICodeType)type
                                success:(void (^)(id response))success
                                 failue:(void (^)(NSError *error))failue;


/**
 注册

 @param phoneNum 手机号
 @param phoneCode 验证码或者密码
 @param success 成功回调
 @param failue 失败回调
 */
+ (void)registerCountWithPhoneNum:(NSString *)phoneNum
                        phoneCode:(NSString *)phoneCode
                         userName:(NSString *)userName
                         passWord:(NSString *)passWord
                          success:(void (^)(id response))success
                           failue:(void (^)(NSError *error))failue;


/**
 登录

 @param count 账号
 @param code 密码或者验证码
 @param loginType 登录类型
 @param success 成功
 @param failue 失败
 */
+ (void)loginWithCount:(NSString *)count
                  code:(NSString *)code
                  type:(BOOL)loginType
             countType:(NSNumber *)countType
               success:(void (^)(id response))success
                failue:(void (^)(NSError *error))failue;


@end
