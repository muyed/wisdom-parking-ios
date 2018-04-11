//
//  PIAddressModel.h
//  Parking
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIAddressModel : NSObject

/**
 poi的id
 */
@property (nonatomic, copy) NSString *uid;

/**
 名称
 */
@property (nonatomic, copy) NSString *name;

/**
 区域编码
 */
@property (nonatomic, copy) NSString *adcode;

/**
 所属区域
 */
@property (nonatomic, copy) NSString *district;

/**
 地址
 */
@property (nonatomic, copy) NSString *address;

/**
 纬度（垂直方向
 */
@property (nonatomic, assign) double latitude;

/**
 经度（水平方向）
 */
@property (nonatomic, assign) double longitude;

@end
