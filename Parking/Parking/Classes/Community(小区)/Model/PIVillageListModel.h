//
//  PIVillageListModel.h
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PIVillageDataModel;

@interface PIVillageListModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误原因
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) NSArray <PIVillageDataModel *> *data;

@end

@interface PIVillageDataModel : NSObject

///-- 地址
@property (nonatomic, copy) NSString *addr;
///-- 区
@property (nonatomic, copy) NSString *area;
///-- 城市
@property (nonatomic, copy) NSString *city;
///-- 小区名
@property (nonatomic, copy) NSString *communityName;
///-- 创建时间
@property (nonatomic, assign) NSInteger createTime;
///-- ID
@property (nonatomic, copy) NSString *ID;
///-- 认证时间
@property (nonatomic, assign) NSInteger modifyTime;
///-- 省份
@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *ranges;

@property (nonatomic, copy) NSString *sorts;

@property (nonatomic, copy) NSString *type;
///-- 小区ID
@property (nonatomic, copy) NSString *communityId;
///-- 楼号
@property (nonatomic, copy) NSString *floorNo;
///-- 房间号
@property (nonatomic, copy) NSString *houseNo;
///-- 单元号
@property (nonatomic, copy) NSString *unitNo;
///-- 用户ID
@property (nonatomic, copy) NSString *userId;

@end
