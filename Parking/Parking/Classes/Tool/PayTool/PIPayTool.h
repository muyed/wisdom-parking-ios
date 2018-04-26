//
//  PIPayTool.h
//  Parking
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WXApi.h"

@protocol PIPayManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

@end


@interface PIPayTool : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<PIPayManagerDelegate> delegate;

+ (instancetype)sharedManager;


/**
 支付宝支付

 @param orderNum 订单号
 @param success 成功
 @param failue 失败
 */
+ (void)AlipayForOrderWithOrderNum:(NSString *)orderNum
                           success:(void (^)(id response))success
                            failue:(void (^)(NSError *error))failue;


/**
 微信支付
 
 @param orderNum 订单号
 @param success 成功
 @param failue 失败
 */
+ (void)WXpayForOrderWithOrderNum:(NSString *)orderNum
                           success:(void (^)(id response))success
                            failue:(void (^)(NSError *error))failue;

+ (void)WXpayForOrderWithOrderNum:(NSString *)orderNum;

/**
 支付账户押金

 @param success 成功
 */
+ (void)payForAcountCash:(void (^)(NSString *orderNum))success;
@end
