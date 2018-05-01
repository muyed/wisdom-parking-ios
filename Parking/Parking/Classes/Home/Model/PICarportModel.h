//
//  PICarportModel.h
//  Parking
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PICarportDataModel;

@interface PICarportModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误原因
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, copy) NSArray<PICarportDataModel *> *data;

@end

@interface PICarportDataModel : NSObject

///-- 地址
@property (nonatomic, copy) NSString *addr;
///-- 区
@property (nonatomic, copy) NSString *area;
///--  车位ID
@property (nonatomic, copy) NSString *carportId;
///-- 车锁ID
@property (nonatomic, copy) NSString *carportMeid;
///-- 车位号
@property (nonatomic, copy) NSString *carportNum;
///-- 城市
@property (nonatomic, copy) NSString *city;
///-- 小区ID
@property (nonatomic, copy) NSString *communityId;
///-- 小区名字
@property (nonatomic, copy) NSString *communityName;
///-- 小区类型
@property (nonatomic, copy) NSString *communityType;
///-- 创建时间
@property (nonatomic, copy) NSString *createTime;
///-- id
@property (nonatomic, copy) NSString *ID;
///-- 经度
@property (nonatomic, assign) CGFloat lat;
///-- 纬度
@property (nonatomic, assign) CGFloat lon;
///-- 认证时间
@property (nonatomic, copy) NSString *modifyTime;
///-- ID
@property (nonatomic, copy) NSString *parkingTicketId;
///-- 单价
@property (nonatomic, copy) NSString *price;
///-- 省份
@property (nonatomic, copy) NSString *province;
///-- 范围
@property (nonatomic, copy) NSString *ranges;
///-- 分享单号
@property (nonatomic, copy) NSString *shareNum;
///-- 排序
@property (nonatomic, copy) NSString *sorts;
///-- 开始时间
@property (nonatomic, copy) NSString *startTime;
///-- 状态
@property (nonatomic, assign) NSInteger status;
///-- 结束时间
@property (nonatomic, copy) NSString *stopTime;
///-- 用户ID
@property (nonatomic, copy) NSString *userId;
///-- 周几
@property (nonatomic, copy) NSString *startWeekDay;
///-- 周几
@property (nonatomic, copy) NSString *stopWeekDay;
///-- 几月几号
@property (nonatomic, copy) NSString *startDay;
///-- 几月几号
@property (nonatomic, copy) NSString *stopDay;
///-- 几点几分
@property (nonatomic, copy) NSString *startHour;
///-- 几点几分
@property (nonatomic, copy) NSString *stopHour;

@end
