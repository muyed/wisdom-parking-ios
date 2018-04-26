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

@property (nonatomic, strong) PILoginDataModel *acountModel;

@end
