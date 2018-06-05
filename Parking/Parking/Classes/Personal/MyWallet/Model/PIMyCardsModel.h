//
//  PIMyCardsModel.h
//  Parking
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PIMyCardsDataModel;

@interface PIMyCardsModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误原因
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) NSMutableArray <PIMyCardsDataModel *> *data;

@end

@interface PIMyCardsDataModel : NSObject

///-- 账户名字
@property (nonatomic, copy) NSString *accountName;
///-- 账号
@property (nonatomic, copy) NSString *bankAccount;
///-- 银行地址
@property (nonatomic, copy) NSString *bankAddr;
///-- 银行代码
@property (nonatomic, assign) NSUInteger bankCode;
///-- 银行名字
@property (nonatomic, copy) NSString *bankName;
///-- 时间
@property (nonatomic, copy) NSString *createTime;
///-- 绑定ID
@property (nonatomic, copy) NSString *ID;
///-- 时间
@property (nonatomic, copy) NSString *modifyTime;
///-- 范围
@property (nonatomic, copy) NSString *ranges;
///-- 分类
@property (nonatomic, copy) NSString *sorts;
///-- 用户id
@property (nonatomic, copy) NSString *userId;
///-- 银行logo
@property (nonatomic, copy, readonly) NSString *bank_logo;

@end
