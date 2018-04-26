//
//  PILoginModel.h
//  Parking
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIAcountModel.h"

@class PILoginDataModel;

@interface PILoginModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误原因
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) PILoginDataModel *data;

@end

@class PIMyVillageDataModel;
@class PIMyParkDataModel;


@interface PILoginDataModel : NSObject

///-- 姓名
@property (nonatomic, copy) NSString *realName;
///-- <#Notes#>
@property (nonatomic, copy) NSString *accountCashConf;
///-- <#Notes#>
@property (nonatomic, copy) NSString *overdueMultipleCon;
///-- 身份认证
@property (nonatomic, copy) NSString *identityCard;
///-- <#Notes#>
@property (nonatomic, copy) NSString *carportCashConf;
///-- <#Notes#>
@property (nonatomic, copy) NSString *payDeadlineMinConf;
///-- <#Notes#>
@property (nonatomic, strong) NSArray<PIMyVillageDataModel *> *communityList;
///-- <#Notes#>
@property (nonatomic, strong) NSArray<PIMyParkDataModel *> *userCarportList;

@property (nonatomic, strong) PIAcountModel *account;

@end


