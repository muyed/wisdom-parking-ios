//
//  PINoticeModel.h
//  Parking
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PINoticeData;

@interface PINoticeModel : NSObject

///-- 状态
@property (nonatomic, assign) NSInteger code;
///-- 错误信息
@property (nonatomic, copy) NSString *errMsg;
///-- 数据
@property (nonatomic, strong) NSArray<PINoticeData *> *data;

@end

@interface PINoticeData : NSObject

///-- 内容
@property (nonatomic, copy) NSString *body;
///-- 创建时间
@property (nonatomic, assign) NSInteger createTime;
///-- id
@property (nonatomic, copy) NSString *ID;
///-- 认证时间
@property (nonatomic, assign) NSInteger modifyTime;
///-- <#Notes#>
@property (nonatomic, copy) NSString *ranges;
///-- <#Notes#>
@property (nonatomic, copy) NSString *sorts;
///-- 状态
@property (nonatomic, assign) NSInteger status;
///-- 标题
@property (nonatomic, copy) NSString *title;
@end
