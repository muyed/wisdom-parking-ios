//
//  PIPayTool.h
//  Parking
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIPayTool : NSObject


/**
 支付宝支付

 @param orderNum 订单号
 @param success 成功
 @param failue 失败
 */
+ (void)AlipayForOrderWithOrderNum:(NSString *)orderNum
                           success:(void (^)(id response))success
                            failue:(void (^)(NSError *error))failue;

@end
