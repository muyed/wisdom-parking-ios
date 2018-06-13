//
//  PILoginTool.h
//  Parking
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PILoginModel.h"

@interface PILoginTool : NSObject

+ (instancetype)defaultTool;

+ (void)loginOut;

+ (void)saveAcountInfo:(NSDictionary *)dict;

- (PILoginDataModel *)getAcountInfo;

///-- 是否身份认证
@property (nonatomic, assign) BOOL isIdentiAuthen;
///-- 是否有小区
@property (nonatomic, assign) BOOL hasVillage;
///-- 是否有车位
@property (nonatomic, assign) BOOL hasCarPot;
///-- 是否缴纳押金
@property (nonatomic, assign) BOOL hasCash;
///-- 余额
@property (nonatomic, assign) CGFloat balance;
///-- 账户押金
@property (nonatomic, assign) CGFloat cash;
///-- 押金配置
@property (nonatomic, copy) NSString *accountCashConf;
///-- 车位
@property (nonatomic, copy) NSString *carportCashConf;

@property (nonatomic, strong) PILoginDataModel *acountModel;

///-- 更新余额
- (void)updateBalance:(CGFloat)balance;
///-- 更新账户押金
- (void)updateAcountCash:(CGFloat)cash;

@end
