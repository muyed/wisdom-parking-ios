//
//  PIMyParkModel.h
//  Parking
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PIMyParkDataModel;

@interface PIMyParkModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误原因
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) NSArray <PIMyParkDataModel *> *data;

@end

@interface PIMyParkDataModel : NSObject

///-- 名字
@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *carportId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *deposit;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *parent;

@property (nonatomic, copy) NSString *payNum;

@property (nonatomic, copy) NSString *ranges;

@property (nonatomic, copy) NSString *sorts;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *addr;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *communityName;

@property (nonatomic, copy) NSString *carportNum;
@end
