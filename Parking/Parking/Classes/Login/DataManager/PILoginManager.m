//
//  PILoginManager.m
//  Parking
//
//  Created by apple on 2018/2/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILoginManager.h"

@implementation PILoginManager

/*获取验证码*/
+ (void)getVerificationCodeWithPhoneNum:(NSString *)phoneNum type:(PICodeType)type success:(void (^)(id))success failue:(void (^)(NSError *))failue {
    
    
    NSString *url;
    
    if (type) {
        
        url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/reg/sms/"),phoneNum];
    }else {
        
        url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/login/sms/"),phoneNum];
    }
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        success ? success(response) : nil;
        
    } failure:^(NSError *error) {
        
        failue ? failue(error) : nil;
        
    }];
}

/*注册*/

+ (void)registerCountWithPhoneNum:(NSString *)phoneNum phoneCode:(NSString *)phoneCode userName:(NSString *)userName passWord:(NSString *)passWord success:(void (^)(id))success failue:(void (^)(NSError *))failue {
    

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phoneNum;
    params[@"code"] = phoneCode;
    params[@"username"] = userName;
    params[@"password"] = passWord;
    
    [PIHttpTool piPost:urlPath(@"api/reg") params:params success:^(id response) {
        
        success ? success(response) : nil;
        
    } failure:^(NSError *error) {
        
        failue ? failue(error) : nil;
    }];
}

/*登录*/
+ (void)loginWithCount:(NSString *)count code:(NSString *)code type:(BOOL)loginType countType:(NSNumber *)countType success:(void (^)(id))success failue:(void (^)(NSError *))failue {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    if (loginType) {
//        
//        params[@"phone"] = count;
//        params[@"code"] = code;
//    
//    }else {
//        
//       
//    }
    params[@"username"] = count;
    params[@"password"] = code;
    params[@"type"] = countType;
    
    [PIHttpTool getCookieWithPost:urlPath(@"api/login") params:params success:^(id response) {
        
         success ? success(response) : nil;
        
    } failure:^(NSError *error) {
        
        failue ? failue(error) : nil;
        
    }];
   
}
@end
