//
//  PIOrderModel.h
//  Parking
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PIOrderListData;

@interface PIOrderModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误信息
@property (nonatomic, copy) NSString *errMsg;
///-- 数据
@property (nonatomic, copy) NSArray<PIOrderListData *> *data;

@end

@interface PIOrderListData : NSObject

///-- 结束时间
@property (nonatomic, copy) NSString *appointmentEndTime;
///-- 开始时间
@property (nonatomic, copy) NSString *appointmentStartTime;
///-- 区域
@property (nonatomic, copy) NSString *area;
///-- 车牌
@property (nonatomic, copy) NSString *carLicense;
///-- 车位ID
@property (nonatomic, copy) NSString *carportId;
///-- 车位锁ID
@property (nonatomic, copy) NSString *carportMeid;
///-- 车位编号
@property (nonatomic, copy) NSString *carportNum;
///-- 城市
@property (nonatomic, copy) NSString *city;
///-- 小区ID
@property (nonatomic, copy) NSString *communityId;
///-- 创建时间
@property (nonatomic, copy) NSString *createTime;
///-- 结束时间
@property (nonatomic, copy) NSString *endTime;
///-- id
@property (nonatomic, copy) NSString *ID;
///-- 认证时间
@property (nonatomic, copy) NSString *modifyTime;
///-- 开锁编码
@property (nonatomic, copy) NSString *openCode;
///-- <#Notes#>
@property (nonatomic, copy) NSString *overdue;
///-- <#Notes#>
@property (nonatomic, copy) NSString *overdueFee;
///-- 停车费
@property (nonatomic, copy) NSString *parkingFee;
///-- 分享ID
@property (nonatomic, copy) NSString *parkingShareId;
///-- 支付时间
@property (nonatomic, copy) NSString *payDeadlineTime;
///-- 手机号
@property (nonatomic, copy) NSString *phone;
///-- 价格
@property (nonatomic, copy) NSString *price;
///-- 省份
@property (nonatomic, copy) NSString *province;
///-- <#Notes#>
@property (nonatomic, copy) NSString *ranges;
///-- <#Notes#>
@property (nonatomic, copy) NSString *sorts;
///-- 开始时间
@property (nonatomic, copy) NSString *startTime;
///-- <#Notes#>
@property (nonatomic, assign) NSInteger status;
///-- 订单号
@property (nonatomic, copy) NSString *ticketNum;
///-- 用户ID
@property (nonatomic, copy) NSString *userId;
@end


