//
//  PIMyVillageListModel.h
//  Parking
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PIMyVillageDataModel;


@interface PIMyVillageListModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误原因
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) NSArray <PIMyVillageDataModel *> *data;

@end


@class PIMyVillageCarportModel;

@interface PIMyVillageDataModel : NSObject

///-- 区
@property (nonatomic, copy) NSString *area;
///-- 小区类型
@property (nonatomic, assign) NSInteger communityType;
///-- 省份
@property (nonatomic, copy) NSString *province;
///-- 城市
@property (nonatomic, copy) NSString *city;
///-- 小区名字
@property (nonatomic, copy) NSString *communityName;
///-- 小区地址
@property (nonatomic, copy) NSString *addr;
///-- 状态
@property (nonatomic, assign) NSInteger type;
///-- 小区id
@property (nonatomic, copy) NSString *communityId;
///-- 拒绝理由
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, strong) NSArray <PIMyVillageCarportModel *> *carportList;

@end

@interface PIMyVillageCarportModel : NSObject

@property (nonatomic, copy) NSString *sorts;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *ranges;

@property (nonatomic, copy) NSString *communityModuleId;

@property (nonatomic, copy) NSString *communityId;

@property (nonatomic, copy) NSString *carportNum;

@property (nonatomic, copy) NSString *meid;

@property (nonatomic, copy) NSString *bindCode;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, assign) NSInteger shareStatus;

@property (nonatomic, assign) NSInteger lockStatus;

///-- <#Notes#>
@property (nonatomic, assign) BOOL bind;
@end
