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

+ (void)AlipayForOrderWithOrderNum:(NSString *)orderNum;

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


/**
 绑定银行卡

 @param acount 账号
 @param name 名字
 @param success 成功
 @param failue 失败
 */

/**
 绑定银行卡
 
 @param acount 账号
 @param name 名字
 @param address 地址
 @param bankCode 代码
 @param success 成功
 @param failue 失败
 */
+ (void)bindBankCardWithAcount:(NSString *)acount
                          name:(NSString *)name
                      bankAddr:(NSString *)address
                      bankCode:(NSString *)bankCode
                       success:(void(^)(id response))success
                        failue:(void (^)(NSError *error))failue;



/**
 提现

 @param cardID 银行卡ID
 @param success 成功
 @param failue 失败
 */
+ (void)withdrawCashWithBankCardID:(NSString *)cardID
                            success:(void(^)(id response))success
                             failue:(void (^)(NSError *error))failue;
@end
