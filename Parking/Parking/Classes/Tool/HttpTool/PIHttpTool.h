//
//  PIHttpTool.h
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

@interface PIHttpTool : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (instancetype)shareAFManager;

/**
 Get请求

 @param url 请求路径
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)piGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


/**
 Post请求

 @param url 请求路径
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)piPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

+ (void)getCookieWithPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end
