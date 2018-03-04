//
//  PIBaseModel.h
//  Parking
//
//  Created by apple on 2018/2/18.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIBaseModel : NSObject

///--  编码
@property (nonatomic, assign) NSInteger code;
///-- 数据
@property (nonatomic, copy) NSString *data;
///-- 错误信息
@property (nonatomic, copy) NSString *errMsg;
@end
