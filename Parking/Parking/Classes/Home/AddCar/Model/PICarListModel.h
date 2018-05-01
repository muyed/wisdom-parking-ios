//
//  PICarListModel.h
//  Parking
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PICarDataModel;

@interface PICarListModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误原因
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) NSMutableArray <PICarDataModel *> *data;

@end


@interface PICarDataModel : NSObject

///-- 时间
@property (nonatomic, copy) NSString *createTime;
///-- id
@property (nonatomic, copy) NSString *ID;
///-- 车牌
@property (nonatomic, copy) NSString *license;
///-- <#Notes#>
@property (nonatomic, copy) NSString *modifyTime;
///-- <#Notes#>
@property (nonatomic, copy) NSString *ranges;
///-- <#Notes#>
@property (nonatomic, copy) NSString *sorts;
///-- 用户ID
@property (nonatomic, copy) NSString *userId;
@end


