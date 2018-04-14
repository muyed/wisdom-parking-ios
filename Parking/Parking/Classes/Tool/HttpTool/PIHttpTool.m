//
//  PIHttpTool.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHttpTool.h"
#import <AFNetworking.h>

@implementation PIHttpTool

- (AFHTTPSessionManager *)manager {
    
    if (!_manager) {
        
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

+ (instancetype)shareAFManager {
    
    static dispatch_once_t onceToken;
    static PIHttpTool *requestTool = nil;
    
    dispatch_once(&onceToken, ^{
        
        requestTool = [[PIHttpTool alloc] init];
    });
    
    return requestTool;
}

+ (void)piGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError * error))failure {
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSLog(@"请求路径: %@", url);
//    NSLog(@"参数: %@", params);
//    manager.requestSerializer =[AFJSONRequestSerializer serializer];
//
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"image/jpeg",@"image/png", @"text/plain", @"text/html", nil];
    
    AFHTTPSessionManager *manager = [self getHttpManager];
   // manager.responseSerializer =[AFJSONResponseSerializer serializer];
    NSLog(@"请求地址--->%@",url);
    NSLog(@"请求参数-->%@",params);
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success?success(responseObject):nil;
        NSLog(@"成功回调: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure?failure(error):nil;
        
        NSLog(@"失败回调: %@", error);
    }];
    
}
    
+ (void)piPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    
    
    
    AFHTTPSessionManager *manager = [self getHttpManager];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            NSLog(@"请求地址--->%@",url);
            NSLog(@"请求参数-->%@",params);
            NSLog(@"成功回调-->%@",responseObject);
            success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            NSLog(@"请求地址--->%@",url);
            NSLog(@"请求参数-->%@",params);
            NSLog(@"失败回调--->%@",error);
            
            NSString *errorResult = [error localizedDescription];
            NSLog(@"%@",errorResult);
            failure(error);
            
        }
        
    }];
    
    
//    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFormData:jsonData name:@"data"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if (success) {
//
//            NSLog(@"请求地址--->%@",url);
//            NSLog(@"请求参数-->%@",params);
//            NSLog(@"成功回调-->%@",responseObject);
//            success(responseObject);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if (failure) {
//            NSLog(@"请求地址--->%@",url);
//            NSLog(@"请求参数-->%@",params);
//            NSLog(@"失败回调--->%@",error);
//
//            NSString *errorResult = [error localizedDescription];
//            NSLog(@"%@",errorResult);
//            failure(error);
//
//        }
//
//    }];
    
}

//+ (void)piPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//
//    AFHTTPSessionManager *manager = [self getHttpManager];
//
//    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFormData:jsonData name:@"data"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if (success) {
//
//            NSLog(@"请求地址--->%@",url);
//            NSLog(@"请求参数-->%@",params);
//            NSLog(@"成功回调-->%@",responseObject);
//            success(responseObject);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if (failure) {
//            NSLog(@"请求地址--->%@",url);
//            NSLog(@"请求参数-->%@",params);
//            NSLog(@"失败回调--->%@",error);
//
//            NSString *errorResult = [error localizedDescription];
//            NSLog(@"%@",errorResult);
//            failure(error);
//
//        }
//
//    }];
//
//}

+ (void)getCookieWithPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    
    AFHTTPSessionManager *manaager = [self getHttpManager];

    [manaager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {


    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success) {

            NSLog(@"请求地址--->%@",url);
            NSLog(@"请求参数-->%@",params);
            NSLog(@"成功回调-->%@",responseObject[@"errMsg"]);
            NSLog(@"成功回调-->%@",responseObject);
            
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            NSString *session = [cookieString substringWithRange:NSMakeRange(8, 36)];
            NSLog(@"----> %@", session);
            
            if (session) {
            
                [PIUserDefaults setObject:session forKey:SessionId];
                [PIUserDefaults synchronize];
            }
            
            
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"请求地址--->%@",url);
        NSLog(@"请求参数-->%@",params);
        NSLog(@"失败回调--->%@",error);

        NSString *errorResult = [error localizedDescription];
        NSLog(@"%@",errorResult);
        failure(error);

    }];
//
   // NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];

   // AFHTTPSessionManager *manager = [self getHttpManager];
  //  [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

//    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFormData:jsonData name:@"data"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if (success) {
//
//            NSLog(@"请求地址--->%@",url);
//            NSLog(@"请求参数-->%@",params);
//            NSLog(@"成功回调-->%@",responseObject);
//
//            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
//            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
//            NSString *session = [cookieString substringWithRange:NSMakeRange(8, 36)];
//
//            if (session) {
//
//                [PIUserDefaults setObject:session forKey:@"sessionid"];
//                [PIUserDefaults synchronize];
//            }
//
//            success(responseObject);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if (failure) {
//            NSLog(@"请求地址--->%@",url);
//            NSLog(@"请求参数-->%@",params);
//            NSLog(@"失败回调--->%@",error);
//
//            NSString *errorResult = [error localizedDescription];
//            NSLog(@"%@",errorResult);
//            failure(error);
//
//        }
//
//    }];

    
}
+ (AFHTTPSessionManager *)getHttpManager {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //申明返回的结果是json类型
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求为JOSN类型
    manager.requestSerializer =[AFJSONRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 20;
    
   // manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"image/jpeg",@"image/png", @"text/plain", @"text/html", nil];
    
//    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"keystore" ofType:@"cer"];
//    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
//    NSSet *certSet = [NSSet setWithObject:certData];
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:certSet];
//    policy.allowInvalidCertificates = YES;
//    policy.validatesDomainName = NO;
//    [manager setSecurityPolicy:policy];
    
    return manager;
}


@end
