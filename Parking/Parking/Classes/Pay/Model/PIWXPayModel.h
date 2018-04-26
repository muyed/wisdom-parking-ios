//
//  PIWXPayModel.h
//  Parking
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PIWXPayDataModel;

@interface PIWXPayModel : NSObject

@property (nonatomic, assign) NSInteger code;
///-- 错误信息
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) PIWXPayDataModel *data;
@end

@interface PIWXPayDataModel : NSObject

///-- 签名
@property (nonatomic, copy) NSString *sign;
///-- 商户ID
@property (nonatomic, copy) NSString *partnerid;
///-- 包名
@property (nonatomic, copy) NSString *package;
///--  描述字符串
@property (nonatomic, copy) NSString *noncestr;
///-- 时间
@property (nonatomic, copy) NSString *timestamp;
///--APPID
@property (nonatomic, copy) NSString *appid;
///-- prepayid
@property (nonatomic, copy) NSString *prepayid;

@end
